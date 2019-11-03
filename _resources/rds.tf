resource "aws_db_instance" "greatapp_db" {
  identifier              = "greatapp-db-${var.env}"
  allocated_storage       = "${var.rds_disk_size}"
  max_allocated_storage   = "${var.rds_max_disk_size}"
  backup_retention_period = 7
  engine                  = "postgres"
  instance_class          = "${var.rds_instance_class}"
  name                    = "greatapp"
  username                = "postgres"
  password                = "${var.rds_password}"
  publicly_accessible     = true
  vpc_security_group_ids  = ["${aws_security_group.web_sg.id}"]
  db_subnet_group_name    = "${aws_db_subnet_group.greatapp_subnet_group.name}"
  skip_final_snapshot     = true
}
