resource "aws_instance" "test-bastion" {
  ami                    = lookup(var.AMIS, var.REGION)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.terraformkey.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.ins_cnt
  vpc_security_group_ids = [aws_security_group.test-bastion-sg.id]

  tags = {
    Name    = "test-bastion"
    Project = "test"
  }

  provisioner "file" {
    content     = templatefile("templates/db-deploy.tftpl", { rds_endpoint = aws_db_instance.test-rds.address, dbuser = var.DBUSER, dbpass = var.DBPASS })
    destination = "/tmp/vprofile-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vprofile-dbdeploy.sh",
      "sudo /tmp/vprofile-dbdeploy.sh"
    ]
  }

  connection {
    user        = var.USERNAME
    private_key = file(var.PRIV_KEY)
    host        = self.public_ip
  }
  depends_on = [aws_db_instance.test-rds]

}