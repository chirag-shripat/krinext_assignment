# krinext_assignment

# Build Infrastructure using Terraform
First install and configure terraform on system and use VScode to write terraform configuration files in HCL.
Create VPC, Subnets, RDS, Security groups, instances, Load Balancer, Eip using terraform on AWS cloud and install the required packages on ec2(httpd, ansible, Terraform etc).
Use 'terraform init' command to initialize terraform plugins and then use 'terraform plan' commmand to check the output.
'terraform apply' to build infrastructure.
Than Create a repo on GitHub named 'krinext_assignment' and connect it to local repo.
Use 'git init' command to initialize repo.
Then use 'git add .' to add to staging area and 'git commit' to commit.
And push it to GitHub using 'git push origin main' command.

# configuration management with Ansible
Build ansible playbooks to install web server and database server on infrastarcture.
Made inventery file 'host.inv'.
Define Templates, Variables, roles for doing this.

# Continuous Integration and Deployment with Jenkins:
Installed jenkins on an another ec2.
Install required plugins (Terraform, ansible).
Configure tools (Terraform, ansible).
Create a new job and build a pipeline named 'assignment'.
Create credentials of github and for ansible.
write script in json to create pipeline.
First write stages of fetch the code form git and build infrastructure. And build the pipeline.
Then write the stages of configration of infrastaructure using ansible. And build the pipeline again.
And finally the pipeline working properly and build all the stages.