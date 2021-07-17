terraform {
  backend "gcs" {
    bucket  = "clf-privacy-tfstate"
    prefix  = "terraform/state"
  }
}
