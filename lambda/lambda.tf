
data "archive_file" "python_lambda_package" {
  type = "zip"
  source_file = "./lambda/code/ec2_hello.py"
  output_path = "ec2_hello.zip"
}


resource "aws_lambda_function" "ec2_terminate_lambda" {
    function_name = "ec2_terminate_lambda"
    description   = "Lambda Function when ec2 termination event"
    filename      = "ec2_hello.zip"
    source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
    role          = aws_iam_role.lambda_role.arn
    runtime       = "python3.8"
    handler       = "ec2_hello.lambda_handler"
    timeout       = 30

    tags = {
      Name = "EC2_Terminate_Lambda"
      BU   = "DTIS"
    }
}



