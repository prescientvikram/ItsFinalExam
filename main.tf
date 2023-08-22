
##  creating private subnets whos ID needs in lambda payload
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private_subnet"
  }
}

##  creating routing table for private subnet
resource "aws_route_table" "routing_table" {

    vpc_id = aws_vpc.vpc.id
    route {

        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }


    tags = {

        Name = "private-Routing-Table"
    }
}

## aws lambda fuction  to invoke an remote api 

resource "aws_lambda_function" "aws_lambda_function" {
  function_name    = "aws_lambda_function"
  filename         = "lambda_function_payload.zip"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
  handler          = "use_requests.handler"
  role             = aws_iam_role.lambda.arn
  runtime          = "python3.7"

  vpc_config {
    subnet_ids = [aws_subnet.private_subnet.id]
    security_group_ids = [aws_security_group.private_SG.id]
  }
}


## output private subnet id to use in payload

output "private_subnet_id" {
  value       = aws_subnet.private_subnet.id
  description = "The ID of the private subnet."
}

## creating AWS security group

resource "aws_security_group" "private_SG" {
  name        = "private_SG"
  description = "allow request to remote api"
  vpc_id      = aws_vpc.vpc.id

 
   ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "http"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private_SG"
  }
}



   