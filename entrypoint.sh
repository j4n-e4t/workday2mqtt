#!/bin/sh

echo "Starting workday2mqtt"
python /workday2mqtt/main.py

echo "Starting cron"
cron -f
