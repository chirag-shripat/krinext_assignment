## Making Load Balancer target group
resource "aws_lb_target_group" "TG-for-lb" {
    name = "TG-for-LB"
    target_type = "instance"
    protocol = "HTTP"
    port = "80"
    vpc_id = aws_vpc.vpc-for-project.id

    tags = {
    Name="Default TG"
  }
}

## Making load balancer
resource "aws_lb" "ALB" {
    name = "ALB"
    load_balancer_type = "application"
    internal = false
    #subnets = ["public-subnet", "public-subnet2"]
    subnets = [aws_subnet.public-subnet.id, aws_subnet.public-subnet2.id ]
    security_groups = [aws_security_group.project-sg.id]

    tags = {
      "Name" = "alb"
    }
}

## Listeners and routing
resource "aws_lb_listener" "listen" {
    load_balancer_arn = aws_lb.ALB.arn
    port = "80"
    protocol = "HTTP"
    
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.TG-for-lb.arn
    }
}
