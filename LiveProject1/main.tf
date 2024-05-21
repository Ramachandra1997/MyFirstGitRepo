resource "aws_key_pair" "ProjectKey" {
    key_name = "ProjectKey1"
    public_key = file("~/.ssh/id_rsa.pub") 
}

resource "aws_vpc" "ProjectVpc" {
    cidr_block = var.cidr
    tags = {
      Name = "ProjectVpc"
    }
}

resource "aws_subnet" "ProjectSubnet" {
    vpc_id = aws_vpc.ProjectVpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "ProjectSubnet"
    }
}

resource "aws_internet_gateway" "ProjectGateway" {
    vpc_id = aws_vpc.ProjectVpc.id
    tags = {
      Name = "ProjectGateway"
    }  
}

resource "aws_route_table" "ProjectRoutetable" {
    vpc_id = aws_vpc.ProjectVpc.id  

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ProjectGateway.id
}
tags = {
      Name = "ProjectRoutetable"
    }  
}
resource "aws_route_table_association" "Projectrta1" {
    subnet_id = aws_subnet.ProjectSubnet.id
    route_table_id = aws_route_table.ProjectRoutetable.id
}

resource "aws_security_group" "ProjectSg1" {
    name = "ProjectSg1"
    vpc_id = aws_vpc.ProjectVpc.id
    ingress {
        description = "for http"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "for ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "ProjectSg1"
    }
}

resource "aws_instance" "LiveProjectServer" {
    ami = var.OS
    instance_type = var.Processor
    key_name = aws_key_pair.ProjectKey.key_name
    vpc_security_group_ids = [aws_security_group.ProjectSg1.id]
    subnet_id = aws_subnet.ProjectSubnet.id

    tags = {
      Name = "LiveProjectServer"
    }

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host = self.public_ip
    }
    provisioner "file" {
      source = "app.py"
      destination = "/home/ubuntu/app.py"
    }
    provisioner "remote-exec" {
      inline = [
        "echo 'Hello from the remote instance'",
        "sudo apt update -y", # Update package lists (for ubuntu)
        "sudo apt-get install -y python3-pip", # Example package installation
        "cd /home/ubuntu",
        "yes | sudo apt-get install python3-flask",
        "echo 'installation complete'",
        "nohup sudo python3 app.py &",
        "ps -ef | grep python",
        ]
    }
}