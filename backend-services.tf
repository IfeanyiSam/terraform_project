resource "aws_db_subnet_group" "test-rds-subgrp" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "subnet group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "test-elca-subgrp" {
  name       = "test-elca-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "subnet group for Elastic Cache"
  }
}

resource "aws_db_instance" "test-rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  engine_version         = "8.0"
  db_name                = var.DBNAME
  identifier             = var.DB_IDENTIFIER
  username               = var.DBUSER
  password               = var.DBPASS
  parameter_group_name   = "default.mysql8.0"
  multi_az               = "false"
  publicly_accessible    = "false"
  skip_final_snapshot    = "true"
  db_subnet_group_name   = aws_db_subnet_group.test-rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.test-backend-sg.id]
}

resource "aws_elasticache_cluster" "test-elca" {
  cluster_id           = "test-elca"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.test-backend-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.test-elca-subgrp.name

}

resource "aws_mq_broker" "test-rmq" {
  broker_name        = "test-rmq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.17.6"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.test-backend-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]

  user {
    username = var.RMQUSER
    password = var.RMQPASS
  }
}