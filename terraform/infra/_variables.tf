variable "compartment_id" {
  type        = string
  description = "The compartment to create the resources in"
}

variable "region" {
  description = "OCI region"
  type        = string

  default = "us-ashburn-1"
}

variable "ssh_public_key" {
  description = "SSH Public Key used to access all instances"
  type        = string

  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEzW05RnAIUAuW1wvgcPUApsCkn4zDs8SiQpeA2d80QD cmenghi@rwy.co"
}

variable "kubernetes_version" {
  # https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengaboutk8sversions.htm
  description = "Version of Kubernetes"
  type        = string

  default = "v1.34.1"
}

variable "kubernetes_worker_nodes" {
  description = "Worker node count"
  type        = number

  default = 2
}

variable "vault_id" {
  description = "OCI Vault OCID"
  type        = string
}
