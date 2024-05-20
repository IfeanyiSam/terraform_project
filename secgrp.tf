resource "aws_security_group" "test-bean-elb-sg" {
  name        = "test-bean-elb-sg"
  description = "security group for bean-elb"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "test-bastion-sg" {
  name        = "test-bastion-sg"
  description = "security group of bastion host"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "test-instance-sg" {
  name        = "test-instance-sg"
  description = "security group for beanstalk instances"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.test-bastion-sg.id]
  }
}

resource "aws_security_group" "test-backend-sg" {
  name        = "test-backend-sg"
  description = "security group for RDS, Active MQ and Elastic Cache"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    protocol        = "tcp"
    to_port         = 0
    security_groups = [aws_security_group.test-instance-sg.id]
  }
}

resource "aws_security_group_rule" "sec-group-for-itself" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.test-backend-sg.id
  source_security_group_id = aws_security_group.test-backend-sg.id
}