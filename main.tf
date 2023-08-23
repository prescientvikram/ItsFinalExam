
##  creating private subnets whos ID needs in lambda payload
resource "aws_subnet" "private_subnet" {
  vpc_id     = data.aws_vpc.vpc.id
  cidr_block = "10.0.8.0/24"

  tags = {
    Name = "private_subnet"
  }
}

##  creating routing table for private subnet
resource "aws_route_table" "routing_table" {

    vpc_id = data.aws_vpc.vpc.id
    route {

        cidr_block = "0.0.0.0/0"
        nat_gateway_id = data.aws_nat_gateway.nat.id
    }


    tags = {

        Name = "private-Routing-Table"
    }
}

## aws lambda fuction  to invoke an remote api 

resource "aws_lambda_function" "aws_lambda2" {
  function_name    = "aws_lambda2"
  filename         = data.archive_file.zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.zip.output_path)
  handler          = "lambda_function.lambda_handler"
  role             =  data.aws_iam_role.lambda.arn
  runtime          = "python3.7"
  timeout          =  30
  

  vpc_config {
    subnet_ids = [aws_subnet.private_subnet.id]
    security_group_ids = [aws_security_group.private_SG.id]
  }

environment {
    variables = {
      subnet = "${aws_subnet.private_subnet.id}"
    }
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
  vpc_id      = data.aws_vpc.vpc.id

 
  #  ingress {
  #   description = "http from VPC"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "http"
  #   cidr_blocks = [data.aws_vpc.vpc.cidr_block]
  # }

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

## create zip of lambda fuction file 
data "archive_file" "zip" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function.zip"
}

## associate route table with subnet
resource "aws_route_table_association" "route_table_association_private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.routing_table.id
}
   
