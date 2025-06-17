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
![0 drawio](https://github.com/user-attachments/assets/74d297bf-0ddc-4872-8c87-7a0188512200)

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

![VPC](https://github.com/user-attachments/assets/a4135c45-9b05-4c2f-8d62-4c8db04bef2b)

- **External Load Balancer**

![External_LB](https://github.com/user-attachments/assets/4c939715-6769-4fe4-9116-cb99de583e9d)

- **Internal Load Balancer**

![Internal_LB](https://github.com/user-attachments/assets/6a9f6a13-d758-4e83-9dc7-365fdc74ea68)

- **S3 Bucket (Terraform State Storage)**

![S3_Backet](https://github.com/user-attachments/assets/a8fc3ffa-79fa-4470-a08b-192e921e5e9d)

- **EC2 Instances**

![EC2](https://github.com/user-attachments/assets/927e1299-8c5f-4232-90c2-10d9f3d97f29)

- **Target_Groups**

![Target_groups](https://github.com/user-attachments/assets/8c52960d-4bbc-4584-9be2-de31a0fe79e8)


- **Security_Groups**

![Sec_Groups](https://github.com/user-attachments/assets/44e8a82c-cc13-48b8-9447-39a8675a9521)


- **Testing with External Load Balancer DNS**


https://github.com/user-attachments/assets/9b7937bb-99b4-4b33-9ed6-260255e7f952


- **Testing with Server1 DNS**

![server1](https://github.com/user-attachments/assets/e5ad247c-58b0-4d95-9d97-7e77ca8910f1)

- **Testing with Server2 DNS**

![server2](https://github.com/user-attachments/assets/2b45dfed-a715-4480-a3a5-8f9c3dfb2873)

---

## 👨‍💻 Author  
Mahmoud Yassen  
🎓 NTI Cloud DevOps Trainee   
🔗 [(www.linkedin.com/in/myassenn01)]

---

## 👨‍🏫 Supervision  
Eng. Mohamed Swelam
🔗 [(www.linkedin.com/in/mohamed-swelam-1239751a2)]

