#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

job=$(zenity --list \
    --title="Select Job" \
    --column="Script" \
    "create_backup.sh" \
    "update_packages.sh" \
    "update_network.sh")

[[ -z "$job" ]] && exit 1

date=$(zenity --calendar --date-format="%m %d %Y")
[[ -z "$date" ]] && exit 1

time=$(zenity --entry --text="Enter time (HH:MM)")
[[ -z "$time" ]] && exit 1

ampm=$(zenity --list --column="Choice" "AM" "PM")
[[ -z "$ampm" ]] && exit 1

IFS=: read hh mm <<< "$time"
if [[ "$ampm" == "PM" && "$hh" != "12" ]]; then
    hh=$((10#$hh + 12))
elif [[ "$ampm" == "AM" && "$hh" == "12" ]]; then
    hh=0
fi

read month day year <<< "$date"

schedule=$(zenity --list --column="Schedule" \
    "Daily" \
    "Weekly" \
    "Monthly" \
    "Yearly")

case "$schedule" in
    Daily) cron="$mm $hh * * *" ;;
    Weekly) cron="$mm $hh * * 1" ;;
    Monthly) cron="$mm $hh $day * *" ;;
    Yearly) cron="$mm $hh $day $month *" ;;
    *) exit 1 ;;
esac

( crontab -l 2>/dev/null; \
  echo "$cron DISPLAY=:0 XAUTHORITY=/home/$USER/.Xauthority /bin/bash $SCRIPT_DIR/$job" ) | crontab -

zenity --info --text="Cron job scheduled!"

