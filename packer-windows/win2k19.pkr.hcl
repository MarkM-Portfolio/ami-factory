packer {
  required_plugins {
    ansible-windows = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
  }
}

packer {
  required_plugins {
    amazon-windows = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

variable "ami_prefix_win" {
  type    = string
  default = "packer-aws-win2k-19"
}

locals {
  timestamp_win = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "windows" {
  ami_name      = "${var.ami_prefix_win}-${local.timestamp_win}"
  instance_type = "t2.micro"
  region        = "eu-west-2"
  vpc_id = "vpc-004c53d85a01d4bdc"
  subnet_id = "subnet-06b518a85192ffae5"
  associate_public_ip_address = true
  source_ami_filter {
    filters = {
      name                = "W2K19_UK_BASE_AMI_*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["040572446079"]
  }
  ssh_username = "ec2-user"
}

build {
  name    = "packer-windows"
  sources = [
    "source.amazon-ebs.windows"
  ]

  provisioner "ansible" {
      playbook_file = "../ansible/playbook.yml"
    }
}
