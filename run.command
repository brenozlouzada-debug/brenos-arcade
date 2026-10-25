#!/bin/bash
# Serves the arcade locally and opens it in your default browser.
cd "$(dirname "$0")" || exit 1

PORT=8900
while lsof -i ":$PORT" >/dev/null 2>&1; do
  PORT=$((PORT + 1))
done

python3 -m http.server "$PORT" --bind 127.0.0.1 >/dev/null 2>&1 &
SERVER_PID=$!
trap 'kill $SERVER_PID 2>/dev/null' EXIT INT TERM

sleep 1
URL="http://localhost:$PORT/index.html"
echo "Breno's Arcade is running at $URL"
echo "Close this window or press Ctrl-C to stop the server."
open "$URL" 2>/dev/null || xdg-open "$URL" 2>/dev/null || true

wait $SERVER_PID
