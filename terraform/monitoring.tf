resource "google_logging_metric" "cloudrun_error_metric" {

  name = "cloudrun-error-count"

  description = "Counts Cloud Run ERROR log entries"

  filter = <<EOF
resource.type="cloud_run_revision"
severity>=ERROR
EOF

  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
    unit        = "1"

    display_name = "Cloud Run Error Count"
  }
}