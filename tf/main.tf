# Configure the DigitalOcean Provider
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the Droplet
resource "digitalocean_droplet" "web" {
  image  = "fedora-41-x64"
  name   = "mcprp"
  region = "syd1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.default.id,
  ]
}

data "digitalocean_ssh_key" "default" {
  name = "frame2ssh"
}

output "public_ip" {
  value = digitalocean_droplet.web.ipv4_address
}