# Specify the provider
provider "aws" {
  region = "ap-south-1"  # Change the region to your desired one
}

# Define the EC2 instance
resource "aws_instance" "Jenkins-Master" {
  ami           = "ami-00bb6a80f01f03502"  # Replace with the ID of your desired AMI
  instance_type = "t2.micro"               # Change to the instance type you prefer
  key_name      = "PranayAWS"            # Your EC2 key pair name (ensure you have created one in the AWS console)

  # Optional: Add a tag to the EC2 instance
  tags = {
    Name = "Jenkins-Master"
  }

  # Optional: Security group for the EC2 instance
  security_groups = ["PranaySecurity"]  # Replace with your security group name

  # Optional: Attach a public IP
  associate_public_ip_address = true

  # Optional: Configure a block device (EBS volume)
  root_block_device {
    volume_size = 8  # 8GB root volume
    volume_type = "gp2"  # General Purpose SSD
  }

  # Optional: User data for running a script on first boot
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Terraform!" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOF
}

# Define the second EC2 instance
resource "aws_instance" "Jenkins-Slave" {
  ami           = "ami-00bb6a80f01f03502"  # Replace with the ID of your desired AMI
  instance_type = "t2.micro"               # Change to the instance type you prefer
  key_name      = "PranayAWS"            # Your EC2 key pair name (ensure you have created one in the AWS console)

  # Optional: Add a tag to the EC2 instance
  tags = {
    Name = "Jenkins-Slave"
  }

  # Optional: Security group for the EC2 instance
  security_groups = ["PranaySecurity"]  # Replace with your security group name

  # Optional: Attach a public IP
  associate_public_ip_address = true

  # Optional: Configure a block device (EBS volume)
  root_block_device {
    volume_size = 8  # 8GB root volume
    volume_type = "gp2"  # General Purpose SSD
  }

  # Optional: User data for running a script on first boot
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Terraform!" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOF
}
# Optional: Output the public IP address of the EC2 instance
output "Masterinstance_public_ip" {
  value = aws_instance.Jenkins-Master.public_ip
}
output "Slaveinstance_public_ip" {
  value = aws_instance.Jenkins-Slave.public_ip
}
