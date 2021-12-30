
####################################################
# Variables
####################################################
variable "region" {
  default = "us-west-2"
}

variable "availability_zone" {
  default = "us-west-2a"
}

variable "profile" {
  default = "default"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "public_subnet_cidr" {
  default = "172.16.0.0/24"
}

variable "my_ip_address" {
  default = "198.27.162.221/32"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "root_device" {
  type = object({
    size                  = number
    type                  = string
    delete_on_termination = bool
  })

  default = {
    size                  = 8
    type                  = "gp3"
    delete_on_termination = true
  }
}

variable "ebs_device" {
  type = object({
    name                  = string
    size                  = number
    type                  = string
    delete_on_termination = bool
  })

  default = {
    name                  = "/dev/xvdd"
    size                  = 1
    type                  = "gp3"
    delete_on_termination = true
  }
}

variable "ssh_key_name" {
  default = "ec2-ebs-web"
}