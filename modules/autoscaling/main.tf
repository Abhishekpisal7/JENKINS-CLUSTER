## launch template for the jenkins agent
resource "aws_launch_template" "jenkins_agent_template" {
  name_prefix            = "jenkins-agent-"
  description            = "This is the launch template of jenkins agent deployed in the private subnet"
  image_id               = data.aws_ami.jenkins_agent_ami.id
  instance_type          = var.jenkins_agent_instance_type
  key_name               = var.jenkins_agent_key_name
  vpc_security_group_ids = [var.jenkins_agent_sg_id]

  user_data = base64encode(
    templatefile("../../files/autojoining_agent.sh.tftpl",
      {
        jenkins_url            = "http://${values(var.jenkins_private_ip)[0]}:8080"
        jenkins_username       = var.jenkins_username
        jenkins_password       = var.jenkins_password
        jenkins_credentials_id = var.jenkins_credentials_id
    })
  )

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.common_tags,
      {
        "Name" = "jenkins-agent-template"
      }
    )
  }
}

## autoscaling group
resource "aws_autoscaling_group" "jenkins_agent_autoscaling_group" {
  name_prefix         = "jenkins-agnet-asg-"
  min_size            = 1
  max_size            = 4
  vpc_zone_identifier = values(var.private_subnet_id)

  health_check_type         = "ELB"
  health_check_grace_period = 60

  launch_template {
    id      = aws_launch_template.jenkins_agent_template.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

}

## Scaling policy for the jenkins agent
resource "aws_autoscaling_policy" "jenkins_agent_autoscaling_policy" {
  name                   = "jenkins-agent-scaling-policy"
  autoscaling_group_name = aws_autoscaling_group.jenkins_agent_autoscaling_group.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 60
  }
}