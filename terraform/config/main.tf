module "externalsecrets" {
  source = "./modules/external-secrets"

  compartment_id = var.compartment_id
  tenancy_id     = var.tenancy_id
  region         = var.region
  vault_id       = var.vault_id
  cloudflare_api_token = var.cloudflare_api_token
  github_dex_client_id = var.github_dex_client_id
  github_dex_client_secret = var.github_dex_client_secret
  dex_grafana_client_secret = var.dex_grafana_client
  dex_s3_proxy_client_secret = var.dex_s3_proxy_client
  dex_envoy_client_secret = var.dex_envoy_client
  s3_proxy_access_key = var.s3_proxy_access_key
  s3_proxy_secret_key = var.s3_proxy_secret_key
  slack_api_url = var.slack_api_url
  github_flux_webhook_token = var.github_flux_webhook_token
  slack_fluxcd_token = var.slack_fluxcd_token
  gh_token = var.gh_token

}

module "fluxcd" {
  source = "./modules/fluxcd"

  gh_org                     = var.gh_org
  gh_repository              = var.gh_repository
  git_url                    = "https://github.com/${var.gh_org}/${var.gh_repository}.git"
  gh_token                   = var.gh_token
  compartment_id             = var.compartment_id
  github_app_id              = var.github_app_id
  github_app_installation_id = var.github_app_installation_id
  github_app_pem             = var.github_app_pem
}

module "ingress" {
  source = "./modules/ingress"

  compartment_id = var.compartment_id
}

module "grafana" {
  source = "./modules/grafana"

  compartment_id = var.compartment_id
  tenancy_id     = var.tenancy_id
}
