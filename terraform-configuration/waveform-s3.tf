resource "aws_s3_bucket" "waveforms-bucket" {
    bucket = "audio-collaborate-waveforms-bucket.matthewcanty.co.uk"
    acl = "public-read"

    tags {
        Name = "Waveforms"
        Environment = "${var.env}"
    }
}
