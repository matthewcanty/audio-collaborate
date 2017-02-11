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
