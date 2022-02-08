provider "aws" {
  region = var.region
}

module "eks-jx" {
  source                  = "github.com/vitech-team-sdlc/terraform-aws-eks-jx?ref=v1.18.6-rc-11"
  cluster_name            = var.cluster_name
  cluster_version         = var.cluster_version
  region                  = var.region
  vault_user              = var.vault_user
  is_jx2                  = false
  jx_git_url              = var.jx_git_url
  jx_bot_username         = var.jx_bot_username
  jx_bot_token            = var.jx_bot_token
  force_destroy           = var.force_destroy
  force_destroy_subdomain = var.force_destroy_subdomain

  create_nginx                   = true
  apex_domain                    = var.apex_domain
  subdomain                      = var.subdomain
  create_and_configure_subdomain = var.create_and_configure_subdomain
  enable_external_dns            = var.enable_external_dns

  production_letsencrypt = var.production_letsencrypt
  tls_email              = var.tls_email
  enable_tls             = var.enable_tls

  hosted_access_key                     = var.hosted_access_key
  hosted_secret_key                     = var.hosted_secret_key
  domain_registered_in_same_aws_account = var.domain_registered_in_same_aws_account

  enable_k8s_deployment_cluster_autoscaler = var.enable_k8s_deployment_cluster_autoscaler

  nginx_chart_version                  = var.nginx_chart_version
  install_kuberhealthy                 = var.install_kuberhealthy
  enable_spot_instances                = var.enable_spot_instances
  enable_worker_groups_launch_template = var.enable_worker_groups_launch_template
  workers                              = var.workers
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
