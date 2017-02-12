resource "aws_lambda_function" "waveform_lambda" {
    filename = "bin/waveform_lambda_function_payload.zip"
    function_name = "generateWaveform"
    description = "Generate waveforms of new audio files."
    timeout = 3
    memory_size = 128
    role = "${aws_iam_role.iam_for_lambda.arn}"
    handler = "generate-waveform.audio_uploaded_handler"
    source_code_hash = "${base64sha256(file("bin/waveform_lambda_function_payload.zip"))}"
    runtime = "python2.7"
    environment {
        variables = {
            foo = "bar"
        }
    }
}

resource "aws_lambda_permission" "allow-cloudwatch" {
  statement_id = "allow-cloudwatch"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.waveform_lambda.arn}"
  principal = "logs.${var.region}.amazonaws.com"
  source_arn = "${aws_cloudwatch_log_group.audio-collaborate-loggroup.arn}"
}

resource "aws_cloudwatch_log_subscription_filter" "waveform_lambda_subscription" {
  depends_on = ["aws_lambda_permission.allow-cloudwatch"]
  name = "waveform_lambda-subscription"
  log_group_name = "${aws_cloudwatch_log_group.audio-collaborate-loggroup.name}"
  filter_pattern = ""
  destination_arn = "${aws_lambda_function.waveform_lambda.arn}"
}

resource "aws_cloudwatch_log_stream" "waveform_lambda_stream" {
  name           = "WaveformLambdaStream"
  log_group_name = "${aws_cloudwatch_log_group.audio-collaborate-loggroup.name}"
}
