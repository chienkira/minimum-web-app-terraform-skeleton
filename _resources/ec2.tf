resource "aws_instance" "greatapp_web" {
  ami                         = "ami-0064e711cbc7a825e"             # Amazon Linux 2 AMI
  instance_type               = "${var.ec2_instance_type}"
  key_name                    = "${var.aws_key_name}"               # Must create key pair first from AWS console
  vpc_security_group_ids      = ["${aws_security_group.web_sg.id}"]
  subnet_id                   = "${aws_subnet.public_web.id}"
  associate_public_ip_address = "true"
  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.ec2_disk_size}"
  }
  tags = {
    Name = "greatapp_web_${var.env}"
  }
}

# EIP to assign static IP with EC2
resource "aws_eip" "greatapp_web_eip" {
  vpc  = true
  instance = "${aws_instance.greatapp_web.id}"
  tags = {
    Name = "greatapp_web_eip_${var.env}"
  }
}
