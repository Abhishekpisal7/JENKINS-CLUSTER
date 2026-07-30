output "jenkins_controller_private_ip" {
  description = "Private IPV4 address of the Jenkins controller"
  value = {
    for k, instance in aws_instance.jenkins_master :
    k => instance.private_ip
  }
}


output "jenkins_controller_id" {
  description = "Id of the jenkins controller"
  value = {
    for k, instance in aws_instance.jenkins_master :
    k => instance.id
  }
}