resource "kubectl_manifest" "external_secrets_namespace" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: external-secrets
YAML
}

resource "kubectl_manifest" "external_secrets_api_secret" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: oracle-vault
  namespace: external-secrets
type: Opaque
data:
  privateKey: ${base64encode(tls_private_key.external_secrets.private_key_pem)}
  fingerprint: ${base64encode(oci_identity_api_key.external_secrets.fingerprint)}
YAML
}

resource "kubectl_manifest" "external_secrets_cluster_store" {
  yaml_body = <<YAML
apiVersion: external-secrets.io/v1
kind: ClusterSecretStore
metadata:
  name: oracle-vault
spec:
  provider:
    oracle:
      vault: "${var.vault_id}"
      region: "${var.region}"
      auth:
        user: "${oci_identity_user.external_secrets.id}"
        tenancy: "${var.tenancy_id}"
        principalType: UserPrincipal
        secretRef:
          privatekey:
            name: oracle-vault
            key: privateKey
            namespace: external-secrets
          fingerprint:
            name: oracle-vault
            key: fingerprint
            namespace: external-secrets
YAML
}

data "oci_kms_vault" "selected" {
  vault_id = var.vault_id
}

resource "oci_kms_key" "external_secrets" {
  compartment_id = var.compartment_id
  display_name   = "external-secrets-key"
  key_shape {
    algorithm = "AES"
    length    = 32
  }
  management_endpoint = data.oci_kms_vault.selected.management_endpoint
}

locals {
  secrets = {
    "cloudflare-api-token"       = var.cloudflare_api_token
    "GITHUB_DEX_CLIENT_ID"       = var.github_dex_client_id
    "GITHUB_DEX_CLIENT_SECRET"   = var.github_dex_client_secret
    "dex-grafana-client"         = var.dex_grafana_client_secret
    "dex-s3-proxy-client-secret" = var.dex_s3_proxy_client_secret
    "dex-envoy-client-secret"    = var.dex_envoy_client_secret
    "s3-proxy-access_key"   = var.s3_proxy_access_key
    "s3-proxy-secret_key"   = var.s3_proxy_secret_key
    "SLACK_API_URL"              = var.slack_api_url
    "github-flux-webhook-token"  = var.github_flux_webhook_token
    "github-fluxcd-token"        = var.gh_token
    "slack-fluxcd-token"         = var.slack_fluxcd_token
  }
}

resource "oci_vault_secret" "cloudflare_api_token" {
  count          = var.cloudflare_api_token != "" ? 1 : 0
  compartment_id = var.compartment_id
  secret_name    = "cloudflare-api-token"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.external_secrets.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.cloudflare_api_token)
  }
}

resource "oci_vault_secret" "github_dex_client_id" {
  count          = var.github_dex_client_id != "" ? 1 : 0
  compartment_id = var.compartment_id
  secret_name    = "GITHUB_DEX_CLIENT_ID"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.external_secrets.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.github_dex_client_id)
  }
}

resource "oci_vault_secret" "github_dex_client_secret" {
  count          = var.github_dex_client_secret != "" ? 1 : 0
  compartment_id = var.compartment_id
  secret_name    = "GITHUB_DEX_CLIENT_SECRET"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.external_secrets.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.github_dex_client_secret)
  }
}

resource "oci_vault_secret" "dex_grafana_client" {
  count          = var.dex_grafana_client_secret != "" ? 1 : 0
  compartment_id = var.compartment_id
  secret_name    = "dex-grafana-client-v2"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.external_secrets.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.dex_grafana_client_secret)
  }
}

resource "oci_vault_secret" "dex_s3_proxy_client_secret" {
  count          = var.dex_s3_proxy_client_secret != "" ? 1 : 0
  compartment_id = var.compartment_id
  secret_name    = "dex-s3-proxy-client-secret-v2"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.external_secrets.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.dex_s3_proxy_client_secret)
  }
}

resource "oci_vault_secret" "dex_envoy_client_secret" {
  count          = var.dex_envoy_client_secret != "" ? 1 : 0
  compartment_id = var.compartment_id
  secret_name    = "dex-envoy-client-secret-v2"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.external_secrets.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.dex_envoy_client_secret)
  }
}

resource "oci_vault_secret" "s3_proxy_access_key" {
  count          = var.s3_proxy_access_key != "" ? 1 : 0
  compartment_id = var.compartment_id
  secret_name    = "s3-proxy-user-access_key"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.external_secrets.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.s3_proxy_access_key)
  }
}

resource "oci_vault_secret" "s3_proxy_secret_key" {
  count          = var.s3_proxy_secret_key != "" ? 1 : 0
  compartment_id = var.compartment_id
  secret_name    = "s3-proxy-user-secret_key"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.external_secrets.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.s3_proxy_secret_key)
  }
}

resource "oci_vault_secret" "slack_api_url" {
  count          = var.slack_api_url != "" ? 1 : 0
  compartment_id = var.compartment_id
  secret_name    = "SLACK_API_URL"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.external_secrets.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.slack_api_url)
  }
}

resource "oci_vault_secret" "github_flux_webhook_token" {
  count          = var.github_flux_webhook_token != "" ? 1 : 0
  compartment_id = var.compartment_id
  secret_name    = "github-flux-webhook-token"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.external_secrets.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.github_flux_webhook_token)
  }
}

resource "oci_vault_secret" "github_fluxcd_token" {
  count          = var.gh_token != "" ? 1 : 0
  compartment_id = var.compartment_id
  secret_name    = "github-fluxcd-token"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.external_secrets.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.gh_token)
  }
}

resource "oci_vault_secret" "slack_fluxcd_token" {
  count          = var.slack_fluxcd_token != "" ? 1 : 0
  compartment_id = var.compartment_id
  secret_name    = "slack-fluxcd-token"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.external_secrets.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.slack_fluxcd_token)
  }
}
