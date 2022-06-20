variable "key_name" {
  type = string
}

variable "environment" {
  type    = string
  default = "demo"
}

variable "app_instance_type" {
  type = string
}

variable "db_instance_type" {
  type = string
}

variable "subnet_a_id" {
  type = string
}

variable "subnet_b_id" {
  type = string
}

variable "webserver_sg_id" {
  type = string
}

variable "postgres_sg_id" {
  type = string
}

variable "alb_dns" {
  type = string
}

variable "web_target_group_arn" {
  type = string
}

variable "api_target_group_arn" {
  type = string
}

variable "iam_instance_profile_name" {
  type = string
}
