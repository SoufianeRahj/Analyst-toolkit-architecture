# Analyst-toolkit-architecture
The Analyst-toolkit application aims at easing the work of business analysts. 

It helps delivering high quality specifications by removing typos, enhancing the vocabulary, and translating the content.

[WORK IN PROGRESS]: the translation and typos removal features are available as of now. To test the application, email me at soufianerahj23@gmail.com. 

For infrastructure cost reasons I don't keep the application UP 24/7.

## Architecture of the Infrastructure of the Analyst-toolkit application
![Architecture of the infrastructure](diagrams/analyst-toolkit-architecture.png)

To explain the previous infrastructure let's consider separately the Front End and Back End Applications.

### Infrastructure of the Front End
The Front End application is a React app. S3 hosts the build of the source Code. 

A cloudfront Distribution is created with the S3 bucket as an origin (not S3 for static website hosting). The default behavior is the S3 Bucket. There will be 2 behaviors linked to 2 buckets afterwards to allow blue/green deployments.

ACM is used to generate TLS certificates on US-EAST-1 for the cloudfront distribution.

An alias record is created on route53 to point to the cloudfront distribution.

### Infrastructure of the Back End

The Application Load Balancer is associated with 2 AZs. 

A target group is created containing an autoscaling group of EC2 instances that spans across 2 AZs.

A TLS certificate is generated using ACM on eu-west-3. 

An https listener is configured on the ALB and sends trafic to the created target group with the ASG. the listener is configured with the generated TLS certificate.

An alias record is created on route53 and points to the ALB.

The Back End is a Node.js application. PM2 is used as a process manager to take advantage of multiple cores in the EC2 instances. 

Sensitive data (api keys) are stored on SSM parameter store as secrets and requested from the instances in order to be passed to PM2 as environment variables. This allow child processes to be able to fetch the required secrets.

### Security

SSM Parameter store is used to store secrets. 
A TLS certificate is associated to the ALB to allow https protocol.
A security group is created for the ALB allowing https traffic from anywhere.
A security group is created for EC2 instances allowing traffic from the Security group of the ALB.

### Continuous delivery of the Front End

### Continuous delivery of the Back End

