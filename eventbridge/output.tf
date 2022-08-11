output "eventbridge_rule_arns" {
  description = "The EventBridge Rule ARNs"
  value       = aws_cloudwatch_event_rule.ec2_terminate_eventbridge.arn
}