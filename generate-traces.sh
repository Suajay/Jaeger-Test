#!/bin/bash
# Generates several /dispatch requests to HotROD to produce comparable traces in Jaeger.
# Run this after `docker compose up` and waiting ~10 seconds.

echo "Waiting for stack to be ready..."
sleep 5

CUSTOMERS=(392 123 731 567 254 928)

for C in "${CUSTOMERS[@]}"; do
  N=$RANDOM
  echo "Dispatching customer=$C nononse=$N ..."
  curl -s "http://localhost:8090/dispatch?customer=$C&nononse=$N" > /dev/null
  sleep 1
done

echo ""
echo "Done. Open http://localhost:16686 in Safari."
echo "Search: Service=frontend, Operation=GET /dispatch"
echo "Pick two traces with the biggest duration difference for your comparison."
