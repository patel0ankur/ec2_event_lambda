variable "lambda_function_arn" {}
variable "lambda_function_name" {}
  

resource "aws_cloudwatch_event_rule" "ec2_terminate_eventbridge" {
    name        = "EC2_Terminate_EventBridge"
    description = "Capture EC2 Terminate Events"
    event_pattern = <<EOF
    {
        "source": ["aws.ec2"],
        "detail-type": ["EC2 Instance State-change Notification"],
        "detail": {
            "state": ["terminated", "running"]
        }
    }
    EOF 
    tags = {
        Name = "EC2_Terminate_EventBridge"
        BU   = "DTIS"
    }
}

resource "aws_cloudwatch_event_target" "ec2_terminate_lambda_function_target" {
    rule = aws_cloudwatch_event_rule.ec2_terminate_eventbridge.name
    target_id = "ec2_terminate_lambda_function_target"
    arn = var.lambda_function_arn
}

resource "aws_lambda_permission" "allow_eventbridge_to_call_lambda" {
    statement_id = "AllowExecutionFromAWSEvents"
    action = "lambda:InvokeFunction"
    principal = "events.amazonaws.com"
    function_name = var.lambda_function_name
    source_arn = aws_cloudwatch_event_rule.ec2_terminate_eventbridge.arn
}