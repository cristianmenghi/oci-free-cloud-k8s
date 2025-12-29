variable "compartment_id" {
  type        = string
  description = "The compartment to create the resources in"
}

variable "region" {
  description = "OCI region"
  type        = string

  default = ""us-ashburn-1"
}

variable "public_subnet_id" {
  type        = string
  description = "The public subnet's OCID"
}

variable "node_pool_id" {
  description = "The OCID of the Node Pool where the compute instances reside"
  type        = string
}

variable "vault_id" {
  description = "OCI Vault OIDC"
  type        = string
}

variable "tenancy_id" {
  description = "Tenancy OCID"
  type        = string
}

variable "gh_token" {
  description = "Github PAT for FluxCD"
  type        = string
}

variable "github_app_id" {
  description = "GitHub App ID"
  type        = string
  default     = ""
}

variable "github_app_installation_id" {
  description = "GitHub App Installation ID"
  type        = string
  default     = ""
}

variable "github_app_pem" {
  description = "The contents of the GitHub App private key PEM file"
  sensitive   = true
  type        = string
  default     = ""
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "gh_org" {
  description = "GitHub Organization/User"
  type        = string
  default     = "cristianmenghi"
}

variable "gh_repository" {
  description = "GitHub Repository"
  type        = string
  default     = "oci-free-cloud-k8s"
}

variable "github_dex_client_id" {
  description = "GitHub OAuth Client ID for Dex"
  type        = string
  default     = ""
}

variable "github_dex_client_secret" {
  description = "GitHub OAuth Client Secret for Dex"
  type        = string
  sensitive   = true
  default     = ""
}

variable "dex_grafana_client" {
  description = "Shared secret between Dex and Grafana"
  type        = string
  sensitive   = true
  default     = ""
}

variable "dex_s3_proxy_client" {
  description = "Shared secret between Dex and S3 Proxy"
  type        = string
  sensitive   = true
  default     = ""
}

variable "dex_envoy_client" {
  description = "Shared secret between Dex and Envoy Gateway"
  type        = string
  sensitive   = true
  default     = ""
}

variable "s3_proxy_access_key" {
  description = "OCI S3 Access Key for S3 Proxy"
  type        = string
  sensitive   = true
  default     = ""
}

variable "s3_proxy_secret_key" {
  description = "OCI S3 Secret Key for S3 Proxy"
  type        = string
  sensitive   = true
  default     = ""
}

variable "slack_api_url" {
  description = "Slack Webhook URL for monitoring"
  type        = string
  sensitive   = true
  default     = ""
}

variable "github_flux_webhook_token" {
  description = "FluxCD Webhook Token for GitHub"
  type        = string
  sensitive   = true
  default     = ""
}

variable "slack_fluxcd_token" {
  description = "Slack Token for FluxCD Notifications"
  type        = string
  sensitive   = true
  default     = ""
}
