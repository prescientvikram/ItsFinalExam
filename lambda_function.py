import urllib.request
import os
import json
import base64

def lambda_handler(event, context):


  payload = event
  request_body = {
      "subnet_id": "aws_subnet.private_subnet.id",
      "name": "VIKRAM DHANRAJ WAGHMARE",
      "email": "vikramwaghmare7995@gmail.com"
    }

  #request_body = json.dumps(request_body_)

  url_post = "https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/"

  request_headers = {'content-type': {'X-Siemens-Auth': 'test'}}

  response = urllib.request.Request(url_post,headers=request_headers,data=json.dumps(request_body))

  base64_response = base64.b64encode(response.content).decode('utf-8')
  
  print(base64_response.json())
