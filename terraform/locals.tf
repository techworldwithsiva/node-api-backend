locals {
  tags = {
    Name = "timing-api-backend"
    Environment = "DEV"
    Terraform = "true"
  }
  rds_secret_arn = data.aws_ssm_parameter.rds_secret_arn.value
  app_alb_security_group_id = data.aws_ssm_parameter.app_alb_security_group_id.value
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}