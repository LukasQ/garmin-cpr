# CPR Trainer - Veröffentlichung im Connect IQ Store

Diese Anleitung zeigt dir, wie du die CPR Trainer App im Garmin Connect IQ Store veröffentlichst und damit für Millionen Garmin-Nutzer weltweit verfügbar machst.

## Vorbereitung

### 1. Garmin Developer Account erstellen

1. Gehe zu: https://developer.garmin.com/
2. Klicke auf "Sign In" und erstelle einen Account
3. Akzeptiere die Developer Agreement

**Wichtig:** Der Account ist kostenlos!

### 2. App gründlich testen

Bevor du veröffentlichst:
- [ ] Teste auf echten Geräten (nicht nur Simulator)
- [ ] Teste alle Funktionen (Start, Stop, Kompressions-Feedback)
- [ ] Überprüfe Vibrationen und Töne
- [ ] Teste auf verschiedenen Uhrenmodellen (wenn möglich)
- [ ] Batterieverbrauch prüfen (sollte nicht zu hoch sein)
- [ ] Teste Edge Cases (z.B. was passiert bei eingehendem Anruf)

### 3. App-Metadaten vorbereiten

Du brauchst:

#### Screenshots (Pflicht)
- **2-5 Screenshots** von der App auf verschiedenen Geräten
- Empfohlene Größen:
  - 240x240 (runde Displays)
  - 260x260
  - 390x390 (größere Displays)
- Zeige: Startbildschirm, aktive CPR-Session, verschiedene Phasen

#### App Icon (Pflicht)
- **80x80 Pixel** PNG
- Sollte auch bei 40x40 gut erkennbar sein
- Einfach & klar (z.B. Herz-Symbol mit Puls-Linie)

#### Marketing-Bilder (Optional aber empfohlen)
- **1280x720 Pixel** Banner
- Zeigt die App im Kontext

#### App-Beschreibung

**Deutsch:**
```
CPR Trainer - Dein persönlicher Wiederbelebungs-Assistent

Basierend auf den ERC Guidelines 2025 hilft dir diese App bei der korrekten Durchführung der Herzdruckmassage (CPR):

✓ 110 Kompressionen pro Minute (optimal für Erwachsene)
✓ 30:2 Rhythmus (30 Kompressionen, 2 Beatmungen)
✓ Visuelles Feedback im Uhrzeigersinn
✓ Akustische Signale (Vibrationen + Töne)
✓ Zyklus-Tracking

Ideal für:
• Erste-Hilfe-Kurse
• Auffrischung der CPR-Kenntnisse
• Training für Ersthelfer
• Führerschein-Erste-Hilfe-Schulung

WICHTIG: Diese App ersetzt keine professionelle Erste-Hilfe-Ausbildung und ist nur als Trainingstool gedacht. Im Notfall immer 112 rufen!
```

**Englisch:**
```
CPR Trainer - Your Personal Resuscitation Assistant

Based on ERC Guidelines 2025, this app helps you perform correct CPR (Cardiopulmonary Resuscitation):

✓ 110 compressions per minute (optimal for adults)
✓ 30:2 rhythm (30 compressions, 2 rescue breaths)
✓ Visual feedback in clockwise direction
✓ Acoustic signals (vibrations + tones)
✓ Cycle tracking

Perfect for:
• First aid courses
• CPR skills refresher
• First responder training
• Driver's license first aid training

IMPORTANT: This app does not replace professional first aid training and is intended as a training tool only. Always call emergency services in real emergencies!
```

## Veröffentlichungsprozess

### Schritt 1: App im Connect IQ Store Manager hochladen

1. Gehe zu: https://apps.garmin.com/developer/
2. Klicke auf "Apps" → "Upload an App"
3. Wähle "Watch App" als App-Typ

### Schritt 2: App-Informationen eingeben

#### Basic Information
- **App Name:** CPR Trainer
- **Version:** 1.0.0
- **Summary:** CPR-Trainingsapp basierend auf ERC Guidelines 2025
- **Category:** Health & Fitness
- **Subcategory:** Training
- **Languages:** German, English

#### Detailed Information
- Füge die oben vorbereitete Beschreibung ein (Deutsch & Englisch)
- **Keywords:** CPR, Herz-Lungen-Wiederbelebung, Erste Hilfe, Herzdruckmassage, Reanimation, ERC, Training, First Aid, Resuscitation
- **Support Email:** [deine E-Mail]
- **Privacy Policy URL:** (optional, aber empfohlen)
- **Website URL:** (optional)

#### Pricing
- **Free** (empfohlen für erste Version)
- Alternativ: Paid ($1.99 - $4.99)

### Schritt 3: App Binary hochladen

1. Klicke auf "Upload Binary"
2. Wähle die kompilierte `.iq` Datei (nicht `.prg`!)

**Wichtig:** Für den Store brauchst du eine `.iq` Datei:
```bash
# Kompiliere für Store-Veröffentlichung
monkeyc -o bin/CPRTrainer.iq -f monkey.jungle -y developer_key.der -r
```

Die `-r` Flag erstellt eine Release-Build.

### Schritt 4: Screenshots hochladen

1. Lade 2-5 Screenshots hoch
2. Ordne sie in gewünschter Reihenfolge an
3. Füge Beschreibungen hinzu (optional)

### Schritt 5: Gerätekompatibilität auswählen

- Wähle alle Geräte aus, die in deiner `manifest.xml` gelistet sind
- Empfehlung: Teste mindestens auf 2-3 Geräten vor Veröffentlichung

### Schritt 6: Beta-Testing (Optional aber empfohlen)

