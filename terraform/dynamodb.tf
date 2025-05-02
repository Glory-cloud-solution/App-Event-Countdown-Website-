resource "aws_dynamodb_table" "neoapp_registrations" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "email"

  attribute {
    name = "email"
    type = "S"
  }

  tags = {
    Name        = "NeoApp Registrations"
    Environment = "Production"
  }
}
