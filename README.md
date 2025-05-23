# Sample and basic Modular AWS resource provionsioning with terraform

## 📌 Get Started

`git clone https://github.com/growfatlikeme/modular-aws.git`

> [!IMPORTANT]
> Keypair.tf is not uploaded, and should be created on your own.
> It defines the keypair I am using for instances that I can SSH into using a locally available private.pem file, and uploading the public .pem file onto AWS.

> [!NOTE]
> Variables are defined in dev.tfvars, for future flexibility to invoke another environment with different value such as for QA, Prod in another .tfvars file.

## :running: Running the code locally

`terraform init`
`terraform plan -var-file="dev.tfvars" `
`terraform apply -var-file="dev.tfvars" -lock=false -target=aws_dynamodb_table.terraform_state_lock`
`terraform apply -var-file="dev.tfvars" -lock=false `
`terraform destroy -var-file="dev.tfvars" -lock=false`

## :sunglasses: Modules introduction

**_root directory_** - invokes modules to run

**app_topics\*** - create AWS Simple Notification Service (SNS) topic

**_compute_** - this is where bastion host gets created, simply set subnet_id value to private subnet if instances is to be created in private subnet instead.

**_databases_** - create DynamoDB (nosql) and RDS (sql) database

**_ebs_** - defining elastic block storage for attaching to an ec2 instance

**_iam_** - Roles, policies, instance profile.

**_network_** - everything relies on this module being ran first, creating VPC with public, private, database subnet with IGW routing in public subnet and NGW for private subnet internet access.

**_scaling_web_** - Launch template, autoscaling group, load balancer, route53 and certificate manager resources

**_security_** - keypair[.]tf (to be created on your own), security group

**_storage_** - s3 bucket for tfstate storing (not in use now), s3 bucket for public static site hosting

**_web_app_** - started off as a simple private instance, now updated to be 1 single public ec2 instance to be provision while running sample lab code for test purpose.
