resource "aws_s3_bucket" "terraform_state" {
  bucket = format("devops-bootcamp-remote-state-%s", var.name)

  # Versioning for full history
  versioning {
    enabled = true
  }

  # Encrypted for privacy
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Don't be deleting this by mistake
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_public_access_block" "sec" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = format("devops-bootcamp-locks-%s", var.name)
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  # Don't be deleting this by mistake either
  lifecycle {
    #prevent_destroy = true
    prevent_destroy = false
  }
}
