resource "aws_api_gateway_rest_api" "api" {                                
  name        = var.api_name
  description = "REST API for E-commerce platform-Blynk"
}

resource "aws_api_gateway_resource" "proxy" {                              
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_method" {                           
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

# API Gateway Integration with ALB (HTTP Proxy)
resource "aws_api_gateway_integration" "alb_integration" {                       
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.proxy_method.http_method
  type                    = "HTTP_PROXY"    
  integration_http_method = "ANY"           
  uri                     = "http://${var.alb_dns_name}"  
  connection_type         = "INTERNET"      
}

# API Gateway Method Response
resource "aws_api_gateway_method_response" "proxy_response" {                   
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.proxy_method.http_method
  status_code = "200"
}

# API Gateway Integration Response
resource "aws_api_gateway_integration_response" "proxy_integration_response" {   
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.proxy_method.http_method
  status_code = aws_api_gateway_method_response.proxy_response.status_code

  response_templates = {
    "application/json" = ""
  }

  depends_on = [aws_api_gateway_integration.alb_integration]                        
}

# API Gateway Deployment
resource "aws_api_gateway_deployment" "api_deployment" {                             
  depends_on  = [
    aws_api_gateway_method.proxy_method,
    aws_api_gateway_integration.alb_integration,
    aws_api_gateway_method_response.proxy_response,
    aws_api_gateway_integration_response.proxy_integration_response
  ]
  rest_api_id = aws_api_gateway_rest_api.api.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api.body))
  }
}

# API Gateway Stage
resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id                    
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.stage_name                                                  
}