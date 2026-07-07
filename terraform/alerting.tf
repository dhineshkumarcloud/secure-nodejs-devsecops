resource "google_monitoring_alert_policy" "cloudrun_error_alert" {

  display_name = "Cloud Run Error Alert"

  combiner = "OR"

  conditions {

    display_name = "Cloud Run Error Count"

    condition_threshold {

      filter = <<EOF
metric.type="logging.googleapis.com/user/cloudrun-error-count"
resource.type="cloud_run_revision"
EOF

      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  notification_channels = [
    var.notification_channel_id
  ]

  alert_strategy {
    auto_close = "1800s"
  }
}