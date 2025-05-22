# 🚀  **Terraform AWS Lab - Documentation**

---

## 📋 **Overview**

This Terraform project implements a multi-tier AWS infrastructure with the following components:
- VPC with public and private subnets across two availability zones
- Load balancers for traffic distribution
- Proxy servers in public subnets
- Backend web servers in private subnets
- Security groups for access control
- Remote state management with S3 and DynamoDB

---

## 🏗️ **Architecture Diagram**
![image](https://github.com/user-attachments/assets/ea1dbc68-faf9-45ce-87e1-97f69f414c74)

---

## 📁 **Structure**
```
terraform-aws/
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf
├── terraform.tfvars
├── modules
│   ├── backend
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── ec2
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── elb
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── internal-alb
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── security_group
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── subnet
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── README.md
```
---

## 🧩 **Architecture Components**

| Component                    | Description                                                            |
|------------------------------|------------------------------------------------------------------------|
| **VPC**                      | Isolated AWS network environment.                                      |
| **Internet Gateway (IGW)**   | Connects VPC to the internet; enables public subnet connectivity.      |
| **Public Subnets**           | Host internet-facing resources (e.g., Bastion Host).                   |
| **Private Subnets**          | Host internal resources like application servers.                      |
| **Route Tables**             | Routes traffic appropriately (public → IGW, private → NAT Gateway).    |
| **NAT Gateway**              | Allows private subnet instances outbound internet access securely.     | 
| **Elastic IP**               | Static IP assigned to NAT Gateway for stable connectivity.             |
| **Security Groups**          | Virtual firewalls controlling inbound/outbound traffic.                |
| **Nginx Instances**          | Reverse proxy servers located in public subnets.                       |
| **Apache Backend Instances** | Web servers located in private subnets.                                |
| **Load Balancer**            | Distributes incoming traffic for fault tolerance and high availability.|

---


## 🔗 **Key Features**
1. **Modular Design**: All infrastructure components are organized into reusable modules
2. **Variable-Driven**: No hard-coded values, all configuration through variables
3. **Remote Backend**: State stored in S3 with locking via DynamoDB
4. **Remote Exec**: Automatic configuration of reverse proxies
5. **Output Management**: All server IPs saved to a local file
6. **Complete Automation**: All configuration done through Terraform

---

## 🛠️ **Deployment Steps**

1. **Install Terraform:**  
   - Download from the [official Terraform website](https://www.terraform.io/downloads).

2. **Configure AWS Credentials:**  
   - Setup AWS CLI credentials on your machine (`aws configure`).

3. **Review and modify variables**
   - in `variables.tf` or create a `terraform.tfvars` file

4. **Initialize Terraform:**
   - Run `terraform init` to initialize the project.

5. **Plan the Deployment:**
   - Execute `terraform plan` to preview the infrastructure changes.

6. **Apply the Deployment:**
   - Run `terraform apply` to create the infrastructure on AWS.

---


## ✒️ **Outputs**
After successful deployment, the following outputs are available:
- VPC ID
- Subnet IDs (public and private)
- Security Group IDs
- Load Balancer DNS name
- EC2 instance IPs (public and private)

Additionally, a local file `server_ips.txt` is generated with all server IPs for easy reference.

---

## 🖼 **images**

- **VPC**

![VPC](https://github.com/user-attachments/assets/dabc9920-42fc-43a4-aa08-ebcbebdb7ef0)

- **External Load Balancer**

![External_LB](https://github.com/user-attachments/assets/30768450-7293-4c8c-a102-780f3e649be3)

- **Internal Load Balancer**

![Internal_LB](https://github.com/user-attachments/assets/5cf8a764-083f-4c43-8851-5b7605e42f14)

- **S3 Bucket (Terraform State Storage)**

![S3_Backet](https://github.com/user-attachments/assets/b66184b6-cee3-45c8-8320-52ad34ee90e7)

- **EC2 Instances**

![EC2](https://github.com/user-attachments/assets/c2d20125-4b92-432d-a702-2eb6e48d7eda)

- **Target_Groups**

![Target_groups](https://github.com/user-attachments/assets/d6b55fe4-d911-43a4-871d-fbb15b964b5c)


- **Security_Groups**

![Sec_Groups](https://github.com/user-attachments/assets/576b9003-d44c-42b7-b312-7ee5864055f4)


- **Testing with External Load Balancer DNS**

https://github.com/user-attachments/assets/2d82a81c-aa3c-44a2-8257-8b0e4122f7ff

- **Testing with Server1 DNS**

![server1](https://github.com/user-attachments/assets/c555525b-ae9d-4189-890f-5c08a876b829)

- **Testing with Server2 DNS**

![server2](https://github.com/user-attachments/assets/166ada90-24b6-4809-b2f3-d4c49b9d282f)

---

## 👨‍💻 Author  
Mahmoud Yassen  
🎓 NTI Cloud DevOps Trainee   
🔗 [(www.linkedin.com/in/myassenn01)]

---

## 👨‍🏫 Supervision  
Eng. Mohamed Swelam
🔗 [(www.linkedin.com/in/mohamed-swelam-1239751a2)]

