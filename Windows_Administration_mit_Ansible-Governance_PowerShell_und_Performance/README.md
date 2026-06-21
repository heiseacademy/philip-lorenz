# 📘 Windows-Administration mit Ansible: Governance, PowerShell und Performance

## 🔍 Kurzbeschreibung

In diesem Kurs lernst du, Windows-Automatisierung mit Ansible sicherer, nachvollziehbarer und performanter zu betreiben. Du vertiefst die Integration von PowerShell, unterscheidest sauber zwischen `win_shell` und `win_command`, installierst PowerShell-Module remote und gestaltest eigene Skripte idempotent. Außerdem beschäftigst du dich mit Least Privilege, Vault-Best-Practices, Audit-Logging, Debugging, Fact-Caching sowie der Einbindung von Ansible in CI/CD-Pipelines, Molecule-Tests und AWX.

## 📚 Kursbeschreibung

Dieser Kurs richtet sich an alle, die Windows-Systeme mit Ansible professionell automatisieren und betreiben möchten. Im Mittelpunkt stehen sichere PowerShell-Ausführung, nachvollziehbare Änderungen, kontrollierte Berechtigungen, performante Automatisierungsläufe und die Integration in moderne DevOps-Prozesse.

Zu Beginn vertiefst du die **PowerShell-Integration**. Du lernst, wann welches Ausführungsmodul die richtige Wahl ist, unterscheidest ausführbare Programme von PowerShell-Funktionen und entwickelst eine klare Entscheidungsregel für deine Playbooks. Anschließend installierst und verwendest du PowerShell-Module auf entfernten Windows-Systemen. Dabei wird deutlich, warum Installation und Nutzung getrennte Schritte sind und weshalb native Ansible-Funktionen gegenüber rohen PowerShell-Befehlen Vorteile bieten.

Ein besonderer Schwerpunkt liegt auf zuverlässiger Wiederholbarkeit. Du lernst, wie eigene PowerShell-Skripte den aktuellen Zustand prüfen, nur bei Bedarf Änderungen vornehmen und ihre Ergebnisse so zurückgeben, dass Ansible sie korrekt bewerten kann.

Im zweiten Kapitel stehen **Security und Governance** im Fokus. Du setzt Least Privilege technisch um, erzwingst definierte Berechtigungszustände und entfernst unautorisierte Administratorrechte. Gleichzeitig ordnest du ein, welche Rolle Gruppenrichtlinien in Active-Directory-Umgebungen spielen und welche lokalen Mechanismen auch auf Standalone-Systemen funktionieren.

Danach beschäftigst du dich mit **Secrets und Nachvollziehbarkeit**. Du schützt sensible Daten, verhinderst versehentliche Ausgaben vertraulicher Informationen und grenzt einfache Verschlüsselung sauber von echter Secrets-Rotation ab. Zusätzlich lernst du, wie Ansible lokale Laufprotokolle erzeugt und Änderungen direkt im Windows-Ereignisprotokoll des Zielsystems dokumentiert. So beantwortest du zentrale Fragen aus Betrieb, Audit und Incident Response: Wer hat wann was geändert – und wo lässt sich das nachvollziehen?

Im dritten Kapitel geht es um **Troubleshooting und Performance**. Du analysierst Verbindungsaufbau, Modulausführung und Rückgaben während der Automatisierung und prüfst, welche Konfiguration tatsächlich wirksam ist. Anschließend nutzt du zwischengespeicherte Systeminformationen, um wiederholte Läufe zu beschleunigen, und bewertest die Risiken veralteter Informationen.

Im letzten Kapitel integrierst du deine Windows-Automatisierung in moderne **DevOps-Prozesse**. Du richtest einen automatisierten Qualitätscheck in Azure DevOps ein, prüfst Playbooks frühzeitig auf Stil und typische Fehler und lernst ein Testwerkzeug für Ansible-Rollen kennen. Zum Abschluss ordnest du eine zentrale Automation Engine ein, die Inventories, Zugangsdaten, Projekte, Ausführungsvorlagen, Berechtigungen und Ausführungslogs bündelt.

Der Kurs ist praxisnah aufgebaut und führt dich von konkreten Windows-Automatisierungsproblemen bis hin zu Governance, Performance-Optimierung und CI/CD-Integration. Alle Konzepte sind so angelegt, dass du sie direkt in professionellen Windows-Umgebungen einsetzen und weiterentwickeln kannst.

## 🎯 Lernziele

Am Ende dieses Kurses wirst du in der Lage sein:

1. **Den Unterschied zwischen `win_shell` und `win_command` zu verstehen und je nach Befehlstyp das passende Modul auszuwählen.**
2. **PowerShell-Module auf Windows-Zielsystemen mit nativen Ansible-Modulen zu installieren und zu verwenden.**
3. **Eigene PowerShell-Skripte idempotent zu gestalten.**
4. **Least-Privilege-Prinzipien umzusetzen und definierte Berechtigungszustände auf Windows-Systemen zu erzwingen.**
5. **Nachvollziehbare Logs auf dem Control Node und im Windows Event Log des Zielsystems zu erzeugen.**
6. **Debugging strukturiert einzusetzen, um Fehler gezielt einzugrenzen.**
7. **Wiederholte Playbook-Läufe mit Fact-Caching zu beschleunigen und die Risiken veralteter Facts zu bewerten.**
8. **Ansible in Azure DevOps zu integrieren, Playbooks mit `ansible-lint` zu prüfen und Windows-Rollen mit Molecule zu testen.**
9. **Zu verstehen, wie AWX als zentrale Automation Engine Inventories, Credentials, Job Templates und Ausführungslogs bündelt.**

## 🗂️ Struktur

- [infra](./infra/) – Terraform-Setup für die Lab-Umgebung (Windows-Target + AWX-Node in Azure)
- [01-powershell-integration](./01-powershell-integration/) – `win_shell` vs. `win_command`, PowerShell-Module remote laden, idempotente Skripte
- [02-security-governance](./02-security-governance/) – Least Privilege & GPO-Härtung, Vault-Best-Practices & Secrets-Rotation, Audit-Logging
- [03-troubleshooting-performance](./03-troubleshooting-performance/) – Live-Debugging mit `-vvv` und `ansible.cfg`, Fact-Caching
- [04-integration-devops](./04-integration-devops/) – Azure DevOps Lint-Job, Molecule-Testlauf für Windows-Rollen, AWX als Automation Engine

> ⚠️ In allen `inventory.ini`/`molecule.yml`-Dateien sind `ansible_host` und `ansible_password` durch Platzhalter (`203.0.113.10` / `P@ssw0rd1234!`) ersetzt. Vor dem Ausführen gegen die eigene Lab-VM anpassen.
