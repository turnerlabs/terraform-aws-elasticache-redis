variable "vpc_id" {
}

variable "private_subnet_ids" {
}

variable "engine_version" {
  default = "2.8.24"
}

variable "instance_type" {
  default = "cache.m3.medium"
}

variable "maintenance_window" {
  # SUN 01:00AM-02:00AM ET
  default = "sun:05:00-sun:06:00"
}

# tags

variable "tag_name" {
}

variable "tag_description" {
}

variable "tag_environment" {
}

variable "tag_creator" {
}

variable "tag_customer" {
}

variable "tag_owner" {
}

variable "tag_product" {
}

variable "tag_costcenter" {
}
