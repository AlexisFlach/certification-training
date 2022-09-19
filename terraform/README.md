### Terraform

###### Certification

https://www.hashicorp.com/certification/terraform-associate

###### Notes based on

https://www.youtube.com/watch?v=V4waklkBC38&ab_channel=freeCodeCamp.org


#### Sections


#### Terraform basics

01. Terraform Lifecycle

1. Code
Write or Update your Terraform configuration file.

2. init
Initialize your project or Pull latest providers and modules.

3. plan
Speculate what will change or Generate a saved execution plan

4. validate
When you run plan, validate happends automatically, but you could also run it separetly.
Ensures types and values are valid.
Ensured required attributes are present.

5. apply
Execute the terraform plan provisioning the infrastructure.

5.1 destroy
You could chose to destroy your infrastructure with a destroy flag or the terraform destroy command.

1. Code again and update your code.

And there is the terraform lifecycle.


02. Change Automation

To understand change automation, we first need to understan Change Management:

a Standard approach to apply change, and resolving conflict brought about by change. 

In the context of IaC, Change Management is the procedure that will be followed when resources are modified and applied via configuration scripts.

Change Automation:

a way of automatically creating consistent, systematic, and predictable way of managing change requests via controls and policies.

Terraform uses Change Automation in the form of Execution Plans and Resource Graphs to apply and review complex changesets.

What is a ChangeSet?

A collection of commits that represent changes made to a versioning repository. IaC uses ChangeSets so you can see what has changed by who over time.

Change Automation allows you to know exactly what Terraform will change and in what order, avoiding many possible human errors.


03. Execution Plans

An Execution Plan is a manual review of what will add, change or destroy before you apply changes eg terraform apply.

Resources and config settings will be listed.

It will indicate what will be added, changed or destroyed if this plan is approved.

04. Visualizing Execution Plans

You can visualize an execution plan as a graph using terraform graph command. It will output a GraphViz file.

You need to have it installed on your machine.

```
terraform graph | dot -Tsvg > graph.svg
```

04. Resource Graph

Terraform("T") builds a dependency graph from T configurations, and walks this graph to generate plans, refresh state, and more.

terraform graph is a visual representation of the dependency graph.

Like nodes with relationships to other nodes.

Resource Node
Represents a single resource

Represents Meta-Node
represents a group of resources, but does not represent any actions on its own.

Provider Configuration Node
Represents the time to fully configure a provider.

05. Use Cases

IaC for Exotic Providers
T supports a many providers, not only the usual suspects.

open-source and extendable.

Multi-Tier Applications
T ny default makes it easy to divide large and complex applications into isolate configurations scripts(modules).

Disposable Environments
Easily stand up and env for a software demo or a temp dev env.

Resource Schedulers
Can be used to dynamic schedule Docker Containers. You can provision your own scheduling grid.

Multi-Cloud Deployment
T is cloud-agnostic and allows a single configuration to be used to manage multiple providers, and to even handle cross-cloud dependencies.


06. Terraform Core and Terraform Plugins

T is logically split into two main parts:

1. Terraform Core
Uses remote procedure calls (RPC) to communicate with Terraform Plugins.

2. Terraform Plugins
Expose an implementation for a specific service, or provisioner.

07. Terraform Up and Running

Extra resource: O'Reilly book.

08. Terraform Best Practises

terraform-best-practises.com

09. Terraform install

https://learn.hashicorp.com/tutorials/terraform/install-cli

10. CLI and configuration

https://registry.terraform.io/providers/hashicorp/aws/latest

```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}

provider "aws" {
    profile = "default"
    region  = "us-east-1"
}

resource "aws_instance" "my_server" {
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"

  tags = {
    Name = "MyService"
  }
}
```

11. Terraform init

```
terraform init
```

init pulls whatever providers and modules we have defined. Two new things are created.

.terraform.lock.hcl is the dependency lock file. Basically saying what things and what version of them we are using.

.terraform file has information about our providers, a binary file.

```
terraform fmt
```

```
terraform validate
```

Useful to check if you have all fields that are mandatory.

12. Terraform Plan and Apply

```
terraform plan
```

Creates a specalutive plan of what it would deploy.

```
terraform apply
```

Starts creating the aws infrastructure.


13. terraform Apply Update


Infrastructure code i idempodent. If we run apply again, we are not goint to end up with an additional resource, it's simply going to be changed.


14. Inputs Variables

```
variable "instance_type" {
  type = string
}

resource "aws_instance" "my_server" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = var.instance_type

  tags = {
    Name = "MyService"
  }
}
```

```
terraform plan -var=instance_type="t2.micro"
```

Better:

touch terraform.tfvars

instance_type = "t2.micro"

terraform plan

terraform apply

15. Local Values

A way of DRYing your code.

```
variable "instance_type" {
  type = string
}

locals {
  project_name = "terraform-aws"
}

resource "aws_instance" "my_server" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = var.instance_type

  tags = {
    Name = "MyService-${local.project_name}"
  }
}
```


16. Outputs

A way to get an outputed value.

```
output "instance_ip_address" {
  value = aws_instance.my_server.public_ip 
}
```

terraform refresh

refresh is a command that makes the state file match the external instance.

terraform output


17. Modules

A Terraform module is a set of Terraform configuration files in a single directory.

```
provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  alias   = "eu"
}

module "vpc" {
  source   = "terraform-aws-modules/vpc/aws"
  providers = {
    aws =  aws.eu 
   }
  name     = "my-vpc"
  cidr     = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

18. Divide files

providers.tf
variables.tf

19. Terraform Destroy

```
terraform apply -destroy
```

20. Terraform Cloud

https://learn.hashicorp.com/tutorials/terraform/cloud-migrate

Create a Terraform Cloud workspace

```
terraform workspace list
```

We need to define a backend.

1.59.19




