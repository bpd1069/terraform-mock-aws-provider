# Terraform Mock AWS Provider With Docker and LocalStack

terraform-mock-aws-prodiver: Sandbox with Amazon Linux and Terraform. AWS APIS are mocked with Localstack.

## How to Install?
```bash
git clone https://github.com/herrera-luis/terraform-mock-aws-provider.git
cd terraform-mock-aws-provider/
./terraform-docker.sh build
```

## How to Run?
Terminal 1
```bash
./terraform-docker.sh localstack
```
## Create AWS Mock Resources
Terminal 2
```bash
./terraform-docker.sh run
```
```bash
Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.34"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
aws_s3_bucket.b: Creating...
  acceleration_status:         "" => "<computed>"
  acl:                         "" => "public-read"
  arn:                         "" => "<computed>"
  bucket:                      "" => "my-tf-mock-test-bucket"
  bucket_domain_name:          "" => "<computed>"
  bucket_regional_domain_name: "" => "<computed>"
  force_destroy:               "" => "false"
  hosted_zone_id:              "" => "<computed>"
  region:                      "" => "<computed>"
  request_payer:               "" => "<computed>"
  versioning.#:                "" => "<computed>"
  website_domain:              "" => "<computed>"
  website_endpoint:            "" => "<computed>"
aws_s3_bucket.b: Creation complete after 0s (ID: my-tf-mock-test-bucket)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

address = my-tf-mock-test-bucket
```

## Show your AWS Mock

goto: http://localhost:8080/#/infra

![img-1](img/localstack-s3-mock.png) 


## Destroy AWS Mock Resources

```bash
./terraform-docker.sh destroy
```
```bash
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

aws_s3_bucket.b: Refreshing state... (ID: my-tf-mock-test-bucket)

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  ~ aws_s3_bucket.b
      object_lock_configuration.#:            "1" => "0"
      replication_configuration.#:            "1" => "0"
      server_side_encryption_configuration.#: "1" => "0"


Plan: 0 to add, 1 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

aws_s3_bucket.b: Refreshing state... (ID: my-tf-mock-test-bucket)
aws_s3_bucket.b: Destroying... (ID: my-tf-mock-test-bucket)
aws_s3_bucket.b: Destruction complete after 0s

Destroy complete! Resources: 1 destroyed.
```

## How do make changes in terraform ?

Juts go to src/main.tf and do you code there. There are specific configs there in order to mock aws with localstack.
