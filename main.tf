provider "aws" {
  region = "ap-south-1"
}

resource "tls_private_key" "justsimple" {
   algorithm = "RSA"
}
resource "aws_key_pair" "publickeyforaws" {
  key_name = "arunkumar"
 public_key =  tls_private_key.justsimple.public_key_openssh
}

resource "local_file" "grnerateprivatekey" {
    content = tls_private_key.justsimple.private_key_pem
    filename = "${path.module}/tharun/arunkumar"
}
resource "aws_instance" "awsinstance" {
  ami = "ami-0f918f7e67a3323f0"
  instance_type = "t2.micro"
  key_name = aws_key_pair.publickeyforaws.key_name
  tags = {
    Name = "aruncreatedainstanceforgit"
  }
}