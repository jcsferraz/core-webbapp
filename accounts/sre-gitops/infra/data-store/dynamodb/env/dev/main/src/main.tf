resource "aws_dynamodb_table" "global-state-consulteanuvem-lock-dynamo" {
  name           = "global-sre-git-ops-files-terraform-table"
  hash_key       = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name             = "global-sre-git-ops-files-terraform-table"
    Environment      = "globals"
    Application_ID   = "dynamodb"
    Application_Role = "Locks para o Terraform State Files"
    Team             = "consulteanuvem-com-br"
    Customer_Group   = "consulteanuvem-globals"
    Resource         = "environments_at_cloud"
  }
}