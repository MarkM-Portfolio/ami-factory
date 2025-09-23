packer {
  required_plugins {
    ansible-suse = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
  }
}

packer {
  required_plugins {
    amazon-suse = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

variable "ami_prefix_suse" {
  type    = string
  default = "packer-aws-suse-15-sp3"
}

locals {
  timestamp_suse = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "suse" {
  ami_name      = "${var.ami_prefix_suse}-${local.timestamp_suse}"
  instance_type = "t2.micro"
  region        = "eu-west-2"
  vpc_id = "vpc-004c53d85a01d4bdc"
  subnet_id = "subnet-06b518a85192ffae5"
  associate_public_ip_address = true
  source_ami_filter {
    filters = {
      tag:Name            = "sap-b1-prepared"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["040572446079"]
  }
  ssh_username = "ec2-user"
}

build {
  name    = "packer-suse"
  sources = [
    "source.amazon-ebs.suse"
  ]

  provisioner "ansible" {
      playbook_file = "../ansible/playbook.yml"
    }
}
