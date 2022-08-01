resource "aws_instance" "web1" {
 
  ami = "ami-0cff7528ff583bf9a"
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}