provider "aws" {
  region  = "us-east-2"
}

module "eks-jx" {
  source              = "github.com/vitech-team-sdlc/terraform-aws-eks-jx?ref=v1.18.6-rc-1"
  cluster_name        = "apentsak"
  cluster_version     = "1.20"
  region              = "us-east-2"
  vault_user          = ""
  is_jx2              = false
  jx_git_url          = "https://github.com/AndrewsBot/dev-env.git"
  jx_bot_username     = "AndrewsBot"
  jx_bot_token        = var.jx_bot_token
  force_destroy       = true
  nginx_chart_version = "3.34.0"

  enable_spot_instances                = true
  enable_worker_groups_launch_template = true

  enable_tls                     = true
  force_destroy_subdomain        = true
  create_nginx                   = true
  apex_domain                    = "sdlcvitech.com"
  subdomain                      = "apentsak"
  create_and_configure_subdomain = true
  production_letsencrypt         = false

  workers = {

    main = {
      k8s_labels              = ""
      k8s_taints              = ""
      on_demand_base_capacity = 1
      asg_min_size            = 1
      asg_max_size            = 3
      asg_desired_capacity    = 1
      root_volume_size        = 60
      root_encrypted          = true
      tags                    = [
      ]
      override_instance_types = [
        "m5.large"
      ]
    }

    pipelines = {
      k8s_labels              = "pipeline=true"
      k8s_taints              = "pipelines=true:PreferNoSchedule"
      on_demand_base_capacity = 0
      asg_min_size            = 1
      asg_max_size            = 1
      asg_desired_capacity    = 1
      root_volume_size        = 10
      root_encrypted          = true
      tags                    = [
        {
          key                 = "pipeline"
          propagate_at_launch = "true"
          value               = "true"
        }
      ]
      override_instance_types = [
        "m5.xlarge", "m5a.xlarge", "m5d.xlarge", "m5ad.xlarge", "m5n.xlarge", "m5.2xlarge", "m5a.2xlarge", "m5d.2xlarge", "m5ad.2xlarge", "m5n.2xlarge"
      ]
    }
  }
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