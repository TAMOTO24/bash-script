#!/bin/bash

# main-log file
LOG_FILE="system_monitor.log"

# global resourse threshold values
CPU_THRESHOLD=80
MEMORY_THRESHOLD=50
DISK_THRESHOLD=80

# get current time
get_timestamp() {
    echo "$(date '+%Y-%m-%d %H:%M:%S')"
}

# output CPU usage
check_cpu() {
    local cpu_usage
	#this main line takes CPU loading information and make summ from Custom\System CPU loading
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    cpu_usage=${cpu_usage%.*} # Convert to int
    if (( cpu_usage > CPU_THRESHOLD )); then
        echo "$(get_timestamp) [WARNING] CPU usage: ${cpu_usage}% (Threshold: ${CPU_THRESHOLD}%)" >> "$LOG_FILE"
    fi
}

# output Memory usage
check_memory() {
    local mem_usage
	# get and then calculate percent of used memory using TOTAL/USED * 100 formula
    mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    mem_usage=${mem_usage%.*} #convert to int
    if (( mem_usage > MEMORY_THRESHOLD )); then
        echo "$(get_timestamp) [WARNING] Memory usage: ${mem_usage}% (Threshold: ${MEMORY_THRESHOLD}%)" >> "$LOG_FILE"
    fi
}

# output Disk usage
check_disk() {
    local disk_usage
	# using command df / take disk inf then using grep / filter to make group of values
	#Awk used for taking actual percent of usage 00% and sed is used to delete % from number
    disk_usage=$(df / | grep / | awk '{print $5}' | sed 's/%//')
    if (( disk_usage > DISK_THRESHOLD )); then
        echo "$(get_timestamp) [WARNING] Disk usage: ${disk_usage}% (Threshold: ${DISK_THRESHOLD}%)" >> "$LOG_FILE"
    fi
}

# output whole Information system
sys_information() {
    local disk_usage
    local cpu_usage
    local mem_usage
    disk_usage=$(df / | grep / | awk '{print $5}' | sed 's/%//')
    mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

    echo "System Information:"
    echo "-------------------"
    echo "CPU Usage: ${cpu_usage}%"
    echo "Memory Usage: ${mem_usage}%"
    echo "Disk Usage: ${disk_usage}%"
}

#check update fucntion to show avaliable package updates
check_updates() {
    local updates
    updates=$(apt list --upgradable 2>/dev/null | wc -l) # count of avaliable package updates
    echo "$(get_timestamp) [INFO] Updates available: $((updates - 1))" >> "$LOG_FILE" #output result
}

# Script end
cleanup() {
    echo "Stopping monitoring..."
    exit 0
}

# call cleanup function if Ctrl+C is pressed
trap cleanup SIGINT

# Menu
echo -e "Activated System Monitoring: \n
	1. Background monitoring of system components.\n
	2. Show current system status.\n
	3. Show count of available updates.\n
	4. Stop script."
read -r answ

case $answ in
  1)
    echo "Starting background monitoring... Logs will update every minute."
    while true; do
        check_cpu
        check_memory
        check_disk
        sleep 60 # sleep for minute to update log file every minute
    done
    ;;
  2)
    sys_information
    ;;
  3)
    check_updates
    ;;
  4)
    echo "Exiting."
    exit 0
    ;;
  *)
    echo "Error: Unknown option. Please try again."
    ;;
esac