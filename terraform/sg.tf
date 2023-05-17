#This SG is attached API ECS
resource "aws_security_group" "api_ecs" {
    name        = "timing-ecs-api"
    description = "This will only allow traffic from API ALB"
    vpc_id      = local.vpc_id

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}

resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  security_group_id = aws_security_group.api_ecs.id
  source_security_group_id = local.app_alb_security_group_id
}

#allowing traffic from API ECS on 5432
resource "aws_security_group_rule" "rds_rule" {
  type              = "ingress"
  from_port         = 5432
  description = "allowing traffic from API ECS on 5432"
  to_port           = 5432
  protocol          = "tcp"
  security_group_id = local.rds_security_group_id
  source_security_group_id = aws_security_group.api_ecs.id
}