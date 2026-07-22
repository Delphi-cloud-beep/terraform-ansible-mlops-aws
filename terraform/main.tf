# Security Group (Pare-feu)
resource "aws_security_group" "mlops_sg" {
  name        = "mlops-sg-${var.environment}"
  description = "Autoriser SSH, MLflow, Prometheus et Grafana"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Image Ubuntu 22.04 LTS
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Serveur EC2
resource "aws_instance" "mlops_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  
  key_name               = aws_key_pair.mlops_key.key_name
  vpc_security_group_ids = [aws_security_group.mlops_sg.id]

  tags = {
    Name        = "MLOps-Server-${var.environment}"
    Environment = var.environment
  }
}

# Bucket S3 pour les artefacts ML
resource "aws_s3_bucket" "ml_artifacts" {
  bucket        = "mlops-artifacts-delphi-cloud-beep-${var.environment}"
  force_destroy = true
}

resource "aws_key_pair" "mlops_key" {
  key_name   = "mlops-key"
  public_key = var.public_key
}