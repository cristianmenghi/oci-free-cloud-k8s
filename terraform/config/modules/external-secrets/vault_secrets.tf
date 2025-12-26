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

