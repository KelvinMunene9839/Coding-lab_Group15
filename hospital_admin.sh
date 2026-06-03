# Author: Member 2 - Security Lead
# KNH Security Script - Member 2
#!/bin/bash

initialize_system() {
    echo "Initializing KNH System Environment..."

    if [ ! -d "active_logs" ]; then
        echo "Creating active_logs directory..."
        mkdir -p active_logs
    fi

    if [ ! -d "archived_logs" ]; then
        echo "Creating archived_logs directory..."
        mkdir -p archived_logs
    fi

    if [ ! -d "reports" ]; then
        echo "Creating reports directory..."
        mkdir -p reports
    fi

    echo "System initialization complete."
}

secure_data() {
    if [ ! -d "active_logs" ]; then
        echo "ERROR: active_logs not found. Run initialize_system first."
        return 1
    fi

    chmod 700 active_logs
    ls -l | grep active_logs
    echo "Security hardening complete."
}

initialize_system
secure_data
echo "System Environment Secured - $(date)"
