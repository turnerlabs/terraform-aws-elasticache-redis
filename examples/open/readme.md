An example that launches a redis cluster inside a VPC with open access.


```terraform

provider "aws" {
  region = "us-east-1"
}

module "elasticache_redis" {
  source = "github.com/turnerlabs/terraform-aws-elasticache-redis"

  vpc_id = "vpc-d070efb3"
  private_subnet_ids = "subnet-020d8b59,subnet-13f50b64"

  engine_version = "2.8.24"
  instance_type = "cache.m3.medium"
  maintenance_window = "sun:05:00-sun:06:00"

  tag_name = "redis"
  tag_description = "redis cluster for development"
  tag_creator = "creator"
  tag_product = "product"
  tag_customer = "customer"
  tag_owner = "owner"
  tag_environment = "dev"
  tag_costcenter = "TBD"
}

resource "aws_security_group_rule" "access_in" {
  security_group_id = "${module.elasticache_redis.cache_security_group_id}"
  type        = "ingress"
  from_port   = 6379
  to_port     = 6379
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "access_out" {
  security_group_id = "${module.elasticache_redis.cache_security_group_id}"
  type        = "egress"
  from_port   = 6379
  to_port     = 6379
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

```
