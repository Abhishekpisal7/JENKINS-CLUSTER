## datasource for the jenkins agent
data "aws_ami" "jenkins_agent_ami" {
  filter {
    name   = "name"
    values = ["jenkins-agent-*"]
  }

  most_recent = true
  owners      = ["self"]
}