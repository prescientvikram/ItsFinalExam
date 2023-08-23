import boto3
import requests
import base64
import json
import os

 

def lambda_handler(event, context):
    # Get the value of an environment variable

 
  ##os.environ['subnet']
    # Construct the data payload
    payload = {
        "subnet_id": "test",
        "name": "VIKRAMW WAGHMARE",
        "email": "vikramwaghmare7995@gmail.com"
    }

 

    # Convert the payload to JSON
    json_payload = json.dumps(payload)

 

    headers ={
        "Content-Type": "application/json",
        "X-Siemens-Auth": "test"
    }

    print("lambda_handler 4.")

 

    # Make a POST request to the remote API endpoint
    url = "https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data"
    response = requests.post(url, headers=headers, data=json_payload)

 

 

    print("lambda_handler 5.",response)
