provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

# Example DNS record
# resource "cloudflare_dns_record" "k8s_api" {
#   zone_id = var.cloudflare_zone_id
#   name    = "k8s"
#   content   = "REPLACE_WITH_LB_IP"
#   type    = "A"
#   proxied = true
# }
