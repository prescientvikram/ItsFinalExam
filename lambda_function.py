import json
import os
#import webbrowser
import urllib.request
##import requests
#import  lambda_function

def lambda_handler(event, context):

 payload = {
      "subnet_id": "aws_subnet.private_subnet.id",
      "name": "VIKRAM DHANRAJ WAGHMARE",
      "email": "vikramwaghmare7995@gmail.com"
    }

 headers = {'content-type': {'X-Siemens-Auth': 'test'}}

 data = json.loads(payload)

# The API endpoint to communicate with
 url_post = "https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/"

# A POST request to tthe API
 post_response = urllib.request.post(url_post, json=data,headers=headers)

# Print the response
 post_response_json = post_response.json()

 print(post_response_json.json())



