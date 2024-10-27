# Using Terraform to create AWS development environment

## Objective
In this project I will grow my infrastructure as code skills by using Terraform to automatically build a remote development environment in AWS.

I will deploy a EC2 instance with a user data script to automatically install the tools I need to start devloping. I will deploy this EC2 instance in a public subnet and configure a route table and security group to allow me to SSH into the EC2 instance on my home computer.

![Terraform drawio](https://github.com/user-attachments/assets/0f8d6f4e-f6b1-4f14-8433-5b36d4f68952)


### Skills Learned

- Infrastructure as code
- Terraform

### Tools Used

- AWS
- Terraform
- EC2
- VPC & Subnet
- Internet Gateway
- Route Tables & Routes
- Security Groups
- SSH
- Visual Studio Code

### Prerequisites 
- AWS Access Key
- Terraform
- Code Editor (I use Visual Studio Code)

## Steps

### Step 1 - Setup Terraform Provider
![image](https://github.com/user-attachments/assets/ee1ce4fe-dc64-43d4-8628-8b208a88ef3f)

### Step 2 - Configure VPC and subnet

![image](https://github.com/user-attachments/assets/c9e6d277-ffe6-442d-88fd-526c5fcdce14)

### Step 3 - Configure Internet Gateway and Route Tables

![image](https://github.com/user-attachments/assets/78c2dd42-5829-44d0-9aff-ae7fb7e35882)

### Step 4 - Configure Security Group
![image](https://github.com/user-attachments/assets/8f94002d-a3e6-46e8-894c-a1af22930d5a)

### Step 5 - Create key pair for SSH
Create a key pair, I used the below in powershell to generate a key pair
```
ssh-keygen -t ed25519
```
add the file path to you public key into the aws key pair resource as below
![image](https://github.com/user-attachments/assets/7d2f0760-e755-47cd-9ecb-149f839da5fc)

### Step 6 - Add datasource to get AMI for Ubuntu image
![image](https://github.com/user-attachments/assets/9837ea58-6c9c-45f0-bb4d-ee263660fcf9)

### Step 7 - Create userdata.tpl script for EC2 instance
```
#!/bin/bash
sudo apt-get update -y &&
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnugp-agent \
software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
sudo apt-get update -y &&
sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker ubuntu
```

### Step 8 - Configure EC2 instance for Ubuntu
![image](https://github.com/user-attachments/assets/780db96c-6f28-472f-94ca-5472c65a8840)

### Step 9 - Terraform Init and Apply!
Spin up the infrastructure using terraform init then terraform apply (assuming AWS provider creds are all set). Once you're all done don't forget to terraform destroy ;)







