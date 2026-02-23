resource "aws_wafv2_web_acl" "waf" {
  name  = "main-waf"
  scope = "REGIONAL"
  default_action {
    allow {}
  }
}

resource "aws_wafv2_web_acl_association" "assoc" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.waf.arn
}