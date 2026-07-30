## Datasource for the jenkins controller
data "aws_ami" "jenkins_master" {
  filter {
    name   = "name"
    values = ["Jenkins-master-*"]
  }

  most_recent = true
  owners      = ["self"]
}