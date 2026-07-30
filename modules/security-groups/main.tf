## Security group for the bastion host
resource "aws_security_group" "bastion_host_sg" {
  name        = "Bastion-Host-SG"
  description = "This is the securtiy group for the bastion server"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow the SSH protocol"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all traffic to egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "bastion-host-security-group"
    }
  )
}

## Security group for the jenkins master
resource "aws_security_group" "jenkins_master_sg" {
  name        = "jenkins-master-sg"
  description = "The security group for the jenkins master"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow the SSH traffic to the instance"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_host_sg.id]
  }

  ingress {
    description = "Allow the traffic to the jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "jenkins-master-security-group"
    }
  )
}

## Security group for the jenkins lb
resource "aws_security_group" "jenkins_lb_sg" {
  name        = "jenkins-lb-sg"
  description = "security group for the jenkins load balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow the http traffic to the jenkins load balancer"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow the all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "jenkins-lb-security-group"
    }
  )
}

## Security group for the jenkins agent
resource "aws_security_group" "jenkins_agent_sg" {
  name        = "jenkins-agent-sg"
  description = "Security group for the jenkins agent"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow the SSH traffic to agent"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_master_sg.id]
  }

  egress {
    description = "Allow the all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "jenkins-agent-sg"
    }
  )
}