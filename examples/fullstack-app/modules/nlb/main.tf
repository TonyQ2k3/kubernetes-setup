# Create a target group for the NLB
resource "aws_lb_target_group" "k8s_nlb_target_group" {
  name        = "${var.nlb_name}-tg"
  port        = 6443
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    protocol = "TCP"
    port     = 22
  }

  tags = {
    Name = "${var.nlb_name}-tg"
  }
}

# Register the NLB target group with the Kubernetes API server instances
resource "aws_lb_target_group_attachment" "k8s_nlb_target_group_attachment" {
  count            = var.node_count
  target_group_arn = aws_lb_target_group.k8s_nlb_target_group.arn
  target_id        = var.k8s_api_instance_ids[count.index]
  port             = 6443
}

# Create a Network Load Balancer (NLB) for Kubernetes API servers
resource "aws_lb" "k8s_nlb" {
  name               = var.nlb_name
  internal           = false
  load_balancer_type = "network"
  security_groups    = var.nlb_security_groups
  subnets            = var.nlb_subnets

  enable_deletion_protection = false

  tags = {
    Name = var.nlb_name
  }
}

# Create a listener for the NLB to forward traffic to the target group
resource "aws_lb_listener" "k8s_nlb_listener" {
  load_balancer_arn = aws_lb.k8s_nlb.arn
  port              = 6443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.k8s_nlb_target_group.arn
  }
}