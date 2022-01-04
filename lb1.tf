provider "aws" {
  profile = "default"
  region = "us-east-2"
}
resource "aws_lb" "slave" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-0862e0d8235267a61"]
  subnets            = ["subnet-04ae13ffb84d8c3fc","subnet-068f110e30613dcfc","subnet-0017b80df448722c1"]
}
resource "aws_lb_target_group" "slave" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0ed8dd3b7437ee13b"
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.slave.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.slave.arn
  }
}
resource "aws_lb_target_group_attachment" "slave" {
  target_group_arn = aws_lb_target_group.slave.arn
  target_id        = "i-060c990e69a4ed8d9"
  port             = 80
}
