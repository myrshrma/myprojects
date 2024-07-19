#!/bin/bash

get_user_input() {
    read -p "Enter CPU usage threshold (e.g., 80): " CPU_THRESHOLD
    read -p "Enter memory usage threshold (e.g., 80): " MEM_THRESHOLD
    read -p "Enter disk usage threshold (e.g., 80): " DISK_THRESHOLD
    read -p "Enter log file location (e.g., /var/log/system_health.log): " LOG_FILE
}


check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
        echo "CPU usage is above threshold: $CPU_USAGE%" >> $LOG_FILE
    fi
}


check_memory() {
    MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
        echo "Memory usage is above threshold: $MEM_USAGE%" >> $LOG_FILE
    fi
}


check_disk() {
    DISK_USAGE=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
    if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
        echo "Disk usage is above threshold: $DISK_USAGE%" >> $LOG_FILE
    fi
}


check_processes() {
    RUNNING_PROCESSES=$(ps aux --no-heading | wc -l)
    echo "Number of running processes: $RUNNING_PROCESSES" >> $LOG_FILE
}


main() {
    get_user_input
    echo "System Health Check - $(date)" >> $LOG_FILE
    check_cpu
    check_memory
    check_disk
    check_processes
    echo "----------------------------------------" >> $LOG_FILE
}


main
