Dokumentation der Funktion & Organisation des Programmes

Dieses Programm kann genutzt werden um die Funktionalität der Seite http://verbalzombie.hob/ zu testen.

Das Programm kann mit folgenden Parametern gestartet werden:
content : Startet nur die content Tests, welche den Seiteninhalt auf das vorhanden sein von festgelegten Begriffen testet.
            Diese Methoden befinden sich im Modul Content_test

various : Testet nur einzelen tests, die keiner Kategorie angefügt werden können
            Diese Methoden befinden sich im Modul Various_test

show : Fügt im Anschluss an die Tests eine leichtere lesbare Übersicht des erstellten log files im Terminal ein
            Die zugehörigen methoden befinden sich im Modul Minitests

Werden keine Parameter übergeben so werden alle Möglichkeiten abgearbeitet.
Wenn ein Test fehlschlägt wird automatisch ein Screenshot mit Nachricht und Zeitstempel als Namen im Ordner 'screenshots' gespeichert
Die aktuellen logs werden im Ordner logs unter 'Zeitstempel_log' gespeichert.
    Methoden die die Darstellung in den log Dateien, sowie beim zurücksetzen der Umgebung nach Durchführung eines Testteils betreffen befinden sich in der Datei Display_helper


