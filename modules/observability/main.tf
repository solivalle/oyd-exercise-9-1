resource "aws_cloudwatch_log_group" "app" {
  name              = "/app/${var.environment}/${var.app_name}"
  retention_in_days = var.log_retention_days

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_sns_topic" "alarms" {
  name = "${var.environment}-${var.app_name}-alarms"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = var.notification_email
}