1. Aktiviere "Beta Testing"
2. Wähle "Closed Beta" oder "Open Beta"
3. Teile den Beta-Link mit Testern
4. Sammle Feedback für 1-2 Wochen
5. Behebe Bugs basierend auf Feedback

### Schritt 7: Submit for Review

1. Überprüfe alle Informationen
2. Akzeptiere die Store Agreement
3. Klicke auf "Submit for Review"

## Review-Prozess

### Was Garmin prüft:
- ✓ App startet ohne Crashes
- ✓ App funktioniert wie beschrieben
- ✓ Keine Richtlinienverstöße
- ✓ Angemessene Ressourcennutzung (Batterie, Speicher)
- ✓ Benutzerfreundlichkeit

### Dauer:
- Normalerweise **3-7 Werktage**
- Bei Problemen: Garmin sendet Feedback mit Verbesserungsvorschlägen

### Häufige Ablehnungsgründe:
- App crasht beim Testen
- Beschreibung entspricht nicht der Funktionalität
- Unzureichende Screenshots
- Zu hoher Batterieverbrauch
- Medizinische Claims ohne Disclaimer

## Nach der Veröffentlichung

### App ist live! 🎉

Deine App ist jetzt unter diesem Link erreichbar:
```
https://apps.garmin.com/apps/[APP_ID]
```

### Promotion

**Kostenlose Wege:**
1. **Social Media:** Teile den Link auf Twitter, LinkedIn, Facebook
2. **Foren:** Poste in Garmin-Foren und Erste-Hilfe-Communities
3. **Reddit:** r/Garmin, r/firstaid
4. **YouTube:** Erstelle ein Tutorial-Video
5. **Ersthelfer-Organisationen:** Kontaktiere DRK, Johanniter, etc.

**Bezahlte Promotion (optional):**
- Google Ads für "CPR Training App"
- Facebook/Instagram Ads
- Influencer Marketing (Erste-Hilfe-Trainer)

### Updates veröffentlichen

#### Versionsnummering:
- **1.0.1** - Bugfixes
- **1.1.0** - Neue Features
- **2.0.0** - Große Änderungen

#### Update-Prozess:
1. Erhöhe Version in `manifest.xml`
2. Kompiliere neue `.iq` Datei
3. Gehe zum App Manager → "Upload New Version"
4. Füge Release Notes hinzu
5. Submit for Review

### Analytics & Feedback

**Im Connect IQ App Manager:**
- Download-Zahlen
- Aktive Nutzer
- Bewertungen & Reviews
- Crash-Reports

**Auf Feedback reagieren:**
- Beantworte Bewertungen
- Behebe gemeldete Bugs schnell
- Implementiere Feature-Requests

## Rechtliche Hinweise

### Haftungsausschluss (wichtig!)

**In der App-Beschreibung immer klarstellen:**
```
HAFTUNGSAUSSCHLUSS: Diese App ist nur ein Trainingstool und ersetzt
keine professionelle Erste-Hilfe-Ausbildung. Im Notfall immer 112
rufen! Keine Haftung für medizinische Folgen.
```

### Datenschutz

Wenn du persönliche Daten sammelst:
- Erstelle eine Privacy Policy
- Halte dich an DSGVO (EU)
- Sei transparent über Datennutzung

Diese App sammelt **keine** persönlichen Daten.

### Medizinprodukt-Zulassung

Diese App ist **kein Medizinprodukt** da sie:
- Nur zum Training gedacht ist
- Keine medizinischen Diagnosen stellt
- Nicht zur Behandlung eingesetzt wird

Falls du dies änderst, brauchst du ggf. CE-Kennzeichnung (EU) oder FDA-Approval (USA)!

## Support & Community

### Support anbieten

**Erstelle eine Support-Email:**
- support@[dein-domain].de
- Oder nutze GitHub Issues

**FAQ erstellen:**
- Wie starte ich die App?
- Funktioniert auf meinem Gerät?
- Wie aktualisiere ich?

### Community aufbauen

- GitHub: Erlaube Contributions
- Discord/Slack: Community-Channel
- Newsletter: Updates & Tipps

## Monetarisierung (optional)

### Kostenlos mit Spenden
- "Buy me a coffee" Link
- PayPal Donate
- Ko-fi

### Paid App
- Einmalzahlung ($1.99 - $4.99)
- Keine In-App-Käufe möglich bei Garmin

### Premium Features
- Basis-Version kostenlos
- Separate "Pro" Version mit erweiterten Features:
  - Verschiedene CPR-Modi (Baby, Kind, Erwachsener)
  - Detaillierte Statistiken
  - Exportfunktion

## Erfolgsmetriken

**Nach 1 Monat:**
- [ ] 100+ Downloads
- [ ] 10+ Bewertungen
- [ ] Durchschnitt 4+ Sterne

**Nach 6 Monaten:**
- [ ] 1000+ Downloads
- [ ] 50+ Bewertungen
- [ ] Featured in "Health & Fitness"

**Nach 1 Jahr:**
- [ ] 5000+ Downloads
- [ ] Partner mit Erste-Hilfe-Organisationen
- [ ] Version 2.0 mit erweiterten Features

## Weiterführende Ressourcen

- **Garmin Developer Forum:** https://forums.garmin.com/developer/
- **Connect IQ Dokumentation:** https://developer.garmin.com/connect-iq/
- **Monkey C API Docs:** https://developer.garmin.com/connect-iq/api-docs/
- **Best Practices:** https://developer.garmin.com/connect-iq/connect-iq-basics/

---

**Viel Erfolg mit der Veröffentlichung! 🚀**

Bei Fragen oder Problemen: Öffne ein Issue auf GitHub oder kontaktiere die Garmin Developer Community.
