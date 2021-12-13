// ----------------------------------------------------------------------------
// Optional Variables
// ----------------------------------------------------------------------------
variable "region" {
  description = "AWS region code for creating resources."
  type        = string
}

variable "profile" {
  description = "Profile stored in aws config or credentials file"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
  default     = "1.20"
}

variable "vault_user" {
  description = "The AWS IAM Username whose credentials will be used to authenticate the Vault pods against AWS"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster to create"
  type        = string
}

variable "force_destroy" {
  description = "Flag to determine whether storage buckets get forcefully destroyed. If set to false, empty the bucket first in the aws s3 console, else terraform destroy will fail with BucketNotEmpty error"
  type        = bool
  default     = false
}

variable "jx_git_url" {
  description = "URL for the Jenins X cluster git repository"
  type        = string
}

variable "jx_bot_username" {
  description = "Bot username used to interact with the Jenkins X cluster git repository"
  type        = string
}

variable "jx_bot_token" {
  description = "Bot token used to interact with the Jenkins X cluster git repository"
  type        = string
}

variable "volume_size" {
  type    = string
  default = 100
}

variable "desired_node_count" {
  description = "The number of worker nodes to use for the cluster"
  type        = number
  default     = 3
}

variable "min_node_count" {
  description = "The minimum number of worker nodes to use for the cluster"
  type        = number
  default     = 3
}

variable "max_node_count" {
  description = "The maximum number of worker nodes to use for the cluster"
  type        = number
  default     = 5
}

variable "node_machine_type" {
  description = "The instance type to use for the cluster's worker nodes"
  type        = string
  default     = "m5.large"
}

// ----------------------------------------------------------------------------
// External DNS Variables
// ----------------------------------------------------------------------------
variable "enable_external_dns" {
  description = "Flag to enable or disable External DNS in the final `jx-requirements.yml` file"
  type        = bool
  default     = true
}

variable "apex_domain" {
  description = "The main domain to either use directly or to configure a subdomain from"
  type        = string
  default     = ""
}

variable "subdomain" {
  description = "The subdomain to be added to the apex domain. If subdomain is set, it will be appended to the apex domain in  `jx-requirements-eks.yml` file"
  type        = string
  default     = ""
}

variable "tls_email" {
  description = "The email to register the LetsEncrypt certificate with. Added to the `jx-requirements.yml` file"
  type        = string
  default     = ""
}

variable "create_and_configure_subdomain" {
  description = "Flag to create an NS record set for the subdomain in the apex domain's Hosted Zone"
  type        = bool
  default     = false
}

variable "enable_tls" {
  description = "Flag to enable TLS in the final `jx-requirements.yml` file"
  type        = bool
  default     = false
}

variable "lets_encrypt_production" {
  description = "Flag to use the production environment of letsencrypt in the `jx-requirements.yml` file"
  type        = bool
  default     = false
}


variable "nginx_chart_version" {
  type        = string
  description = "nginx chart version"
  default     = "3.12.0"
}

variable "install_kuberhealthy" {
  description = "Flag to specify if kuberhealthy operator should be installed"
  type        = bool
  default     = true
}
