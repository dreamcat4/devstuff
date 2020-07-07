#variable "dd2ef16da468564a15a8718734816b0e0a5102840f89c2bc8ab94b83586924ea" {}
variable "do_token" {}

# onfigure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}


data "digitalocean_ssh_key" "latitude7490" {
  name = "latitude7490"
}


#data "digitalocean_ssh_key" "ebbestad_linbast" {
  #name = "ebbestad_linbast"
#}
#
#
#data "digitalocean_ssh_key" "ryzen5" {
  #name = "ryzen5"
#}
#
#
#data "digitalocean_ssh_key" "yubikey_rundthalsen3" {
  #name = "yubikey_rundthalsen3"
#}
#
#
#data "digitalocean_ssh_key" "yubikey_laptop3" {
  #name = "yubikey_laptop3"
#}

# Create a new domain
resource "digitalocean_domain" "default" {
  name       = "habbis.pw"
  ip_address = digitalocean_droplet.test01.ipv4_address
}

resource "digitalocean_vpc" "fra2-net" {
  name     = "fra2-net"
  region   = "fra1"
  ip_range = "10.2.1.0/24"
}

data "digitalocean_volume" "media-stor" {
  name   = "media-stor"
  region = "nyc3"
}

resource "digitalocean_volume_attachment" "media-stor" {
  droplet_id = digitalocean_droplet.media01.id
  volume_id  = data.digitalocean_volume.example.id
}

resource "digitalocean_droplet" "media01" {
  name     = "media01"
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-18-04-x64"
  region   = "fra1"
  vpc_uuid = digitalocean_vpc.fra2-net.id
  ssh_keys = [data.digitalocean_ssh_key.latitude7490.id]
  #ip_address = digitalocean_droplet.test01.ipv4_address

}
