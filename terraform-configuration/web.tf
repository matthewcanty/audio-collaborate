resource "aws_s3_bucket" "web" {
    bucket = "audio-collaborate-web-bucket.matthewcanty.co.uk"
    acl = "public-read"

    website {
        index_document = "index.html"
    }

    tags {
        Name = "Web"
        Environment = "${var.env}"
    }
}

resource "aws_s3_bucket_object" "index" {
    bucket = "${aws_s3_bucket.web.bucket}"
    key = "index.html"
    source = "index.html"
    etag = "${md5(file("index.html"))}"
    acl = "public-read"
    content_type = "text/html"
}
