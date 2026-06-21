# 🏗️ Lab-Infrastruktur (Terraform)

Setzt die Azure-Umgebung für diesen Kurs auf: einen **Windows-Server-2022-Host** (WinRM-Target für alle Ansible-Demos) und einen **Ubuntu-Node mit k3s + AWX** (für das Kapitel `04-integration-devops/03-awx-als-automation-engine`).

## Voraussetzungen

- Terraform >= 1.6
- Azure CLI (`az login` ausgeführt, gültiges Abo)
- SSH-Keypair für den AWX-Node (`ssh-keygen -t ed25519`)

## Setup

```bash
cd infra
cp terraform.tfvars.example terraform.tfvars
# subscription_id, admin_password und ssh_public_key in terraform.tfvars eintragen

terraform init
terraform plan
terraform apply
```

Nach `terraform apply` die ausgegebene Windows-IP in die `inventory.ini`-Dateien der einzelnen Kursmodule eintragen – entweder manuell oder automatisiert:

```bash
./scripts/update-inventories.sh
```

Auf dem Windows-Target anschließend per RDP einloggen (Ausgabe `rdp_windows`) und WinRM einrichten:

```powershell
PowerShell -ExecutionPolicy Bypass -File scripts\winrm-setup.ps1
```

Den AWX-Node erreichst du nach ca. 15 Minuten Setup-Zeit unter der Ausgabe `awx_url` (Standard-User `admin`, Passwort über `awx_password_cmd` abrufen).

## Aufräumen

```bash
terraform destroy
```

Oder nur über Nacht/Wochenende pausieren (die VMs schalten dank `auto_shutdown_time` ohnehin täglich automatisch ab):

```bash
az vm deallocate -g ansible-kurs-rg -n windows-target
az vm deallocate -g ansible-kurs-rg -n awx-node
```

## Dateien

- `main.tf`, `network.tf`, `firewall.tf`, `servers.tf`, `variables.tf`, `outputs.tf` – Terraform-Konfiguration
- `terraform.tfvars.example` – Vorlage für deine eigenen Werte (echte `terraform.tfvars` niemals committen, siehe `.gitignore`)
- `cloud-init/control-node.yml` – optionales Cloud-Init für einen eigenen Ansible-Control-Node (Ansible-venv, Collections, Fact-Caching)
- `cloud-init/awx-node.yml` – Cloud-Init für den AWX-Node (k3s + AWX Operator, vollautomatisch)
- `scripts/update-inventories.sh` – trägt die aktuelle Windows-IP in alle `inventory.ini`/`molecule.yml` im Kurs ein
- `scripts/winrm-setup.ps1` – aktiviert WinRM/NTLM und legt den `ansible`-Benutzer auf dem Windows-Target an

> ⚠️ Keine eigenen Subscription-IDs, Passwörter oder Keys in dieses Repo committen. Alle sensiblen Werte gehören ausschließlich in die lokale, gitignorte `terraform.tfvars`.
