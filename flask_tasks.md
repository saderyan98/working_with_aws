# Creating a JSON API with Flask on AWS EC2

How to extend an existing Flask application on AWS EC2 to create a simple JSON API.

## Step 1: Connect to EC2

Open the terminal and connect to your EC2 instance:

```bash
ssh -i ~/.ssh/Datastudents.pem ubuntu@YOUR_PUBLIC_DNS
```

Navigate to the Flask application directory:

```bash
cd ~/flask_app
```

Activate the virtual environment:

```bash
source .venv/bin/activate
```

## Step 2: Edit the Flask Application

Open the Python file:

```bash
nano app.py
```

Update the code:

```python
from flask import Flask, jsonify

app = Flask(__name__)

# Sample student data
students = [
    {"id": 1, "name": "Alice", "course": "Data"},
    {"id": 2, "name": "Ben", "course": "DevOps"},
    {"id": 3, "name": "Charlie", "course": "Testing"}
]

# Homepage
@app.route('/')
def home():
    return "Hello World"

# Return all students
@app.route('/students', methods=['GET'])
def get_students():
    return jsonify(students), 200

# Return one student by ID
@app.route('/students/<int:student_id>', methods=['GET'])
def get_student(student_id):
    for student in students:
        if student["id"] == student_id:
            return jsonify(student), 200

    return jsonify({"error": "Student not found"}), 404

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
```

Save and exit Nano:

- `Ctrl + O` - Save
- `Enter` - Confirm
- `Ctrl + X` - Exit

## Step 3: Run the Flask Application

Run:

```bash
python app.py
```

Keep terminal open while testing.

## Step 4: Test the API Endpoints

Open a browser and replace `YOUR_PUBLIC_IP` with your EC2 Public IPv4 address.

### Get All Students

```text
http://YOUR_PUBLIC_IP:5000/students
```

Returns all students in JSON format.

### Get One Student

```text
http://YOUR_PUBLIC_IP:5000/students/2
```

Expected response:

```json
{
    "id": 2,
    "name": "Ben",
    "course": "DevOps"
}
```

Expected status: `200 OK`

### Test a Missing Student

```text
http://YOUR_PUBLIC_IP:5000/students/99
```

Expected response:

```json
{
    "error": "Student not found"
}
```

Expected status: `404 Not Found`

## Step 5: Test Using curl

Open a separate terminal on your local computer.

Get all students:

```bash
curl -i http://YOUR_PUBLIC_IP:5000/students
```

Get one student:

```bash
curl -i http://YOUR_PUBLIC_IP:5000/students/2
```

Test a missing student:

```bash
curl -i http://YOUR_PUBLIC_IP:5000/students/99
```

The `-i` option displays the HTTP status code and response headers.

## Code Explanation

| Code | Purpose |
|------|---------|
| `Flask(__name__)` | Creates the Flask application |
| `jsonify()` | Converts Python data into a JSON response |
| `@app.route()` | Defines an API endpoint |
| `methods=['GET']` | Specifies that the endpoint accepts GET requests |
| `<int:student_id>` | Gets the student ID from the URL |
| `200` | Successful HTTP response |
| `404` | Record not found |
| `host="0.0.0.0"` | Allows connections from outside EC2 |
