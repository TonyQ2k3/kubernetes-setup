variable "db_identifier" {
  description = "The identifier for the database instance."
  type        = string
  default     = "my-database-instance"
}

variable "db_allocated_storage" {
  description = "The amount of storage (in gigabytes) to allocate for the database instance."
  type        = number
  default     = 8
}

variable "db_name" {
  description = "The name of the database to create."
  type        = string
  default     = "my-database"
}

variable "db_engine" {
  description = "The database engine to use (e.g., mysql, postgres)."
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "The version of the database engine to use."
  type        = string
  default     = "8.4.5"
}

variable "db_instance_class" {
  description = "The instance class for the database (e.g., db.t3.micro)."
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "The username for the database."
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The password for the database."
  type        = string
  sensitive   = true
  default     = "password"
}

variable "vpc_security_group_ids" {
  description = "A list of VPC security group IDs to associate with the database instance."
  type        = list(string)
  default     = []
}