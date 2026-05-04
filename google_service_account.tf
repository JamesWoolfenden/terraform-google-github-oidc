resource "google_service_account" "github_actions" {
  project      = var.project_id
  account_id   = "github-actions-terraform"
  display_name = "GitHub Actions Terraform"
}

resource "google_service_account_iam_binding" "workload_identity" {
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.org/${var.github_org}",
  ]
}

resource "google_project_iam_member" "github_actions" {
  for_each = toset(var.project_roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.github_actions.email}"

  # Scope this down per-module using Pike once working
}
