resource "aws_s3_bucket" "audio_bucket" {
    bucket = "audio-collaborate-audio-bucket.matthewcanty.co.uk"
    acl = "public-read"

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["GET","POST"]
        allowed_origins = ["http://127.0.0.1:8080/","http://localhost:8080/"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }

    tags {
        Name = "Audio"
        Environment = "${var.env}"
    }
}
