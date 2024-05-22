variable "REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0e001c9271cf7f3b9"
  }
}

variable "PRIV_KEY" {
  default = "testkey"
}

variable "PUB_KEY" {
  default = "testkey.pub"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "RMQUSER" {
  default = "rabbit"
}

variable "RMQPASS" {
  default = "syco@1234567890"
}

variable "DBNAME" {
  default = "accounts"
}

variable "DB_IDENTIFIER" {
  default = "test-db-instance"
}

variable "DBPASS" {
  default = "admin123"
}

variable "DBUSER" {
  default = "admin"
}

variable "ins_cnt" {
  default = "1"
}

variable "VPC_NAME" {
  default = "terraform_vpc"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1b"
}

variable "ZONE3" {
  default = "us-east-1c"
}

variable "VPC_CIDR" {
  default = "172.21.0.0/16"
}

variable "PUBSUB1CIDR" {
  default = "172.21.1.0/24"
}

variable "PUBSUB2CIDR" {
  default = "172.21.2.0/24"
}

variable "PUBSUB3CIDR" {
  default = "172.21.3.0/24"
}

variable "PRIVSUB1CIDR" {
  default = "172.21.4.0/24"
}

variable "PRIVSUB2CIDR" {
  default = "172.21.5.0/24"
}

variable "PRIVSUB3CIDR" {
  default = "172.21.6.0/24"
}
