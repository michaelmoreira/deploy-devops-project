# Configure o provider AWS
provider "aws" {
  region = "us-east-1"
}

# Defina o tipo de instância EC2
resource "aws_instance" "ec2" {
  count = 4

  ami           = "ami-0ac019f4fcb7cb7e6"
  instance_type = "t2.micro"
}

# Defina o tipo de volume EBS
resource "aws_ebs_volume" "ebs" {
  count = 4

  availability_zone = "us-east-1a"
  size              = 10
  type              = "gp2"

  # Liga o volume EBS à instância EC2
  attachment {
    instance = aws_instance.ec2[count.index].id
    device   = "/dev/sda1"
  }
}
