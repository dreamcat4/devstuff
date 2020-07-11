# deo is digitalocean
variable "do_token" {}

# onfigure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# my ssh keys in my digital ocean
data "digitalocean_ssh_key" "latitude7490" {
  name = "latitude7490"
}


data "digitalocean_ssh_key" "ebbestad_linbast" {
  name = "ebbestad_linbast"
}


data "digitalocean_ssh_key" "yubikey_rundthalsen3" {
  name = "yubikey_rundthalsen3"
}


data "digitalocean_ssh_key" "yubikey_laptop3" {
  name = "yubikey_laptop3"
}


data "digitalocean_ssh_key" "ryzen5" {
  name = "ryzen5"
}


# This creates a new domain if destroy will delete domain from deo account

#resource "digitalocean_domain" "default" {
  #name       = "habbis.pw"
  #ip_address = digitalocean_droplet.test01.ipv4_address
#}

# privat network setup deo will be removed when destroyed
resource "digitalocean_vpc" "fra2-net" {
  name     = "fra2-net"
  region   = "fra1"
  ip_range = "10.2.1.0/24"
}

# create volume for storage
#data "digitalocean_volume" "media-stor" {
  #name   = "media-stor"
  #region = "fra1"
#}

# example of attach volume to server
#resource "digitalocean_volume_attachment" "media-stor" {
  #droplet_id = digitalocean_droplet.media01.id
  #volume_id  = data.digitalocean_volume.media-stor.id
#}


# create server
resource "digitalocean_droplet" "cloudbast01" {
  name     = "cloudbast01"
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-18-04-x64"
  region   = "fra1"
  vpc_uuid = digitalocean_vpc.fra2-net.id
  ssh_keys = [data.digitalocean_ssh_key.latitude7490.id, data.digitalocean_ssh_key.ryzen5.id, data.digitalocean_ssh_key.ebbestad_linbast.id, data.digitalocean_ssh_key.yubikey_rundthalsen3.id, data.digitalocean_ssh_key.yubikey_laptop3.id ]
  #ip_address = digitalocean_droplet.test01.ipv4_address

}

# create server
resource "digitalocean_droplet" "media01" {
  name     = "media01"
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-18-04-x64"
  region   = "fra1"
  vpc_uuid = digitalocean_vpc.fra2-net.id
  ssh_keys = [data.digitalocean_ssh_key.latitude7490.id, data.digitalocean_ssh_key.ryzen5.id, data.digitalocean_ssh_key.ebbestad_linbast.id, data.digitalocean_ssh_key.yubikey_rundthalsen3.id, data.digitalocean_ssh_key.yubikey_laptop3.id ]
  #ip_address = digitalocean_droplet.test01.ipv4_address

}

# create server
resource "digitalocean_droplet" "media02" {
  name     = "media02"
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-18-04-x64"
  region   = "fra1"
  vpc_uuid = digitalocean_vpc.fra2-net.id
  ssh_keys = [data.digitalocean_ssh_key.latitude7490.id, data.digitalocean_ssh_key.ryzen5.id, data.digitalocean_ssh_key.ebbestad_linbast.id, data.digitalocean_ssh_key.yubikey_rundthalsen3.id, data.digitalocean_ssh_key.yubikey_laptop3.id ]
  #ip_address = digitalocean_droplet.test01.ipv4_address

}


# firewall rules with more than one droplet defined
resource "digitalocean_firewall" "cloudbast" {
  name = "cloudbast-allow-out-HTTPS-HTTP-in-SSH-from-any"

  droplet_ids = [digitalocean_droplet.cloudbast01.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
}

# allow out from ubuntu source.list
# digitaloceanmirrors.com,security.ubuntu.com, archive.ubuntu.com

  outbound_rule {
    protocol         = "tcp"
    port_range       = "all"
    destination_addresses = ["104.24.116.209/32", "104.24.117.209/32", "172.67.168.253/32", "91.189.88.142/32", "91.189.88.152/32", "91.189.91.38/32", "91.189.91.39/32", "91.189.88.142/32", "91.189.88.152/32"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    destination_addresses = ["104.24.116.209/32", "104.24.117.209/32", "172.67.168.253/32", "91.189.88.142/32", "91.189.88.152/32", "91.189.91.38/32", "91.189.91.39/32", "91.189.88.142/32", "91.189.88.152/32"]
  }
  outbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    destination_addresses = ["104.24.116.209/32", "104.24.117.209/32", "172.67.168.253/32", "91.189.88.142/32", "91.189.88.152/32", "91.189.91.38/32", "91.189.91.39/32", "91.189.88.142/32", "91.189.88.152/32"]
}

  outbound_rule {
    protocol         = "tcp"
    port_range       = "53"
    destination_addresses = ["104.24.116.209/32", "104.24.117.209/32", "172.67.168.253/32", "91.189.88.142/32", "91.189.88.152/32", "91.189.91.38/32", "91.189.91.39/32", "91.189.88.142/32", "91.189.88.152/32"]
  }

  outbound_rule {
    protocol         = "udp"
    port_range       = "53"
    destination_addresses = ["104.24.116.209/32", "104.24.117.209/32", "172.67.168.253/32", "91.189.88.142/32", "91.189.88.152/32", "91.189.91.38/32", "91.189.91.39/32", "91.189.88.142/32", "91.189.88.152/32"]
  }
 }

# firewall rules with more than one droplet defined
resource "digitalocean_firewall" "media" {
  name = "app-allow-out-HTTPS-HTTP-in-SSH-from-fra2"

  droplet_ids = [digitalocean_droplet.media01.id, digitalocean_droplet.media02.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["10.2.1.0/24"]
}

# allow out from ubuntu source.list
# digitaloceanmirrors.com,security.ubuntu.com, archive.ubuntu.com

  outbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    destination_addresses = ["104.24.116.209/32", "104.24.117.209/32", "172.67.168.253/32", "91.189.88.142/32", "91.189.88.152/32", "91.189.91.38/32", "91.189.91.39/32", "91.189.88.142/32", "91.189.88.152/32"]
  }
  outbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    destination_addresses = ["104.24.116.209/32", "104.24.117.209/32", "172.67.168.253/32", "91.189.88.142/32", "91.189.88.152/32", "91.189.91.38/32", "91.189.91.39/32", "91.189.88.142/32", "91.189.88.152/32"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "53"
    destination_addresses = ["104.24.116.209/32", "104.24.117.209/32", "172.67.168.253/32", "91.189.88.142/32", "91.189.88.152/32", "91.189.91.38/32", "91.189.91.39/32", "91.189.88.142/32", "91.189.88.152/32"]
  }

  outbound_rule {
    protocol         = "udp"
    port_range       = "53"
    destination_addresses = ["104.24.116.209/32", "104.24.117.209/32", "172.67.168.253/32", "91.189.88.142/32", "91.189.88.152/32", "91.189.91.38/32", "91.189.91.39/32", "91.189.88.142/32", "91.189.88.152/32"]
  }
}
