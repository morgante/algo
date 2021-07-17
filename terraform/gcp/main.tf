locals {
  project_id = "clf-morgantep-privacy"
}

module "project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 11.1"

  name            = local.project_id
  org_id          = var.organization_id
  billing_account = var.billing_account

  bucket_project    = local.project_id
  bucket_name       = "clf-privacy-tfstate"
  bucket_versioning = true

  activate_apis = [
    "compute.googleapis.com"
  ]
}

module "service_accounts" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "~> 4.0"
  project_id = module.project.project_id
  prefix     = "algo"
  names      = ["vpn"]
  project_roles = [
    "${local.project_id}=>roles/compute.admin",
    "${local.project_id}=>roles/iam.serviceAccountUser",
  ]
  generate_keys = true
  depends_on = [
    module.allow_key_download
  ]
}

resource "local_file" "sa_key" {
    content  = module.service_accounts.key
    filename = "${path.module}/configs/credentials.json"
}
