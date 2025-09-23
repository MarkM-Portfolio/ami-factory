# ami-factory
<!-- AMI Factory to build images for WIN 2K19.
AMI Factory to build images for WIN 2K19 SQL CORE. -->
AMI Factory to build images for SAP HANA/B1.

## terraform

This directory contains the terraform to be used for deploying resources. The structure should remain the same as outlined in the template.

* `modules` - Directory to store modules for the AMI factory.
* `data.tf` - Calls _all_ [data](https://www.terraform.io/language/data-sources) sources.
* `locals.tf` - [local](https://www.terraform.io/language/values/locals) values. Unlike input variables these should not be set directly by users of the configuration.
* `main.tf` - calls all modules to create resources.
* `outputs.tf` - contains outputs from the resources created in `main.tf`.
* `terraform.tfvars` - contains input variables to be directly set by the user.
* `variables.tf` - contains declarations of variables used in `main.tf`.
* `versions.tf` - contains providers and version requirements for Terraform.

There may be a case for a developer bending the rules in certain scenarios. For example, if there is a large configuration of resource specific modules, it may be cleaner and more readable for the project if these are broken out into their own `_service/resource_.tf` file. eg: 

* `iam.tf` - to contain a large amount of role

This decision will be left to developer discretion and reviewed upon pull request.

### Naming Conventions

#### General conventions

1. Use _ (underscore) instead of - (dash) everywhere (resource names, data source names, variable names, outputs, etc).
2. Prefer to use lowercase letters and numbers (even though UTF-8 is supported).

> ⚠️ Beware that actual cloud resources often have restrictions in allowed names. Some resources, for example, can't contain dashes, some must be camel-cased. The conventions in this readme refer to Terraform names themselves (and not physical resource names - these should follow the naming convention set out in the design).

#### Resource and data source arguments

1. Do not repeat resource type in resource name (not partially, nor completely):

> ✅ &nbsp;`resource "aws_route_table" "public" {}`

> ❌ &nbsp;`resource "aws_route_table" "public_route_table" {}`

### Usage

```

$ terraform init
$ terraform plan
$ terraform apply

```

## packer

This directory contains the packer configurations for the AMI factory