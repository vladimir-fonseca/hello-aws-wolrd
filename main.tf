terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    local = {
      version = ">= 2.1.0"
    }
    template = {
      version = ">= 2.2.0"
    }
    tls = {
      version = ">= 3.1.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "web" {
  template = file(
    "${path.module}/scripts/apache-deployment.tfl"
  )
  vars = {
    DEVICE_NAME = var.ebs_device.name
    DEVICE_SIZE = var.ebs_device.size
  }
}

data "template_cloudinit_config" "web" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.web.rendered
  }
}

data "aws_iam_policy_document" "web" {
  statement {
    sid = "webTrustPolicy"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    effect = "Allow"
  }
}
