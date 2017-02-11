resource "aws_lambda_permission" "allow_bucket" {
    statement_id = "AllowExecutionFromS3Bucket"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.waveform_lambda.arn}"
    principal = "s3.amazonaws.com"
    source_arn = "${aws_s3_bucket.audio_bucket.arn}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
    bucket = "${aws_s3_bucket.audio_bucket.id}"
    lambda_function {
        lambda_function_arn = "${aws_lambda_function.waveform_lambda.arn}"
        events = ["s3:ObjectCreated:*"]
    }
}
