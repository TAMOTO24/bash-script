# System Monitoring Script

This bash script monitors system resources (CPU, Memory, Disk usage) and logs any warnings if the resource usage exceeds defined thresholds. Additionally, it provides a system information report and checks for available package updates.

## Features

- **CPU Usage Monitoring**: Alerts if CPU usage exceeds a specified threshold.
- **Memory Usage Monitoring**: Alerts if memory usage exceeds a specified threshold.
- **Disk Usage Monitoring**: Alerts if disk usage exceeds a specified threshold.
- **System Information**: Displays the current system status (CPU, Memory, and Disk usage).
- **Package Updates**: Checks and logs available package updates.
- **Background Monitoring**: Runs the monitoring process in the background, logging data every minute.
- **Graceful Shutdown**: Stops monitoring and exits cleanly when `Ctrl+C` is pressed.

## Prerequisites

- `bash`
- `top`, `free`, `df`, `awk`, `sed`
- Linux-based system (Ubuntu/Debian recommended for `apt` package manager)

## How to Use

### Running the Script

1. Clone or download the script.
2. Give the script execute permissions:
    ```bash
    chmod +x system_monitor.sh
    ```
3. Run the script:
    ```bash
    ./system_monitor.sh
    ```

### Menu Options

When you run the script, you will be prompted with a menu of options:

1. **Background Monitoring**: Start monitoring system resources in the background, with logs updating every minute.
2. **Show Current System Status**: Display the current CPU, memory, and disk usage.
3. **Show Available Updates**: Check for and display the number of available updates for installed packages.
4. **Stop Script**: Exit the script.

### Example of Monitoring

```bash
Starting background monitoring... Logs will update every minute.
