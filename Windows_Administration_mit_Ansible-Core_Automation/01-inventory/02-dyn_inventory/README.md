# System-Voraussetzungen & Azure CLI
```bash
# System aktualisieren und Basis-Pakete holen
sudo apt-get update
sudo apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg python3-venv python3-full python3-pip

# Microsoft Keyring erstellen
mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

# Azure CLI Repository hinzufügen
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ bookworm main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

# Azure CLI installieren
sudo apt-get update
sudo apt-get install -y azure-cli
```


# Ansible Umgebung einrichten
```bash
# Virtual Environment erstellen (saubere Trennung vom System)
python3 -m venv ~/ansible-env

# Umgebung aktivieren
# WICHTIG: Diesen Befehl musst du machen, wann immer du an Ansible arbeitest!
source ~/ansible-env/bin/activate

# Pip innerhalb der Umgebung aktualisieren
pip install --upgrade pip

# Ansible und notwendige Azure Python-Bibliotheken installieren
# Das behebt den "AzureCliCredential" Fehler und stellt sicher, dass 'auth_source: cli' funktioniert
pip install ansible requests azure-identity azure-mgmt-compute azure-mgmt-network azure-mgmt-resource azure-mgmt-storage

# Die Ansible Azure Collection installieren
ansible-galaxy collection install azure.azcollection

pip install "pywinrm[credssp]"
ansible-galaxy collection install ansible.windows
```

# Login & Test
```bash
# Umgebung muss aktiviert sein (siehe oben)
source ~/ansible-env/bin/activate

# Login via Browser/Device-Code (falls noch nicht geschehen)
az login

# Test: Inventory Graph anzeigen
# (Passe den Dateinamen an deine YAML-Datei an)
ansible-inventory -i 00-myazure_rm.yml --graph
```

# Graphs
```bash
# Standard
ansible-inventory -i 00-myazure_rm.yml --graph
# Gruppiert nach Label
ansible-inventory -i 01-myazure_rm.yml --graph
# Gruppiert nach Label und Condition
ansible-inventory -i 02-myazure_rm.yml --graph
```

# Playbook ausführen
```bash
ansible-playbook -i 01-myazure_rm.yml playbook.yml -l _AppServer
ansible-playbook -i 01-myazure_rm.yml playbook.yml -l _DomainController
```