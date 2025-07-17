resource "aws_db_instance" "database" {
  identifier          = var.db_identifier
  allocated_storage   = var.db_allocated_storage
  db_name             = var.db_name
  
  engine              = var.db_engine
  engine_version      = var.db_engine_version
  instance_class      = var.db_instance_class

  username            = var.db_username
  password            = var.db_password

  skip_final_snapshot = true
  multi_az            = false
  publicly_accessible = true

  # vpc_security_group_ids = var.vpc_security_group_ids

  timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
  }
}