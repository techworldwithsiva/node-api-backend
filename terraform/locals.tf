locals {
  tags = {
    Name = "timing-api-backend"
    Environment = "DEV"
    Terraform = "true"
  }
  rds_secret_arn = data.aws_ssm_parameter.rds_secret_arn.value
  app_alb_security_group_id = data.aws_ssm_parameter.app_alb_security_group_id.value
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  rds_endpoint = data.aws_ssm_parameter.rds_endpoint.value

  env_vars = [
    {
        "name" : "PORT"
        "value" : "3000"
    },
    {
        "name": "DB",
        "value" : "timing"
    },
    {
        "name": "DBUSER",
        "value" : "timingadmin"
    },
    {
        "name" : "DBHOST",
        "value" : "${local.rds_endpoint}"
    },
    {
        "name" : "DBPORT",
        "value" : "5432"
    }
  ]

  application_secrets = [
    {
        "name" : "DBPASS",
        "valueFrom" : "${local.rds_secret_arn}"
    }
  ]
}