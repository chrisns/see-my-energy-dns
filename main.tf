terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "seemy-energy"

    workspaces {
      name = "dns"
    }
  }
}

provider "cloudflare" {
  version = "~> 2.0"
  email   = "chris@cns.me.uk"
}

resource "cloudflare_zone" "zone" {
  zone = "seemy.energy"
}

resource "cloudflare_page_rule" "www" {
  zone_id = cloudflare_zone.zone.id
  target = "*"
  priority = 1

  actions {
    forwarding_url {
      url = "https://github.com/seemy-energy"
      status_code = 301
    } 
  }
}