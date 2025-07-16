resource "aws_db_instance" "database" {
    identifier           = var.db_identifier
    allocated_storage    = var.db_allocated_storage
    db_name              = var.db_name
    engine               = var.db_engine
    engine_version       = var.db_engine_version
    instance_class       = var.db_instance_class
    username             = var.db_username
    password             = var.db_password
    multi_az             = false

    timeouts {
        create = "3h"
        delete = "3h"
        update = "3h"
    }
}