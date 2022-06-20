variable "instance_type" {}
variable "key_name" {}
variable "webserver_sg_id" {}
variable "postgres_ip" {}

variable "asg_desired" {
  type    = number
  default = 1
}
variable "asg_max_size" {
  type    = number
  default = 1
}
variable "asg_min_size" {
  type    = number
  default = 1
}

variable "subnets" {}
variable "alb_dns" {}
variable "target_group_arns" {}

variable "iam_instance_profile_name" {}