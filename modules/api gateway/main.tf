resource "aws_security_group" "apigw_vpc_link_sg" {
  name   = "${var.name}-apigw-vpclink-sg"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name               = "${var.name}-vpclink"
  security_group_ids = [aws_security_group.apigw_vpc_link_sg.id]
  subnet_ids         = var.private_subnets
}

resource "aws_apigatewayv2_api" "api" {
  name          = "${var.name}-http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "alb_integration" {
  api_id             = aws_apigatewayv2_api.api.id
  integration_type   = "HTTP_PROXY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.vpc_link.id
  integration_method = "ANY"
  integration_uri    = var.alb_listener_arn
}

resource "aws_apigatewayv2_route" "route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "ANY /{proxy+}"

  target = "integrations/${aws_apigatewayv2_integration.alb_integration.id}"
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true
}