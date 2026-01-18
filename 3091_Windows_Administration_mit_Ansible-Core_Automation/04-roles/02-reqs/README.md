# Global installieren
```bash
ansible-galaxy collection install -r requirements.yml
# Prüft, ob die beiden wichtigsten Windows-Collections für Ansible installiert sind und welche Versionen vorliegen
ansible-galaxy collection list | egrep "ansible.windows|community.windows"
```

# Collections direkt ins Projekt installieren
```bash
mkdir -p collections
ansible-galaxy collection install -r requirements.yml -p ./collections
```

### Config anpassen:
nano ansible.cfg

#### einfügen:
[defaults]
collections_paths = ./collections:~/.ansible/collections:/usr/share/ansible/collections
