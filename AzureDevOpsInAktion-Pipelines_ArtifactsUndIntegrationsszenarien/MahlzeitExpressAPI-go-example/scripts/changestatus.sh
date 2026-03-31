#!/bin/bash
# Status einer Bestellung ändern (ID 1, z.B. auf 'In Lieferung')
curl -s -X PUT http://localhost:8080/order/1 \
    -H "Content-Type: application/json" \
    -d '{"status":"In Lieferung"}' | jq
