resource "aws_instance" "nodes" {
  ami                    = "ami-0e2c8caa4b6378d8c"
  instance_type          = "t2.medium"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = "linux-kp"
  root_block_device {
    volume_size = 20
  }
  count = var.node_count
  tags = {
    Name = "node-${count.index + 1}"
  }
}