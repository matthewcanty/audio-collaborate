provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "eu-west-2"
}

resource "aws_s3_bucket" "bucket" {
    bucket = "audio-collaborate-bucket.matthewcanty.co.uk"
    acl = "public-read"

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["GET","POST"]
        allowed_origins = ["http://127.0.0.1:8080/","http://localhost:8080/"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }

    tags {
        Name = "Big Audio Bucket"
        Environment = "Dev"
    }
}
