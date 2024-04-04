# Define variables
variable "main_vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "main_igw_name" {
  type    = string
  default = "main"
}

variable "main_route_table_name" {
  type    = string
  default = "MyRoute"
}

variable "public_subnet_1_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "public_subnet_1_az" {
  type    = string
  default = "us-east-2a"
}

variable "public_subnet_2_cidr" {
  type    = string
  default = "10.0.3.0/24"
}

variable "public_subnet_2_az" {
  type    = string
  default ="us-east-2b"
}

variable "tls_security_group_name" {
  type    = string
  default = "allow_tls"
}

variable "tls_security_group_description" {
  type    = string
  default = "Allow TLS inbound traffic"
}
########eks############
variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  default     = "temperature-eks"
}

variable "instance_ami" {
  description = "AMI ID for EC2 instances"
  default     = "ami-0b8b44ec9a8f90422"
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  default     = "t2.medium"
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  default     = "pc-node-group"
}


