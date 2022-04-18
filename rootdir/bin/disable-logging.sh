#!/system/bin/sh
# Support 
write() {
  # Check the file if existing to avoid error writes
  if [ -f "$1" ]; then
    # Make the file writable if it wasn't
    chmod +w "$1" 2>/dev/null
    # Set the parameter
    echo "$2" > "$1"
  fi
}

# Disable android logging
stop log
stop logd
stop statsd
stop stats
stop perf
stop tracing
stop trace
stop perfd
stop statscompanion
rm -rf /data/log
rm -f /data/*.log

# Disable CRC and anything like creating log 
write "/sys/module/mmc_core/parameters/use_spi_crc" "0"
write "/sys/kernel/sched/gentle_fair_sleepers" "0"

# Disable another logging like gpu,etc
write "/sys/module/rmnet_data/parameters/rmnet_data_log_level" "0"
write "/sys/kernel/debug/rpm_log" "0"
write "/d/tracing/tracing_on" "0"

# Disable Printk Logging mode
write "/sys/kernel/printk_mode/printk_mode" "0" 