data "oci_objectstorage_namespace" "ns" {
  compartment_id = var.compartment_id
}

resource "oci_objectstorage_bucket" "tourenbuch" {
  compartment_id = var.compartment_id
  name           = "tourenbuch"
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  access_type    = "NoPublicAccess"
  versioning     = "Disabled"
}

resource "oci_identity_user" "tourenbuch_user" {
  compartment_id = var.compartment_id
  name           = "tourenbuch-s3-user"
  description    = "User for Tourenbuch S3 access"
}

resource "oci_identity_group" "tourenbuch_group" {
  compartment_id = var.compartment_id
  name           = "tourenbuch-s3-group"
  description    = "Group for Tourenbuch S3 access"
}

resource "oci_identity_user_group_membership" "tourenbuch_membership" {
  group_id = oci_identity_group.tourenbuch_group.id
  user_id  = oci_identity_user.tourenbuch_user.id
}

resource "oci_identity_policy" "tourenbuch_policy" {
  compartment_id = var.compartment_id
  name           = "tourenbuch-s3-policy"
  description    = "Policy for Tourenbuch S3 access"

  statements = [
    "Allow group ${oci_identity_group.tourenbuch_group.name} to manage objects in compartment id ${var.compartment_id} where target.bucket.name='${oci_objectstorage_bucket.tourenbuch.name}'",
    "Allow group ${oci_identity_group.tourenbuch_group.name} to read buckets in compartment id ${var.compartment_id}"
  ]
}

resource "oci_identity_customer_secret_key" "tourenbuch_key" {
  user_id      = oci_identity_user.tourenbuch_user.id
  display_name = "tourenbuch-s3-key"
}

data "oci_kms_vault" "selected" {
  vault_id = var.vault_id
}

resource "oci_kms_key" "storage_key" {
  compartment_id = var.compartment_id
  display_name   = "tourenbuch-storage-key"
  key_shape {
    algorithm = "AES"
    length    = 32
  }
  management_endpoint = data.oci_kms_vault.selected.management_endpoint
}

resource "oci_vault_secret" "tourenbuch_access_key" {
  compartment_id = var.compartment_id
  secret_name    = "tourenbuch-s3-access-key"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.storage_key.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(oci_identity_customer_secret_key.tourenbuch_key.id)
  }
}

resource "oci_vault_secret" "tourenbuch_secret_key" {
  compartment_id = var.compartment_id
  secret_name    = "tourenbuch-s3-secret-key"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.storage_key.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode(oci_identity_customer_secret_key.tourenbuch_key.key)
  }
}

resource "oci_vault_secret" "tourenbuch_endpoint" {
  compartment_id = var.compartment_id
  secret_name    = "tourenbuch-s3-endpoint"
  vault_id       = var.vault_id
  key_id         = oci_kms_key.storage_key.id
  secret_content {
    content_type = "BASE64"
    content      = base64encode("https://${data.oci_objectstorage_namespace.ns.namespace}.compat.objectstorage.${var.region}.oraclecloud.com")
  }
}
