resource "aws_cloudwatch_log_group" "audio-collaborate-loggroup" {
  name = "audio-collaborate"
  retention_in_days = 90
}
