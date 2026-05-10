output "alb_dns_name" {
  description = "The URL of your deployed app"
  value       = "http://${aws_lb.main.dns_name}"
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}
