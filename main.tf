provider "aws" {
  region  = var.region
  profile = var.profile
}

module "eks-jx" {
  source          = "github.com/jenkins-x/terraform-aws-eks-jx?ref=v1.15.12"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  region          = var.region
  vault_user      = var.vault_user
  is_jx2          = false
  jx_git_url      = var.jx_git_url
  jx_bot_username = var.jx_bot_username
  jx_bot_token    = var.jx_bot_token
  force_destroy   = var.force_destroy

  volume_size = var.volume_size

  apex_domain                    = var.apex_domain
  subdomain                      = var.subdomain
  create_and_configure_subdomain = var.create_and_configure_subdomain
  enable_external_dns            = var.enable_external_dns

  production_letsencrypt = var.lets_encrypt_production
  node_machine_type      = var.node_machine_type
  tls_email              = var.tls_email
  enable_tls             = var.enable_tls
  min_node_count         = var.min_node_count
  max_node_count         = var.max_node_count
  desired_node_count     = var.desired_node_count

  nginx_chart_version  = var.nginx_chart_version
  install_kuberhealthy = var.install_kuberhealthy
}


// IF YOU NEED ADD access to docker repository from external AWS account/EKS (multi-cluster setup)
//provider "aws" {
//  region  = var.region
//  profile = var.profile
//}


//resource "aws_ecr_repository_policy" "test-sk-app-repo-policy" {
//  repository = "REPLACE_REPO_NAME"
//
//  policy = <<EOF
//{
//    "Version": "2008-10-17",
//    "Statement": [
//        {
//            "Sid": "AllowCrossAccountPull",
//            "Effect": "Allow",
//            "Principal": {
//                "AWS": "arn:aws:iam::REPLACE_ACC_ID:root"
//            },
//            "Action": [
//                "ecr:BatchCheckLayerAvailability",
//                "ecr:BatchGetImage",
//                "ecr:GetDownloadUrlForLayer"
//            ]
//        }
//    ]
//}
//EOF
//}