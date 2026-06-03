#!/bin/bash

# ===================
# System Initialization
# ===================

initialize_system() {
    if [ ! -d "active_logs" ]; then
        mkdir "active_logs"
        echo "Creating active_logs directory ..."
    fi

    if [ ! -d "archived_logs" ]; then
        mkdir "archived_logs"
        echo "Creating archived_logs ..."
    fi

    if [ ! -d "reports" ]; then
        mkdir "reports"
        echo "Creating reports ..."
    fi
}

initialize_system

# ==================
# Securing Data
# ==================

secure_data() {
    if [ ! -d "active_logs" ]; then
        echo "ERROR: active_logs not found. Run initialize_system first."
        return 1
    fi

    chmod 700 active_logs
    ls -l | grep active_logs
    echo "Security hardening complete."
}

secure_data
echo "System Environment Secured - $(date)"
