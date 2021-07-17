module "allow_key_download" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 3.0.2"

  constraint        = "constraints/iam.disableServiceAccountKeyCreation"
  policy_type       = "boolean"
  enforce           = false

  policy_for = "project"
  project_id = module.project.project_id
}

module "allow_external_access" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 5.0"

  constraint        = "constraints/compute.vmExternalIpAccess"
  policy_type       = "list"
  enforce           = false

  policy_for = "project"
  project_id = module.project.project_id
}
