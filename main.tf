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

  dynamic set {
    for_each = var.set_helm_values
    content {
      name = set.key
      value = set.value
    }
  }

  dynamic set_sensitive {
    for_each = var.set_sensitive_values
    content {
      name = set_sensitive.key
      value = set_sensitive.value
    }
  }
}