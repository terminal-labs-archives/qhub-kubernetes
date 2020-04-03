# Installation

## Environment Variables

This deployment along with the GitHub Actions assumes several
environment variables are present. Since the crowdsmart deployment is
on AWS we require:

 - AWS_ACCESS_KEY_ID
 - AWS_SECRET_ACCESS_KEY
 - AWS_DEFAULT_REGION

Note that the AWS IAM user must have extensive permissions since the
role will be creating eks, s3, ecr, iam, and vpc resources.

## Bootstrapping

Terraform is used for all deployments of infrastructure as well as
kubernetes state. In order to use Infrastructure as code with
repositories we need somewhere to store the terraform state in between
invocations. The default is to store the state in the local git
repository which is not ideal for several reasons including checking
in secrets to the repository. The most common remote backend is using
an AWS S3 bucket with DynamoDB. S3 is used to store the terraform json
state file while DynamoDB is used to lock the terraform update process
so that the infrastructure/cluster can only be update in a serial
fashion.

The [terraform-state](../terraform-state) directory deploys this
infrastructure. Currency this bucket is named
`crowdsmart-terraform-state` with the DynamoDB table named
`crowdsmart-terraform-state-lock`. A single remote backend can be used
for many terraform deployments.

```shell
cd terraform-state
terraform init
terraform apply # reply yes
```

## Installation

Once the setup has been bootstrapped we recommend letting GitHub
actions take over from this point on. This means setting the
environment variables mentioned above as secrets. One additional
benifit of this approach. Is that After bootstrapping the terraform
state no one needs to have access to the credentials (only github
actions). If you would like to perform the installation locally we
follow the same terraform deployment steps.

```shell
cd infastructure
terraform init
terraform apply # reply yes
```

Notice a pattern here with terraform deployments? `terraform init` +
`terraform apply` should be enough to maintain the entire
cluster. About 15 minutes after these commands or the GitHub Action
starting you will have a working jupyterhub cluster.
