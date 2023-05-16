locals {
  tags = {
    Name = "timing-api-backend"
    Environment = "DEV"
    Terraform = "true"
  }
  rds_secret_arn = data.aws_ssm_parameter.rds_secret_arn.value
}