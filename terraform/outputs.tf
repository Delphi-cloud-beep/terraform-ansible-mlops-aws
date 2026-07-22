output "ec2_public_ip" {
  description = "Adresse IP publique de l'EC2"
  value       = aws_instance.mlops_server.public_ip
}

output "s3_bucket_name" {
  description = "Nom du bucket S3 pour les artefacts"
  value       = aws_s3_bucket.ml_artifacts.id
}