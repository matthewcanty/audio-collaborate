resource "aws_api_gateway_rest_api" "audio_collaborate_api" {
  name = "AudioCollaborateApi"
  binary_media_types = ["audio/mp3"]
}

resource "aws_api_gateway_resource" "audio" {
  rest_api_id = "${aws_api_gateway_rest_api.audio_collaborate_api.id}"
  parent_id = "${aws_api_gateway_rest_api.audio_collaborate_api.root_resource_id}"
  path_part = "audio"
}

resource "aws_api_gateway_method" "put_audio" {
  rest_api_id = "${aws_api_gateway_rest_api.audio_collaborate_api.id}"
  resource_id = "${aws_api_gateway_resource.audio.id}"
  http_method = "PUT"
  authorization = "NONE"
}

/*
resource "aws_api_gateway_integration" "audio_collaborate_api_integration" {
  rest_api_id = "${aws_api_gateway_rest_api.audio_collaborate_api.id}"
  resource_id = "${aws_api_gateway_resource.audio.id}"
  http_method = "${aws_api_gateway_method.put_audio.http_method}"
  integration_http_method = "PUT"
  type = "AWS"
  uri = "${aws_s3_bucket.audio_bucket.arn}/s3:Put*"
  credentials = "${aws_iam_role.iam_for_audio_bucket.arn}"
}
*/
