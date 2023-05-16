# AWS ECS task need two types of roles
# 1. Task Execution - This will be used by containers inside task
# 2. Task - This is by task itself
resource "aws_iam_role" "api_role_task_execution" {
    name = "${local.tags.Name}-task-execution"
    assume_role_policy = data.aws_iam_policy_document.ecs_trust.json
    tags = local.tags
}

resource "aws_iam_policy" "api_role_task_execution" {
  name = "${local.tags.Name}-task-execution"
  description = "This policy is going to be attached for task execution role"
  policy = data.aws_iam_policy_document.rds_secret.json
}

resource "aws_iam_role_policy_attachment" "api_role_policy" {
  role       = aws_iam_role.api_role_task_execution.name
  policy_arn = aws_iam_policy.api_role_task_execution.arn
}

#this one is mandatory to pull images from ECR
resource "aws_iam_role_policy_attachment" "ecr_pull" {
  role       = aws_iam_role.api_role_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "api_role_task" {
    name = "${local.tags.Name}-task"
    assume_role_policy = data.aws_iam_policy_document.ecs_trust.json
    tags = local.tags
}
