variable "release_name" {}
variable "repo_url" {}
variable "chart_name" {}
variable "chart_version" {}
variable "namespace" {}
variable "set_helm_values" {
  default = {}
}
variable "set_sensitive_values" {
  default = {}
}
variable "chart_values" {
  default = {}
}
variable "create_namespace" {
  default = false
}
variable "values_path" {}