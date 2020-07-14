terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
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

resource "cloudflare_page_rule" "nowww" {
  zone_id  = cloudflare_zone.zone.id
  target   = "seemy.energy/*"
  priority = 1

  actions {
    forwarding_url {
      url         = "https://github.com/seemy-energy"
      status_code = 301
    }
  }
}

resource "cloudflare_page_rule" "www" {
  zone_id  = cloudflare_zone.zone.id
  target   = "www.seemy.energy/*"
  priority = 1

  actions {
    forwarding_url {
      url         = "https://github.com/seemy-energy"
      status_code = 301
    }
  }
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.zone.id
  name    = "www"
  value   = "45.55.72.95"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "A" {
  zone_id = cloudflare_zone.zone.id
  name    = "@"
  value   = "45.55.72.95"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "WWW_REDIRECT" {
  zone_id = cloudflare_zone.zone.id
  name    = "_redirect.www"
  value   = "Redirects from /* to https://github.com/seemy-energy/*"
  type    = "TXT"
}

resource "cloudflare_record" "A_REDIRECT" {
  zone_id = cloudflare_zone.zone.id
  name    = "_redirect"
  value   = "Redirects from /* to https://github.com/seemy-energy/*"
  type    = "TXT"
}


resource "cloudflare_record" "googleverification" {
  zone_id = cloudflare_zone.zone.id
  name    = "google-site-verification"
  value   = "HVWM7CJx3Mim1-71i8yqfk_4t-6NsqeIypG8PSQvF9o"
  type    = "TXT"
}

resource "cloudflare_record" "googleverification2" {
  zone_id = cloudflare_zone.zone.id
  name    = "fm7ueftxkl4c"
  value   = "gv-xl2g3o6tpsi77p.dv.googlehosted.com"
  type    = "CNAME"
}

resource "cloudflare_record" "githubverification" {
  zone_id = cloudflare_zone.zone.id
  name    = "_github-challenge-seemy-energy"
  value   = "f5dee3f587"
  type    = "TXT"
}

resource "cloudflare_record" "google-mx1" {
  zone_id  = cloudflare_zone.zone.id
  priority = 1
  name     = "@"
  value    = "ASPMX.L.GOOGLE.COM"
  type     = "MX"
}

resource "cloudflare_record" "google-mx2" {
  zone_id  = cloudflare_zone.zone.id
  priority = 5
  name     = "@"
  value    = "ALT1.ASPMX.L.GOOGLE.COM"
  type     = "MX"
}

resource "cloudflare_record" "google-mx3" {
  zone_id  = cloudflare_zone.zone.id
  priority = 5
  name     = "@"
  value    = "ALT2.ASPMX.L.GOOGLE.COM"
  type     = "MX"
}

resource "cloudflare_record" "google-mx3" {
  zone_id  = cloudflare_zone.zone.id
  priority = 10
  name     = "@"
  value    = "ALT3.ASPMX.L.GOOGLE.COM"
  type     = "MX"
}

resource "cloudflare_record" "google-mx4" {
  zone_id  = cloudflare_zone.zone.id
  priority = 10
  name     = "@"
  value    = "ALT4.ASPMX.L.GOOGLE.COM"
  type     = "MX"
}
