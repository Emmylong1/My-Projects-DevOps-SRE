variable "region" {
  default = "us-west-1"
}

variable "ami" {
  type = map(string)
  default = {
    master = "ami-05c969369880fa2c2"
    worker = "ami-05c969369880fa2c2"
  }
}

variable "instance_type" {
  type = map(string)
  default = {
    master = "t2.medium"
    worker = "t2.micro"
  }
}

variable "worker_instance_count" {
  type    = number
  default = 2
}

