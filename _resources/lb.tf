// LB for web server
resource "aws_lb" "web" {
  name               = "greatapp-alb-${var.env}"
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.lb_sg.id}"]
  subnets            = ["${aws_subnet.public_web_1.id}", "${aws_subnet.public_web_2.id}"] # same availability zone as our instance
}

resource "aws_lb_listener" "http" {
  port              = "80"
  protocol          = "HTTP"
  load_balancer_arn = "${aws_lb.web.arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.web.arn}"
  }
}

# If need to config ssl protocal
# resource "aws_lb_listener" "https" {
#   port              = "443"
#   protocol          = "HTTPS"
#   load_balancer_arn = "${aws_lb.web.arn}"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "${var.acm_cert_arn}"

#   default_action {
#     type             = "forward"
#     target_group_arn = "${aws_lb_target_group.web.arn}"
#   }
# }

resource "aws_lb_target_group" "web" {
  name     = "greatapp-lb-tg-${var.env}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.greatapp_vpc.id}"
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_lb_target_group.web.arn}"
  target_id        = "${aws_instance.greatapp_web.id}"
  port             = 80
}
