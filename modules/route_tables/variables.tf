variable "vpc_id" {
  description = "vpc-009418df3347c7b31"
  type        = string
}

variable "public_subnet_id" {
  description = "subnet-08adfe7632e54cdb6"
  type        = string
}

variable "private_subnet_id" {
  description = "subnet-0bea988609942cd15"
  type        = string
}

variable "internet_gateway_id" {
  description = "igw-03099d2759270fe33"
  type        = string
}

variable "nat_gateway_id" {
  description = "nat-049ed0131ea6b118e"
  type        = string
  default     = null
}
