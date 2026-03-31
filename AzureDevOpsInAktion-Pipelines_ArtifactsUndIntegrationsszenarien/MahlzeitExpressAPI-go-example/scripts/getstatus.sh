#!/bin/bash
# Bestellung abfragen (z.B. ID 1)
curl -s http://localhost:8080/order/1 | jq
