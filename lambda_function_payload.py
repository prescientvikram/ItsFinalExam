import json
import os
import webbrowser

import requests

def use_requests ():

 payload = {
      "subnet_id": "aws_subnet.private_subnet.id",
      "name": "VIKRAM DHANRAJ WAGHMARE",
      "email": "vikramwaghmare7995@gmail.com"
    }

data = json.loads(payload)

# The API endpoint to communicate with
url_post = "https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/"

# A POST request to tthe API
post_response = requests.post(url_post, json=data)

# Print the response
post_response_json = post_response.json()

print(post_response_json.json())

   

