variable "compartment_id" {
  type        = string
  description = "The compartment to create the resources in"
}

variable "vault_id" {
  type        = string
  description = "The OCID of the Vault to store the secrets in"
}

variable "tenancy_id" {
  type        = string
  description = "The OCID of the tenancy"
}

variable "region" {
  type        = string
  description = "OCI region"
}

variable "cloudflare_api_token" { type = string }
variable "github_dex_client_id" { type = string }
variable "github_dex_client_secret" { type = string }
variable "dex_grafana_client_secret" { type = string }
variable "dex_s3_proxy_client_secret" { type = string }
variable "dex_envoy_client_secret" { type = string }
variable "s3_proxy_access_key" { type = string }
variable "s3_proxy_secret_key" { type = string }
variable "slack_api_url" { type = string }
variable "github_flux_webhook_token" { type = string }
variable "slack_fluxcd_token" { type = string }
variable "gh_token" { type = string }
