
# Connecting MongoDB Compass to MongoDB on AWS EC2

## Overview

This guide explains how to connect MongoDB Compass on a local computer to a MongoDB database hosted on an AWS EC2 Ubuntu instance.
An SSH tunnel is used to connect securely without exposing MongoDB's port 27017 to the internet.

## Prerequisites

- AWS EC2 Ubuntu instance running
- MongoDB installed and running on EC2
- MongoDB Compass installed locally
- SSH private key (`.pem` file)
- EC2 Public DNS address
- SSH access to EC2

## Step 1: Check MongoDB is Running on EC2

Connect to your EC2 instance using SSH:

```bash
ssh -i ~/.ssh/Datastudents.pem ubuntu@YOUR_PUBLIC_DNS
```

Check MongoDB's status:

```bash
sudo systemctl status mongod
```

The output should show:

```text
Active: active (running)
```

## Step 2: Open an SSH Tunnel

Open a new terminal window on your local computer.

Run:

```bash
ssh -i ~/.ssh/Datastudents.pem -N -L 27018:127.0.0.1:27017 ubuntu@YOUR_PUBLIC_DNS
```

Replace `YOUR_PUBLIC_DNS` with your EC2 Public DNS address.

- `-i` specifies the SSH private key.
- `-N` opens the connection without running remote commands.
- `-L` forwards local port 27018 to MongoDB port 27017 on EC2.

Keep this terminal window open while using Compass.

## Step 3: Connect Using MongoDB Compass

1. Open MongoDB Compass.
2. Select **New Connection**.
3. Enter the following connection string:

```text
mongodb://127.0.0.1:27018/?directConnection=true
```

4. Click **Connect**.

MongoDB Compass should now connect to MongoDB hosted on your EC2 instance.

## Step 4: Check the Connection

In the EC2 terminal, open MongoDB Shell:

```bash
mongosh
```

List the available databases:

```javascript
show dbs
```

If no user databases appear, create a test database:

```javascript
use test_aws
```

Insert a test document:

```javascript
db.students.insertOne({
    name: "Test Student",
    course: "Data Engineering",
    location: "AWS EC2"
})
```

Check that the database exists:

```javascript
show dbs
```

## Step 5: Verify in MongoDB Compass

1. Return to MongoDB Compass.
2. Refresh the database list.
3. Find the `test_aws` database.
4. Open the `students` collection.
5. Check that the test document is visible.

If the document appears, MongoDB Compass is successfully connected to MongoDB on AWS EC2.
