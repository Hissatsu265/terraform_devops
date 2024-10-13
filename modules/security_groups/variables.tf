variable "vpc_id" {
  description = "The VPC ID where the security groups will be created."
  type        = string
}

variable "my_ip" {
  description = "Your public IP address in CIDR notation."
  type        = string
}
