resource "aws_iam_role" "eks_cluster" {
  name = "${var.project_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "eks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role = aws_iam_role.eks_cluster.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


resource "aws_iam_role" "eks_nodes" {
  name = "${var.project_name}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "worker_node_policy" {
  role = aws_iam_role.eks_nodes.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}


resource "aws_iam_role_policy_attachment" "cni_policy" {
  role = aws_iam_role.eks_nodes.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}


resource "aws_iam_role_policy_attachment" "ecr_policy" {
  role = aws_iam_role.eks_nodes.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


resource "aws_security_group" "eks_cluster" {
  name        = "${var.project_name}-eks-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTPS from VPC"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = "Allow all outbound traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-eks-cluster-sg"
  }
}


resource "aws_eks_cluster" "main" {
  name = "${var.project_name}-cluster"

  role_arn = aws_iam_role.eks_cluster.arn

  version = var.kubernetes_version

  vpc_config {
    subnet_ids = var.subnet_ids

    security_group_ids = [
      aws_security_group.eks_cluster.id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]

  tags = {
    Name = "${var.project_name}-cluster"
  }
}


resource "aws_eks_node_group" "main" {
  cluster_name = aws_eks_cluster.main.name

  node_group_name = "${var.project_name}-nodes"

  node_role_arn = aws_iam_role.eks_nodes.arn

  subnet_ids = var.subnet_ids

  instance_types = [
    var.node_instance_type
  ]

  scaling_config {
    desired_size = var.desired_nodes
    min_size     = var.min_nodes
    max_size     = var.max_nodes
  }

  capacity_type = "ON_DEMAND"

  disk_size = 30

  depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_policy
  ]

  tags = {
    Name = "${var.project_name}-worker-nodes"
  }
}

resource "aws_iam_policy" "jenkins_ecr" {
  name = "${var.project_name}-jenkins-ecr-policy"

  description = "Allow Jenkins to push Docker images to ECR"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ecr:GetAuthorizationToken"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]

        Resource = "*"
      }
    ]
  })
}

data "aws_iam_policy_document" "jenkins_assume_role" {

  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.eks.arn
      ]
    }

    condition {

      test = "StringEquals"

      variable = "${replace(
        aws_eks_cluster.main.identity[0].oidc[0].issuer,
        "https://",
        ""
      )}:sub"

      values = [
        "system:serviceaccount:jenkins:jenkins"
      ]
    }
  }
}


resource "aws_iam_role" "jenkins" {

  name = "${var.project_name}-jenkins-role"

  assume_role_policy = data.aws_iam_policy_document.jenkins_assume_role.json
}


resource "aws_iam_role_policy_attachment" "jenkins_ecr" {

  role = aws_iam_role.jenkins.name

  policy_arn = aws_iam_policy.jenkins_ecr.arn
}