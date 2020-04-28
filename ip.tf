# Not managed by Terraform (just a reference to existing resource)
data "digitalocean_floating_ip" "public-ip" {
  ip_address = "157.245.25.142"
}

resource "digitalocean_floating_ip_assignment" "public-ip" {
  ip_address = data.digitalocean_floating_ip.public-ip.ip_address
  droplet_id = digitalocean_droplet.minitwit-swarm-leader.id
}

output "public_ip" {
  value = data.digitalocean_floating_ip.public-ip.ip_address
}
