resource "aws_instance" "example" {
  ami                    = var.AMIS[var.AWS_REGION]
  count                  = "2" 
  instance_type          = "t3.medium"
  key_name               = var.key_name
  subnet_id              = aws_subnet.main-public-1.id
  vpc_security_group_ids = [aws_security_group.example-instance.id]
  iam_instance_profile   = aws_iam_instance_profile.s3-mybucket-role-instanceprofile.name
  tags = {
    Environment = "Dev"
    Name        = "monitor-instance"
  }
}

