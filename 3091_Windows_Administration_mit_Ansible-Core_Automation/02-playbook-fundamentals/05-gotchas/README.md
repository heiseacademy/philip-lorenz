## 1. Idempotenz (Shell vs. Module)
**Datei:** `1.yaml`

Führe das Playbook **zweimal hintereinander** aus.

```bash
ansible-playbook -i inventory.yaml 1.yaml
```

**Beobachtung:**
1. Der **SCHLECHTE** Task (`win_shell`) ist **immer gelb** ("changed"), auch beim zweiten Mal.
   * *Folge:* Handler (Neustarts) werden unnötig ausgelöst.
2. Der **GUTE** Task (`win_timezone`) ist beim zweiten Mal **grün** ("ok").
   * *Folge:* Das System wird nicht unnötig angefasst.

---

## 2. Wartbarkeit (Variablen)
**Datei:** `2.yaml`

```bash
ansible-playbook -i inventory.yaml 2.yaml
```
---

## 3. Zielauswahl (Inventory Limits)
**Datei:** `3.yaml`

**Szenario:** Du hast mehrere Server im Inventory (z.B. `dc01` und `member-0`), willst aber nur einen davon (den Member-Server) patchen.

**1. Der "Unfall" (Ohne Limit)**
Zeige, was passiert, wenn man `-l` vergisst.

```bash
ansible-playbook -i inventory.yaml 3.yaml
```


**2. Die Lösung (Mit Limit)**
Begrenze die Ausführung auf das gewünschte Ziel.

```bash
ansible-playbook -i inventory.yaml 3.yaml -l member-0
```

* *Beobachtung:* Ansible läuft **nur** auf `member-0`.
* *Erklärung:* Mit `-l` (Limit) begrenzen wir den Einflussbereich (Blast Radius).

---

## 4. Tags und Abhängigkeiten
**Datei:** `4.yaml`

**Szenario:** Wir wollen Zeit sparen und nur die Konfiguration (`config`) ausführen.

```bash
ansible-playbook -i inventory.yaml 4.yaml --tags config
```

**Beobachtung:**
* Achte auf den Abschnitt **SCHLECHT**:
    * Der Ordner `C:\TagDemo` wird erstellt (hat den Tag).
    * Der Unterordner `C:\TagDemo\Logs` wird **NICHT** erstellt (Tag fehlt).
    * -> **Die Applikation würde abstürzen**, weil der Log-Ordner fehlt.
* Achte auf den Abschnitt **GUT**:
    * Beide Ordner werden korrekt erstellt, da beide sauber getaggt sind.

---

## 5. Dry-Run (Check Mode)
**Datei:** `5.yaml`

**Szenario:** Wir wollen sichergehen, dass wir nichts kaputt machen, bevor wir das Skript "scharf" schalten.

**Ausführung mit Check-Mode:**

```bash
ansible-playbook -i inventory.yaml 5.yaml --check --diff
```

**Beobachtung:**
* Ansible führt keine Änderungen durch (keine Ordner werden erstellt).
* Es meldet bei `changed`: "The task would have changed..." (Simulation).
* Perfekt zum Testen von Logikfehlern vor dem Deployment.