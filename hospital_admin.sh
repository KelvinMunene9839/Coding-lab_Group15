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
