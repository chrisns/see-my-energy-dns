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

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.zone.id
  name    = "www"
  value   = "45.55.72.95"
  type    = "A"
  ttl     = 3600
}


resource "cloudflare_record" "nowww" {
  zone_id = cloudflare_zone.zone.id
  name    = "@"
  value   = "45.55.72.95"
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "txt" {
  zone_id = cloudflare_zone.zone.id
  name    = "_redirect"
  value   = "Redirects from /* to https://github.com/seemy-energy/*"
  type    = "TXT"
  ttl     = 3600
}