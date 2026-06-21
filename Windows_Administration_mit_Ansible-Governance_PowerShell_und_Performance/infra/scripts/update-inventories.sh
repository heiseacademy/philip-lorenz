#!/usr/bin/env bash
# update-inventories.sh
# Nach terraform apply ausführen – setzt die aktuelle Windows-Target-IP in
# alle inventory.ini- und molecule.yml-Dateien im Kursordner.
#
# Funktioniert sowohl beim Erstlauf (Platzhalter-IP) als auch bei
# wiederholten Läufen (ersetzt eine bereits gesetzte alte IP).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INFRA_DIR="$(dirname "$SCRIPT_DIR")"
KURS_DIR="$(dirname "$INFRA_DIR")"

WIN_IP=$(cd "$INFRA_DIR" && terraform output -raw windows_target_ip)

if [[ -z "$WIN_IP" ]]; then
    echo "Fehler: Terraform Output nicht verfügbar. Zuerst terraform apply ausführen." >&2
    exit 1
fi

echo "Windows-IP: $WIN_IP"
echo ""

# inventory.ini: ansible_host=<irgendwas> -> ansible_host=<neue IP>
find "$KURS_DIR" -name "inventory.ini" | while read -r f; do
    sed -i.bak \
        -e "s/ansible_host=REPLACE_WITH_AZURE_HOST/ansible_host=$WIN_IP/g" \
        -e "s/ansible_host=[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*/ansible_host=$WIN_IP/g" \
        -e "s/REPLACE_WITH_USER/ansible/g" \
        "$f"
    rm -f "${f}.bak"
    echo "Aktualisiert: $f"
done

# molecule.yml: ansible_host: <irgendwas> -> ansible_host: <neue IP>
find "$KURS_DIR" -name "molecule.yml" | while read -r f; do
    sed -i.bak \
        -e "s/ansible_host: REPLACE_WITH_AZURE_HOST/ansible_host: $WIN_IP/g" \
        -e "s/ansible_host: [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*/ansible_host: $WIN_IP/g" \
        -e "s/REPLACE_WITH_USER/ansible/g" \
        "$f"
    rm -f "${f}.bak"
    echo "Aktualisiert: $f"
done

echo ""
echo "Fertig. Passwort manuell pruefen/eintragen (Wert aus terraform.tfvars):"
echo "  ansible_password=..."
