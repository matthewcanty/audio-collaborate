resource "aws_s3_bucket" "audio_bucket" {
    bucket = "audio-collaborate-audio-bucket.matthewcanty.co.uk"
    acl = "public-read"

    tags {
        Name = "Audio"
        Environment = "${var.env}"
    }
}

resource "aws_iam_role" "iam_for_audio_bucket" {
    name = "iam_for_audio_bucket"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
