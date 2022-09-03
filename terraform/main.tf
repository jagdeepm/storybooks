terraform {
  backend "gcs" {
    bucket = "learn-terraform-358921-terraform"
    prefix = "/state/storybooks"
  }
  
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "1.4.3"
    }
  }
}