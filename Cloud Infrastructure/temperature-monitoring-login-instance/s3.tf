resource "aws_s3_bucket" "b" {
  bucket = "temperature-c29df1234"

  tags = {
    Name = "temperature-c29df1234"
  }
}