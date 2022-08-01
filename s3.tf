resource "aws_s3_bucket" "MyBucket" {
  bucket = "${var.bucketname}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

variable "bucketname" {
    type = string
    
}
