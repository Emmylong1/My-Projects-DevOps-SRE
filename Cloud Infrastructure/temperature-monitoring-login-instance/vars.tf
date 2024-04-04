variable "AWS_REGION" {
  type    = string
  default = "us-east-2"  
}
variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
  default     = "temperature"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-2 = "ami-0b8b44ec9a8f90422"
  }
}