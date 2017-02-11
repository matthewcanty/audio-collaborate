resource "aws_api_gateway_rest_api" "audio_api" {
  name = "AudioApi"
  binary_media_types = ["audio/mp3"]
}

resource "aws_api_gateway_api_key" "audio_api_key" {
  name = "audio_api_kay"

  stage_key {
    rest_api_id = "${aws_api_gateway_rest_api.audio_api.id}"
    stage_name = "${aws_api_gateway_deployment.audio_api_deployment.stage_name}"
  }
}

resource "aws_api_gateway_resource" "audio_api_uploads" {
  rest_api_id = "${aws_api_gateway_rest_api.audio_api.id}"
  parent_id = "${aws_api_gateway_rest_api.audio_api.root_resource_id}"
  path_part = "uploads"
}

resource "aws_api_gateway_method" "put_upload_method" {
  rest_api_id = "${aws_api_gateway_rest_api.audio_api.id}"
  resource_id = "${aws_api_gateway_resource.audio_api_uploads.id}"
  http_method = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_deployment" "audio_api_deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.audio_api.id}"
  stage_name = "${var.env}"
}

resource "aws_api_gateway_integration" "audio_api_integration" {
  rest_api_id = "${aws_api_gateway_rest_api.audio_api.id}"
  resource_id = "${aws_api_gateway_resource.audio_api_uploads.id}"
  http_method = "${aws_api_gateway_method.put_upload_method.http_method}"
  type = "MOCK"

  # Transforms the incoming XML request to JSON
  request_templates {
    "application/xml" = <<EOF
{
   "body" : $input.json('$')
}
EOF
  }
}
