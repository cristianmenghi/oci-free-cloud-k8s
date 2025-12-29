output "k8s_cluster_id" {
  value = oci_containerengine_cluster.k8s_cluster.id
}

output "compartment_id" {
  value = var.compartment_id
}

output "public_subnet_id" {
  value = oci_core_subnet.vcn_public_subnet.id
}

output "node_pool_id" {
  value = oci_containerengine_node_pool.k8s_node_pool.id
}

output "kubernetes_version" {
  value = var.kubernetes_version
}

output "s3_access_key" {
  value     = oci_identity_customer_secret_key.tourenbuch_key.id
  sensitive = true
}

output "s3_secret_key" {
  value     = oci_identity_customer_secret_key.tourenbuch_key.key
  sensitive = true
}

output "s3_endpoint" {
  value = "https://${data.oci_objectstorage_namespace.ns.namespace}.compat.objectstorage.${var.region}.oraclecloud.com"
}
