#!/bin/bash
# 
# This script sends an alert to pagerduty using the api key in PAGERDUTY_KEY and
# the message in ALERT_MESSAGE.
# 
set -eu

URL="https://events.pagerduty.com/v2/enqueue"
DATA=$(cat <<EOF
{
  "routing_key": "${PAGERDUTY_KEY}",
  "event_action": "trigger",
  "dedup_key": "${ALERT_MESSAGE}",
  "payload": {
    "summary": "${ALERT_MESSAGE}",
    "source": "${ALERT_SOURCE}",
    "severity": "${ALERT_SEVERITY}",
    "component": "${ALERT_COMPONENT}"
  }
}
EOF
)

curl -H "Content-Type: application/json" \
	-X POST \
    -d "${DATA}" \
    "${URL}"
