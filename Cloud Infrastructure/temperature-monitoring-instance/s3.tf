resource "aws_s3_bucket" "b" {
  bucket = "temperature-data-c29df12345"

  tags = {
    Name = "temperature-data-c29df12345"
  }
}