# Demo: Variablen-Präzedenz (Variable Precedence)

Dieses Szenario demonstriert, in welcher Reihenfolge Ansible Variablen auswertet, wenn dieselbe Variable an mehreren Orten definiert ist (Group Vars, Host Vars, Playbook Vars).

## Ausgangssituation (Dateien)

Wir haben die Variable `helpdeskpro_log_level` an **drei** verschiedenen Orten definiert:

1.  **Group Vars** (`group_vars/win_dev.yml`): `debug` (Niedrigste Priorität im Inventory)
2.  **Host Vars** (`host_vars/dc01.yml`): `warning` (Höhere Priorität als Group)
3.  **Playbook Vars** (`variables_precedence.yml`): `info` (Schlägt Inventory)

---

## Schritt 1: Playbook Vars (Gewinner: Playbook)

Führe das Playbook unverändert aus.

```bash
ansible-playbook -i inventory.yaml variables_precedence.yml
```

**Beobachtung:**
* Ausgabe: `helpdeskpro_log_level = info`
* **Warum?** Variablen, die direkt im `vars:`-Block des Playbooks definiert sind, überschreiben Definitionen aus dem Inventory (`group_vars` und `host_vars`).

---

## Schritt 2: Host Vars (Gewinner: Host)

Jetzt simulieren wir, dass die Variable nicht im Playbook steht.

1.  Öffne `variables_precedence.yml`.
2.  **Kommentiere den `vars`-Block aus** (oder lösche die Zeilen):

```yaml
#  vars:
#    helpdeskpro_log_level: "info"
#    helpdeskpro_timezone: "Central Europe Standard Time"
```

3.  Führe das Playbook erneut aus:

```bash
ansible-playbook -i inventory.yaml variables_precedence.yml
```

**Beobachtung:**
* Ausgabe: `helpdeskpro_log_level = warning`
* **Warum?** Da das Playbook keine Meinung mehr dazu hat, schaut Ansible ins Inventory. Hier schlägt die **spezifische** Definition für den Host (`host_vars/dc01.yml`) die allgemeinere Gruppen-Definition.

---

## Schritt 3: Group Vars (Gewinner: Group)

Jetzt entfernen wir die host-spezifische Konfiguration.

1.  Benenne die Host-Vars-Datei um (damit Ansible sie ignoriert) oder lösche den Inhalt:

```bash
mv host_vars/dc01.yml host_vars/dc01.yml.bak
```

2.  Führe das Playbook erneut aus:

```bash
ansible-playbook -i inventory.yaml variables_precedence.yml
```

**Beobachtung:**
* Ausgabe: `helpdeskpro_log_level = debug`
* **Warum?** Jetzt greift der Fallback. Ansible findet nichts Spezifisches für den Host und nimmt den Wert aus der Gruppe `win_dev` in `group_vars`.

---

## Schritt 4: Extra Vars (Der "Joker")

Wir können **alles** übersteuern, ohne eine Datei zu ändern, indem wir Variablen direkt beim Befehl mitgeben (`-e` für Extra Vars).

1.  Stelle (optional) den Originalzustand wieder her, falls gewünscht.
2.  Führe das Playbook mit `-e` aus:

```bash
ansible-playbook -i inventory.yaml variables_precedence.yml -e "helpdeskpro_log_level=critical"
```

**Beobachtung:**
* Ausgabe: `helpdeskpro_log_level = critical`
* **Warum?** **Extra Vars** haben die allerhöchste Priorität. Sie überschreiben Group Vars, Host Vars und sogar Playbook Vars. Das ist nützlich für einmalige Overrides in Pipelines.