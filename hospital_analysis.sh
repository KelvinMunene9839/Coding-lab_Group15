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
    
    echo "Report generated on: $(date)" >> reports/critical_alerts.txt
    echo "--------------------------------------" >> reports/critical_alerts.txt
    
    # Search Heart Rate log for CRITICAL rows and extract correct columns
    grep "CRITICAL" active_logs/heart_rate_log.log | \
    awk '{print $1, $2, "|", $4, "|", $6}' >> reports/critical_alerts.txt


    # Search Temperature log for CRITICAL rows and extract correct columns
    grep "CRITICAL" active_logs/temperature_log.log | \
    awk '{print $1, $2, "|", $4, "|", $6}' >> reports/critical_alerts.txt
    
    # Count how many critical alerts were found
    COUNT=$(wc -l < reports/critical_alerts.txt)
    echo "Total critical alerts found: $COUNT"   

    echo "Done! Critical alerts saved to reports/critical_alerts.txt"

}

# Call the function
process_vitals


water_audit() {

    echo "Running water usage audit for ICU_WATER_RESERVE..."

    # Check the log file exists
    if [ ! -f active_logs/water_usage_log.log ]; then
        echo "ERROR: water_usage_log.log not found in active_logs/"
        return 1
    fi

    # Filter ICU_WATER_RESERVE rows and calculate average
    grep "ICU_WATER_RESERVE" active_logs/water_usage_log.log | \
    awk '{
        sum += $6
        count++
    }
    END {
        if (count == 0) {
            printf "No ICU_WATER_RESERVE records found.\n"
        } else {
            avg = sum / count
            printf "Average water usage: %.2f L\n", avg
        }
    }'

}

water_audit
