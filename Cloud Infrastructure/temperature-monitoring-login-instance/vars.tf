variable "AWS_REGION" {
  type    = string
  default = "us-west-1"  
}
variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
  default     = "project-key"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-west-1= "ami-05c969369880fa2c2"
  }
}