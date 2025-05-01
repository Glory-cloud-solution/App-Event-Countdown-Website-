# App-Event-Countdown-Website-
This project is an Event Countdown Website with a Custom Subdomain built for NeoCloud Technologies to promote the official launch of NeoApp.
# 🚀 NeoApp Event Countdown Website

This is a **serverless web application** designed for NeoCloud Technologies to promote the official launch of **NeoApp**, a revolutionary educational platform. The site features a live countdown timer, a registration form for early access, and an informational section about the institution. 

All AWS resources (S3 bucket, CloudFront distribution, Route 53 records, Lambda, API Gateway, DynamoDB, SNS topic, and IAM roles) are defined and managed in Terraform, ensuring consistent, repeatable infrastructure deployments.

This three-tier architecture (presentation, application, data) exemplifies best practices for security, scalability, and maintainability. 

## Live Project
Visit the live project here: [https://neocloudapp.site](https://neocloudapp.site)

---

## ✨ Features

 **Live Countdown Timer** to the official NeoApp launch date (July 17, 2025)
 **Registration Form** with serverless backend for storing user data
 **Success Pop-up with Confetti Animation**
 **Data stored in DynamoDB**
 **Deployed securely with HTTPS via Route 53 and CloudFront**
 **About Section** for first-time visitors and students
 **Mobile-Responsive Layout**
 **Custom Subdomain:** `neocloudapp.site`

---

## 🏗 Architecture Overview

This project follows a **3-tier serverless architecture**:

### 1. **Frontend**
- HTML, CSS, and JavaScript
- Hosted on **Amazon S3**
- Delivered globally using **Amazon CloudFront**

### 2. **API Layer**
- **Amazon API Gateway** for routing requests
- Accepts POST requests for form submissions

### 3. **Backend**
- **AWS Lambda** function handles form submissions
- Sends a confirmation email via **AWS SNS**
- Stores registration data in **Amazon DynamoDB**

---

## 📂 Project Structure

NeoApp-Event-Countdown/
├── frontend/
│   ├── index.html
│   ├── style.css
│   └── images/
│       ├── background-image.png
│       └── neocloud-logo.png
│
├── lambda_function/
│   ├── lambda_function.py            # Python script for handling form submissions
│   └── lambda_function_payload.zip   # Zipped deployment package
│
├── infrastructure/                   # Terraform Infrastructure-as-Code
│   ├── main.tf
│   ├── lambda.tf
│   ├── apigateway.tf
│   ├── dynamodb.tf
│   ├── iam.tf
│   ├── outputs.tf
│   └── variables.tf
│
├── architecture.png                  # Architecture diagram.
└── README.md                         # Project documentation



---

## 📷 Architecture Diagram

![Serverless Architecture](architecture.png)
![image](https://github.com/user-attachments/assets/27feadd2-f6ef-48c6-b416-3a696421e54e)

---

## 📜 Tech Stack

- **Frontend:** HTML5, CSS3, JavaScript 
- **Hosting:** Amazon S3
- **CDN & HTTPS:** CloudFront + Route 53
- **Backend:** AWS Lambda
- **API Gateway:** RESTful API for form submission
- **Database:** DynamoDB
- **Email Service:** AWS SNS

---

## 🧪 How It Works

1. User visits the landing page and sees a live countdown.
2. The user fills out the registration form.
3. Data is validated and sent via API Gateway to Lambda.
4. Lambda stores the data in DynamoDB and triggers a confirmation email.
5. A pop-up shows success with a celebration animation.

---

## 🗓 Save the Date

**NeoApp Launches:** `July 17, 2025`

---

## 📜 License

This project is for educational and demonstration purposes under NeoCloud Technologies.

---

## 🙌 Created By

**Glory Ugochukwu**  
Cloud Solutions Architect  
© NeoCloud Technologies, 2025

