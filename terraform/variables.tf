variable "aws_region" {
  description = "Région AWS pour le déploiement"
  type        = string
  default     = "eu-west-3"
}

variable "environment" {
  description = "Environnement de déploiement (dev, prod...)"
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "Taille de l'instance EC2"
  type        = string
  default     = "t3.medium"
}

variable "public_key" {
  description = "Contenu brut de la clé SSH publique"
  type        = string
}