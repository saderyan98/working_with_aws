
#!/bin/bash
set -e

# 1. Update the package list
sudo apt-get update

# 2. Install prerequisites
sudo apt-get install -y gnupg curl

# 3. Download and save MongoDB's GPG key
curl -fsSL https://pgp.mongodb.com/server-9.asc | \
  sudo gpg --batch --yes --dearmor \
  -o /usr/share/keyrings/mongodb-server-9.gpg

# 4. Add MongoDB's repository
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-9.gpg ] https://repo.mongodb.org/apt/ubuntu resolute/mongodb-org/9.0 multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-9.0.list

# 5. Refresh package list
sudo apt-get update

# 6. Install MongoDB
sudo apt-get install -y mongodb-org

# 7. Start MongoDB
sudo systemctl start mongod

# 8. Enable MongoDB on boot
sudo systemctl enable mongod

# 9. Check MongoDB status
sudo systemctl is-active mongod

# 10. Extra step - accepts connections arriving from outside the instance
sudo sed -i 's/bindIp: .*/bindIp: 0.0.0.0/' /etc/mongod.conf

# 11. Restart MongoDB so it picks up the new config
sudo systemctl restart mongod