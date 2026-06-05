#!/usr/bin/env bash
#
#KNH Log Rotation & Archiving
#

ACTIVE_DIR="active_logs"
ARCHIVE_DIR="archived_logs"
TIMESTAMP=$(date +%Y%m%d_%H%M)

# Fresh-moves each active log into archived_logs with a timestamp.

archive_logs() {
    mkdir -p "$ARCHIVE_DIR"
    echo "Rotating logs at $TIMESTAMP..."

    for log in "$ACTIVE_DIR"/*.log; do
        [ -e "$log" ] || continue
        base=$(basename "$log" .log)
        name=${base%_log}
        dest="$ARCHIVE_DIR/${name}_${TIMESTAMP}.log"

        mv "$log" "$dest"
        echo "Archived $log -> $dest"
    done
}

# Recreate empty logs so the engine keeps recording, then run.

recreate_logs() {
    for name in heart_rate_log temperature_log water_usage_log; do
        touch "$ACTIVE_DIR/${name}.log"
    done
    echo "Archiving complete on $(date)"
}

archive_logs
recreate_logs
