locals {
  tags = {
    Name = "timing-api-backend"
    Environment = "DEV"
    Terraform = "true"
  }
  rds_secret_arn = data.aws_ssm_parameter.rds_secret_arn.value
  app_alb_security_group_id = data.aws_ssm_parameter.app_alb_security_group_id.value
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  rds_endpoint = split(":", data.aws_ssm_parameter.rds_endpoint.value)[0]
  rds_security_group_id = data.aws_ssm_parameter.rds_security_group_id.value
  ecs_cluster_id = data.aws_ssm_parameter.ecs_cluster_id.value
  private_subent_ids = split(",",data.aws_ssm_parameter.private_subent_ids.value)
  app_target_group_arns = data.aws_ssm_parameter.app_target_group_arns.value
  container_name = "api-ecs"
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