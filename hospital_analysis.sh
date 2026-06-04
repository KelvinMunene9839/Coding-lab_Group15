#!/bin/bash

process_vitals() {

    echo "Scanning for CRITICAL vitals..."

    # Create reports folder if it doesn't exist
    mkdir -p reports

    # Clear previous report for a fresh start
    > reports/critical_alerts.txt

    # Add a header line to the report
    echo "Timestamp | Device_ID | Value" >> reports/critical_alerts.txt
    echo "--------------------------------------" >> reports/critical_alerts.txt

    # Search Heart Rate log for CRITICAL rows and extract correct columns
    grep "CRITICAL" active_logs/heart_rate_log.log | \
    awk '{print $1, $2, "|", $4, "|", $6}' >> reports/critical_alerts.txt

    # Search Temperature log for CRITICAL rows and extract correct columns
    grep "CRITICAL" active_logs/temperature_log.log | \
    awk '{print $1, $2, "|", $4, "|", $6}' >> reports/critical_alerts.txt

    echo "Done! Critical alerts saved to reports/critical_alerts.txt"
}

# Call the function
process_vitals
