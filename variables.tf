variable "github_org" {
  description = "GitHub organisation name to trust (e.g. JamesWoolfenden)"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "project_roles" {
  description = "GCP project roles to grant the service account (scope down with Pike once working)"
  type        = list(string)
  default     = ["roles/viewer"]
}
