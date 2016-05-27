#
# Security group resources
#

resource "aws_security_group" "redis" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.tag_name}"
    billing = "${var.tag_billing}"
    environment = "${var.tag_environment}"
    creator = "${var.tag_creator}"
    customer = "${var.tag_customer}"
    team = "${var.tag_team}"
    product = "${var.tag_product}"
  }
}

#
# ElastiCache resources
#

resource "aws_elasticache_subnet_group" "default" {
  name = "subnet-group-${var.tag_customer}-${var.tag_product}-${var.tag_environment}"
  description = "Private subnets for the ElastiCache instances: ${var.tag_customer} ${var.tag_product} ${var.tag_environment}"
  subnet_ids = ["${split(",", var.private_subnet_ids)}"]
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id = "${var.tag_customer}-${var.tag_product}-${var.tag_environment}"
  engine = "redis"
  engine_version = "${var.engine_version}"
  maintenance_window = "${var.maintenance_window}"
  node_type = "${var.instance_type}"
  num_cache_nodes = "1"
  parameter_group_name = "default.redis2.8"
  port = "6379"
  subnet_group_name = "${aws_elasticache_subnet_group.default.name}"
  security_group_ids = ["${aws_security_group.redis.id}"]

  tags {
    Name = "${var.tag_name}"
    billing = "${var.tag_billing}"
    environment = "${var.tag_environment}"
    creator = "${var.tag_creator}"
    customer = "${var.tag_customer}"
    team = "${var.tag_team}"
    product = "${var.tag_product}"
  }
}

#
# todo: add CloudWatch resources
#
