# 📘 Ansible für Windows: Inventar, Playbooks, Rollen & Systemautomatisierung

## 🔍 Kurzbeschreibung

Automatisiere Windows-Systeme professionell mit Ansible – von durchdachten Inventar-Strategien über saubere Playbooks und Variablen-Management bis hin zu wiederverwendbaren Rollen und typischen Windows-Standardaufgaben aus dem Alltag.

## 📚 Kursbeschreibung

Ansible ist längst mehr als ein reines Linux-Werkzeug und eignet sich hervorragend für die **strukturierte und skalierbare Automatisierung von Windows-Systemen**. In diesem Kurs lernst du Schritt für Schritt, wie du Windows-Umgebungen sauber modellierst, Playbooks professionell aufbaust und wiederverwendbaren Automatisierungscode entwickelst.

Zu Beginn setzt du dich intensiv mit **Inventar-Strategien** auseinander. Du lernst den Aufbau statischer Inventories mit Host- und Group-Variablen kennen und verstehst, wann dieser Ansatz sinnvoll ist. Darauf aufbauend erhältst du ein fundiertes Verständnis für **dynamische Inventories** und siehst am Beispiel von Azure, wie Ansible Hosts und Metadaten zur Laufzeit aus externen Systemen bezieht.

Im nächsten Abschnitt stehen die **Playbook Fundamentals** im Fokus. Du lernst den sauberen Aufbau von Playbooks, den gezielten Einsatz von Tags sowie die Funktionsweise von Handlern. Ein besonderer Schwerpunkt liegt auf robuster Fehler- und Ausnahmebehandlung mit `block`, `rescue` und `always`, damit deine Automatisierungen auch in komplexen Szenarien stabil und nachvollziehbar bleiben.

Ein zentrales Thema professioneller Ansible-Projekte ist der **Umgang mit Variablen und Secrets**. Du verstehst die Variablen-Präzedenz, nutzt Fakten und `set_fact` effektiv und schützt sensible Daten mit Ansible Vault. Zusätzlich lernst du, Variablen zur Laufzeit abzufragen, um Playbooks flexibel und interaktiv zu gestalten.

Darauf aufbauend widmet sich der Kurs der **Wiederverwendbarkeit von Code**. Du arbeitest mit Rollen, erstellst eigene Rollen mit `ansible-galaxy init`, erweiterst diese strukturiert und bindest externe Rollen über Requirements ein. So entsteht modularer Code, der auch in größeren Umgebungen wartbar und skalierbar bleibt.

Ein weiterer Schwerpunkt ist das **Software-Management unter Windows**. Du automatisierst Silent-Installationen von EXE- und MSI-Paketen und lernst die gängigen Windows-Paketmanager **Chocolatey, Scoop und WinGet** kennen – inklusive ihrer Unterschiede und typischen Einsatzszenarien.

Zum Abschluss setzt du eine umfangreiche **praxisnahe Ansible-Rolle für Standard-System-Tasks** um. Anhand eines realistischen Helpdesk-Szenarios automatisierst du Windows-Updates, Active-Directory-Aufgaben, Dateisystem-Operationen, Registry-Einträge, Firewall-Regeln, Umgebungsvariablen, geplante Tasks und vieles mehr. Zusätzlich erweiterst du die Rolle gezielt mit DSC und führst alle Bausteine zu einer vollständigen, produktionsnahen Lösung zusammen.

Alle Inhalte sind praxisorientiert aufgebaut, klar strukturiert erklärt und direkt auf reale Windows-Umgebungen übertragbar.

## 🎯 Lernziele

Am Ende dieses Kurses wirst du in der Lage sein:

1. **Statische und dynamische Inventar-Strategien gezielt einzusetzen.**  
2. **Ansible-Playbooks sauber zu strukturieren und wartbar aufzubauen.**  
3. **Tags, Handler und strukturierte Fehlerbehandlung effektiv zu nutzen.**  
4. **Variablen, Fakten und Secrets sicher und nachvollziehbar zu verwalten.**  
5. **Wiederverwendbaren Code mit Rollen und Ansible Galaxy zu entwickeln.**  
6. **Software-Installationen unter Windows automatisiert umzusetzen.**  
7. **Typische Windows-Standardaufgaben vollständig mit Ansible zu automatisieren.**
