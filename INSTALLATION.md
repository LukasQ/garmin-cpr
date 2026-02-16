# CPR Trainer - Installation & Entwicklung

## Voraussetzungen

### 1. Connect IQ SDK installieren

1. Lade das Connect IQ SDK herunter: https://developer.garmin.com/connect-iq/sdk/
2. Installiere das SDK auf deinem Computer
3. Füge die SDK-Tools zu deinem PATH hinzu

**Windows:**
```bash
# SDK ist typischerweise hier installiert:
C:\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-7.x.x\bin
```

### 2. Visual Studio Code mit Connect IQ Extension (Empfohlen)

1. Installiere Visual Studio Code: https://code.visualstudio.com/
2. Installiere die "Monkey C" Extension von Garmin
3. Öffne dieses Projekt in VS Code

**ODER**

### 2. Eclipse IDE mit Connect IQ Plugin

1. Installiere Eclipse IDE
2. Installiere das Connect IQ Plugin: https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/

## Projekt kompilieren

### Mit VS Code (Empfohlen)

1. Öffne das Projekt in VS Code
2. Drücke `Ctrl+Shift+P` und wähle "Monkey C: Build for Device"
3. Wähle dein Garmin-Gerät aus der Liste
4. Die .prg Datei wird im `bin/` Ordner erstellt

### Mit Command Line

```bash
# Navigiere zum Projektverzeichnis
cd D:/git/garmin-cpr

# Kompiliere für ein spezifisches Gerät (z.B. fenix7)
monkeyc -o bin/CPRTrainer.prg -f monkey.jungle -y developer_key.der -d fenix7

# Kompiliere für alle unterstützten Geräte
monkeyc -o bin/CPRTrainer.prg -f monkey.jungle -y developer_key.der
```

## Developer Key generieren

Beim ersten Kompilieren brauchst du einen Developer Key:

```bash
# Generiere einen neuen Developer Key
openssl genrsa -out developer_key.pem 4096
openssl pkcs8 -topk8 -inform PEM -outform DER -in developer_key.pem -out developer_key.der -nocrypt
```

Der `developer_key.der` wird für alle deine Connect IQ Apps verwendet.

## App auf deine Uhr übertragen

### Methode 1: Über USB (Schnell & Einfach)

1. Verbinde deine Garmin Uhr per USB mit dem Computer
2. Die Uhr erscheint als Laufwerk (z.B. "GARMIN")
3. Kopiere die `.prg` Datei nach:
   ```
   GARMIN/GARMIN/APPS/
   ```
4. Trenne die Uhr sicher vom Computer
5. Auf der Uhr: Menü → Aktivitäten → CPR Trainer

### Methode 2: Connect IQ Simulator (Zum Testen)

```bash
# Starte den Simulator
connectiq

# Oder in VS Code: Ctrl+Shift+P → "Monkey C: Run"
```

### Methode 3: Garmin Express (für Endnutzer)

Nach der Veröffentlichung im Connect IQ Store können Nutzer die App über Garmin Express oder die Garmin Connect Mobile App installieren.

## App im Simulator testen

### Mit VS Code:
1. Drücke `F5` oder wähle "Run → Start Debugging"
2. Wähle dein Zielgerät
3. Der Simulator öffnet sich automatisch

### Mit Command Line:
```bash
# Starte den Simulator mit der App
connectiq
# Dann im Simulator: File → Load App → Wähle die .prg Datei
```

## Entwicklungstipps

### Logging aktivieren
Im Code kannst du `System.println()` verwenden:
```monkey-c
System.println("Debug: Compression count = " + _compressionCount);
```

Die Logs erscheinen in der VS Code Debug Console oder im Connect IQ Simulator Output.

### Live-Reload
Mit VS Code und dem Connect IQ Simulator kannst du Änderungen live testen ohne die Uhr zu verbinden.

## Troubleshooting

### "monkeyc command not found"
- Stelle sicher, dass das Connect IQ SDK installiert ist
- Füge den SDK bin-Pfad zu deinem PATH hinzu

### "Invalid developer key"
- Generiere einen neuen Developer Key mit den obigen OpenSSL-Befehlen
- Stelle sicher, dass `developer_key.der` im Projektverzeichnis liegt

### App startet nicht auf der Uhr
- Überprüfe, dass deine Uhr in der `manifest.xml` unter `<iq:products>` gelistet ist
- Stelle sicher, dass die Uhr-Firmware aktuell ist

### Kompilierfehler
- Überprüfe die Syntax in den `.mc` Dateien
- Stelle sicher, dass alle Ressourcen in den `resources/` Ordnern vorhanden sind

## Nächste Schritte

Nach erfolgreicher Installation auf deiner Uhr:
1. Teste die App gründlich
2. Sammle Feedback
3. Siehe [PUBLISHING.md](PUBLISHING.md) für die Veröffentlichung im Connect IQ Store
