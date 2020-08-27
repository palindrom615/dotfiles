pacmd list-sinks | awk '/muted/ { print $2 }'
