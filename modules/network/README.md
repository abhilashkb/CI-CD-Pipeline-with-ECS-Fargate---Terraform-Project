# Network Module

This Terraform module provisions networking resources for your infrastructure.

## Features

- Creates a VPC
- Configures public and private subnets
- Sets up route tables and associations
- Optionally provisions NAT gateways and internet gateways
- Supports custom CIDR blocks

## Usage

```hcl
module "network" {
    source = "./modules/network"

    vpc_cidr           = "10.0.0.0/16"
    public_subnets     = ["10.0.1.0/24"]
    private_subnets    = ["10.0.2.0/24"]
    enable_nat_gateway = true
    tags = {
        Environment = "dev"
    }
}
```

## Inputs

| Name                | Description                        | Type    | Default     | Required |
|---------------------|------------------------------------|---------|-------------|----------|
| vpc_cidr            | CIDR block for the VPC             | string  | n/a         | yes      |
| public_subnets      | List of public subnet CIDRs        | list    | n/a         | yes      |
| private_subnets     | List of private subnet CIDRs       | list    | n/a         | yes      |
| enable_nat_gateway  | Enable NAT gateway                 | bool    | false       | no       |
| tags                | Tags to apply to resources         | map     | {}          | no       |

## Outputs

| Name           | Description                  |
|----------------|-----------------------------|
| vpc_id         | The ID of the VPC           |
| public_subnets | IDs of public subnets        |
| private_subnets| IDs of private subnets       |

## License

MIT