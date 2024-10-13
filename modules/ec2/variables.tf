variable "ami_id" {
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "public_subnet_id" {
  description = "subnet-08adfe7632e54cdb6"
}

variable "private_subnet_id" {
  description = "subnet-0bea988609942cd15"
}

variable "public_sg_id" {
  description = "Security Group ID for Public EC2"
}

variable "private_sg_id" {
  description = "Security Group ID for Private EC2"
}

variable "key_pair" {
  description = "group16_keypair_ec2"
}
