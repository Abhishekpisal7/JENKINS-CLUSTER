## Load balancer for the jenkins controller
resource "aws_lb" "jenkins_lb" {
  name               = "jenkins-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.jenkins_lb_sg_id]
  subnets            = values(var.public_subnet_id)

  tags = merge(
    var.common_tags,
    {
      "Name" = "jenkin-load-balancer"
    }
  )
}

## target group for the jenkins lb
resource "aws_lb_target_group" "jenkins_lb_targert_group" {
  name_prefix = "jen-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-399"
    enabled             = true
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "jenkins-lb-tg"
    }
  )
}

## jenkins load balancer listener
resource "aws_lb_listener" "jenkins_lb_listener" {
  load_balancer_arn = aws_lb.jenkins_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_lb_targert_group.arn
  }
}

## jenkins lb attachement
resource "aws_lb_target_group_attachment" "jenkins_lb_targert_group" {
  for_each         = tomap(var.jenkins_master_id)
  target_group_arn = aws_lb_target_group.jenkins_lb_targert_group.arn
  target_id        = each.value
  port             = 8080

  depends_on = [aws_lb_target_group.jenkins_lb_targert_group]
}
