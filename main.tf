data "template_file" "values" {
  template   = "${file(var.values_path)}"
  vars       = var.chart_values
}

resource "helm_release" "this" {
  name             = var.release_name
  repository       = var.repo_url 
  chart            = var.chart_name
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = var.create_namespace

  values = [
    data.template_file.values.rendered
  ]

  dynamic set_helm_value {
    for_each = var.set_helm_values
    content {
      name = set_helm_value.key
      value = set_helm_value.value
    }
  }

  dynamic set_sensitive_value {
    for_each = var.set_sensitive_values
    content {
      name = set_sensitive_value.key
      value = set_sensitive_value.value
    }
  }
}