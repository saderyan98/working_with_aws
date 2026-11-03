# Creating and Connecting to a AWS EC2 Instance

This guide explains how to launch an Ubuntu EC2 instance via the AWS website and connect to it using Terminal on macOS.
<br>

## 1. Create an EC2 instance in AWS

1. Sign in to the AWS Management Console and open EC2.

2. Check the AWS Region in the top-right corner. Key pair and instance must be in the same Region. In this case: `eu-central-1` is Frankfurt.

3. Select Instances in the left sidebar, then Launch instances.

4. Under Name and tags, enter a descriptive name.

5. Under Application and OS Images (AMI), choose `Ubuntu Server`.

6. Under Instance type, choose the size required for your work. For our Mongodb project we will select `t3.micro`.

7. Under Key pair (login), select an existing key pair for this Region, or choose Create new key pair. In this case we use the existing key pair provided by Sparta Global named `DataStudents`.

8. Create a security group with an inbound rule change two values: `Type: SSH` and `Source: My IP`.

9. Review the settings and click Launch instance.

10. Select view all instances. Wait for `Instance state: Running`, to ensure our insatnce is working.
    <br>

## 2. Prepare `.pem` key through terminal

1. Open Terminal on your Mac and ensure the `Datastudents.pem` key is somewhere in your file system.

2. If the file is in Downloads, move it to a .ssh directory:

    In terminal enter: 
    <br>
    <br>
    `mkdir -p ~/.ssh` -> to make directory \
    `mv ~/Downloads/Datastudents.pem ~/.ssh/` -> To move the file to the .ssh directory

3. Check file has moved:

    `ls -l ~/.ssh/Datastudents.pem`

4. On Mac sometimes moving files can cause security issues. To fix this we can enter:

    `chmod 400 ~/.ssh/Datastudents.pem`

This sllow the file owner to read the key and removes other permissions.
<br>

## 3.  Find the instance's connection details

1. In EC2 Instances, select your instance.

2. In the Details tab, find Public IPv4 DNS or Public IPv4 address.

3. Copy the sting. 

Confirm the AMI is Ubuntu: the typical SSH username for an Ubuntu EC2 AMI is ubuntu.
Example public DNS:

`ec2-3-121-222-53.eu-central-1.compute.amazonaws.com`
<br>

## 4. Connect from Mac Terminal

1. Use this command, replacing the example hostname with your instance's current Public IPv4 DNS:

`ssh -i ~/.ssh/Datastudents.pem ubuntu@ec2-3-121-222-53.eu-central-1.compute.amazonaws.com`
<br>
A successful connection usually changes your prompt from something like:

`Mac:~ user$` 

to:

`ubuntu@ip-172-31-xx-xx:~$`
