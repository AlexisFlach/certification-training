terraform {
  cloud {
    organization = "flachen"

    workspaces {
      name = "provisioners"
    }
  }
}