# Creating One Vpc
resource "aws_vpc" "sachin-vpc" {
  cidr_block = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "sachin-vpc"
    Owner = "sachin.negi@cloudeq.com"
    Purpose = "training"
  }
}

# Creating two Subnets
resource "aws_subnet" "sachin-subnet-1" {
  vpc_id = "${aws_vpc.sachin-vpc.id}"
  cidr_block = "10.1.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "sachin-subnet-1"
    Owner = "sachin.negi@cloudeq.com"
    Purpose = "training"
  }
}


resource "aws_subnet" "sachin-subnet-2" {
  vpc_id = "${aws_vpc.sachin-vpc.id}"
  cidr_block = "10.1.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "sachin-subnet-2"
    Owner = "sachin.negi@cloudeq.com"
    Purpose = "training"
  }
}

#Creating two EC-2 instance in first subnet

resource "aws_instance" "sachin-ec2-1" {
  ami = "ami-0dfcb1ef8550277af"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sachin-security.id}"]
  subnet_id = "${aws_subnet.sachin-subnet-1.id}"

 
  count = 2
  tags = {
    Name = "sachin-ec2-1"
    Owner = "sachin.negi@cloudeq.com"
    Purpose = "training"
  }

  volume_tags = {
    Name = "sachin-ec2-1"
    Owner = "sachin.negi@cloudeq.com"
    Purpose = "training"
  }
}



#Creating two EC-2 instance in second subnet

resource "aws_instance" "sachin-ec2-2" {
  ami = "ami-0dfcb1ef8550277af"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sachin-security.id}"]
  subnet_id = "${aws_subnet.sachin-subnet-2.id}"

 
  count = 2
  tags = {
    Name = "sachin-ec2-2"
    Owner = "sachin.negi@cloudeq.com"
    Purpose = "training"
  }

  volume_tags = {
    Name = "sachin-ec2-2"
    Owner = "sachin.negi@cloudeq.com"
    Purpose = "training"
  }
}


 # Creating aws Security Group
resource "aws_security_group" "sachin-security" {
    vpc_id = "${aws_vpc.sachin-vpc.id}"

    tags =  {
    Name = "sachin-security"
    Owner = "sachin.negi@cloudeq.com"
    Purpose = "training"
    }
    
    egress {                                     # outbound(allow for every port)
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {                                    # Inboud (allowed for only https)
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {                                    # Inboud (allowed for only http)
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}






