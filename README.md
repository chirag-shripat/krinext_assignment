# krinext_assignment


## command to run the script
1. First we initilize the repo using 'terraform init' command and terraform install the required plugins.
2. Then we use 'terraform plan' command to check that what the script gives us.
3. Then we run the terraform script using 'terraform apply --auto-approve' command.

## Details that what I did using terraform
1. First we specify that we're using the AWS provider in the ap-south-1 region.
2. Then we create a new VPC with a CIDR block of 192.168.0.0/24
3. After that we create four new subnets within that VPC in which two of them are private and others are public.
4. Then we create a new security group that allows inbound traffic on port 22, 80 and 3306.
5. Copy the Ansible Playbooks for web server and database server to Manager node using provisioners.
6. Then launch two new EC2 instances with the t2.micro instance type, using the specified AMI, and with a user data script that updates      the system, install ansible and terraform on the Manager node.
7. Then we create a new DB subnet group and RDS instance in the same subnet, with the t4g.micro instance class, and with the specified      database engine, version, and credentials.
8. And create a new Elastic IP address and associate it with the EC2 instance.
9. Than Create a repo on GitHub named 'krinext_assignment' and connect it to local repo.
10. Use 'git init' command to initialize repo.
11. Then use 'git add .' to add to staging area and 'git commit' to commit.
12. And push it to GitHub using 'git push origin main' command.

## configuration management with Ansible
1. Build ansible playbooks to install web server and database server on infrastarcture.
2. Made inventery file 'host.inv'.
3. Define Templates, Variables, roles for creating infrastaructure.

# Continuous Integration and Deployment with Jenkins:
1. Installed jenkins on an another ec2.
2. Install required plugins (Terraform, ansible).
3. Configure tools (Terraform, ansible).
4. Create a new job and build a pipeline named 'assignment'.
5. Create credentials of github and for ansible.
6. write script in json to create pipeline.
7. First write stages of fetch the code form git and build infrastructure. And build the pipeline.
8. Then write the stages of configration of infrastaructure using ansible. And build the pipeline again.
9. And finally the pipeline working properly and build all the stages.
