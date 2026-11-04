
# Installing and Deploying MongoDB on AWS EC2

This guide explains how to install and run MongoDB on an Ubuntu EC2 instance.

## 1. Connect to EC2

1. Open Terminal on Mac.
2. Connect to your running EC2 instance:

   ```bash
   ssh -i ~/.ssh/Datastudents.pem ubuntu@<PUBLIC_DNS>
   ```

3. Replace `<PUBLIC_DNS>` with your instance's public DNS address.

4. Once connected, your terminal should display:

   `ubuntu@ip-172-31-xx-xx:~$`

---

## 2. Update Ubuntu

1. Update the package list:

   ```bash
   sudo apt update
   ```

2. Upgrade installed packages:

   ```bash
   sudo apt upgrade -y
   ```

---

## 3. Install MongoDB


1. Install required packages:

   ```bash
   sudo apt install -y gnupg curl
   ```

2. Download MongoDB's security key:

   ```bash
   curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-8.0.gpg
   ```

3. Add the MongoDB repository:

   ```bash
   echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
   ```

4. Update packages again:

   ```bash
   sudo apt update
   ```

5. Install MongoDB:

   ```bash
   sudo apt install -y mongodb-org
   ```

---

## 4. Start MongoDB

1. Start the MongoDB service:

   ```bash
   sudo systemctl start mongod
   ```

2. Check MongoDB is running:

   ```bash
   sudo systemctl status mongod
   ```

   You should see:

   `Active: active (running)`

3. Enable MongoDB to start automatically when the EC2 instance boots:

   ```bash
   sudo systemctl enable mongod
   ```

---

## 5. Test MongoDB

1. Open the MongoDB shell:

   ```bash
   mongosh
   ```

2. View existing databases:

   ```javascript
   show dbs
   ```

3. Create or switch to a database:

   ```javascript
   use test_database
   ```

4. Exit MongoDB:

   ```javascript
   exit
   ```

---

## 6. MongoDB Configuration

1. Open the MongoDB configuration file:

   ```bash
   sudo nano /etc/mongod.conf
   ```

2. Find network settings:

   ```yaml
   net:
     port: 27017
     bindIp: 127.0.0.1
   ```

   - `27017` is MongoDB's default port.
   - `127.0.0.1` allows connections from the EC2 instance itself.

3. If configuration changes are made, restart MongoDB:

   ```bash
   sudo systemctl restart mongod
   ```

---

If all steps completed sucessfully Mongodb should now installed and deployed on an Ubuntu EC2 instance.

