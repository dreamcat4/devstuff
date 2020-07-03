variable "do_token" {}


data "digitalocean_ssh_key" "example" {
  name = "example"
}

resource "digitalocean_vpc" "example" {
  name     = "example-project-network"
  region   = "fra1"
}

resource "digitalocean_droplet" "example" {
  name     = "example-01"
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-18-04-x64"
  region   = "fra1"
  vpc_uuid = digitalocean_vpc.example.id
  ssh_keys = [data.digitalocean_ssh_key.example.id]
}
