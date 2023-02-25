locals {
  chatbot_logging_level      = "INFO"
  chatbot_slack_workspace_id = "T04E9KTNETY"

  chatbot_tags = {
    Automation     = "Terraform + Cloudformation"
    Terraform      = true
    Cloudformation = true
  }
}

data "aws_iam_role" "aws-chatbot" {
  name = "aws-chatbot-role"
}

data "aws_sns_topic" "test-chatbot-terraform" {
  name = "test-chatbot-terraform"
}

module "chatbot_slack_configuration" {
  source  = "waveaccounting/chatbot-slack-configuration/aws"
  version = "1.1.0"

  configuration_name = "config-name"
  iam_role_arn       = data.aws_iam_role.aws-chatbot.arn
  slack_channel_id   = "C04E9KTP9AS"
  slack_workspace_id = local.chatbot_slack_workspace_id

  sns_topic_arns = [
    data.aws_sns_topic.test-chatbot-terraform.arn,
  ]

  tags = local.chatbot_tags
}
