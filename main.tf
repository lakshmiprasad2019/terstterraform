terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "Myvpc" {
  cidr_block = "20.20.0.0/16"
  tags = {
    Name = "MyVPC"
  }
}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.Myvpc.id
  cidr_block = "20.20.1.0/24"

  tags = {
    Name = "Public"
  }
}
resource "aws_subnet" "secondsubnet" {
  vpc_id     = aws_vpc.Myvpc.id
  cidr_block = "20.20.2.0/24"

  tags = {
    Name = "Private"
  }
}
resource "aws_subnet" "secondsubnet1" {
  vpc_id     = aws_vpc.Myvpc.id
  cidr_block = "20.20.3.0/24"

  tags = {
    Name = "Private1"
  }
}
resource "aws_instance" "fristec2" {
  ami           = data.aws_ami.myami.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
}
data "aws_ami" "myami" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10**"]
  }
}