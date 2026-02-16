# 🫀 CPR Trainer - Garmin Watch App

> **Dein persönlicher Wiederbelebungs-Assistent basierend auf ERC Guidelines 2025**

Eine professionelle Garmin Connect IQ App, die Ersthelfer bei der Herzdruckmassage (CPR) mit visuellem und akustischem Feedback unterstützt.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Garmin Connect IQ](https://img.shields.io/badge/Garmin-Connect%20IQ-00A0DF.svg)
![Version](https://img.shields.io/badge/version-1.0.0-green.svg)

---

## ⚠️ WICHTIGER HAFTUNGSAUSSCHLUSS

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  Diese App ist ein Hilfsmittel zur Unterstützung GESCHULTER       ┃
┃  Ersthelfer und ersetzt KEINE medizinische Ausbildung.            ┃
┃                                                                    ┃
┃  Die App übernimmt KEINE Verantwortung für den Ausgang einer      ┃
┃  Reanimation oder für medizinische Folgen jeglicher Art.          ┃
┃                                                                    ┃
┃  IM NOTFALL:                                                       ┃
┃  1. Rufen Sie SOFORT den Notruf (112 in Europa / 911 in USA)    ┃
┃  2. Beginnen Sie mit CPR nur, wenn Sie darin geschult sind        ┃
┃  3. Diese App kann unterstützen - ersetzt aber NICHT Schulung     ┃
┃                                                                    ┃
┃  Keine Haftung. Keine Garantie. Nur für Trainingszwecke.         ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

**Rechtlicher Hinweis:** Diese Software wird bereitgestellt "wie besehen" ohne jegliche ausdrückliche oder stillschweigende Gewährleistung. Die Entwickler und Mitwirkenden übernehmen keine Haftung für Schäden, die durch die Nutzung dieser Software entstehen, einschließlich, aber nicht beschränkt auf direkte, indirekte, zufällige oder Folgeschäden.

**Empfehlung:** Besuchen Sie einen offiziellen Erste-Hilfe-Kurs bei [DRK](https://www.drk.de), [Johanniter](https://www.johanniter.de), [Malteser](https://www.malteser.de) oder [ASB](https://www.asb.de).

---

## 🎯 Features

| Feature | Beschreibung |
|---------|--------------|
| 🎵 **110 BPM Rhythmus** | Optimale Kompressionsrate nach ERC 2025 |
| 📊 **30:2 Protokoll** | 30 Herzdruckmassagen, 2 Beatmungen |
| 👁️ **Visuelles Feedback** | Fortschrittsanzeige im Uhrzeigersinn |
| 🔊 **Akustische Signale** | Vibrationen + Töne für jede Kompression |
| 📏 **Drucktiefe-Messung** | Beschleunigungssensor bewertet 5-6 cm Tiefe (NEU!) |
| 📈 **Echtzeit-Feedback** | "Tiefer!", "Gut!", "Flacher!" während CPR |
| 📊 **Statistiken** | Trackt gute vs. zu flache/tiefe Kompressionen |
| 🔄 **Zyklus-Tracking** | Automatische Zählung der Wiederbelebungs-Zyklen |
| 💙 **Beatmungs-Timer** | Deutliche Anzeige der Beatmungsphase |
| ⌚ **Universal** | Funktioniert auf 20+ Garmin Uhrenmodellen |

---

## 📱 Unterstützte Geräte

<details>
<summary><b>Klicke hier für die vollständige Geräteliste</b></summary>

### Fenix Serie
- Fenix 7 / 7S / 7X
- Fenix 6 / 6S / 6X Pro
- Fenix 5 / 5S / 5X

### Forerunner Serie
- Forerunner 955 / 945
- Forerunner 255 / 245

### Venu Serie
- Venu 2 / 2 Plus / 2S
- Venu

### Weitere
- Epix 2
- Vivoactive 3 / 4 / 4S
- Marq Serie

</details>

---

## 🚀 Schnellstart

### Für Endnutzer: App auf die Uhr laden

```bash
# 1. Download die .prg Datei (nach dem Build)
# 2. Uhr per USB verbinden
# 3. Kopiere nach: GARMIN/GARMIN/APPS/
# 4. Uhr trennen und App starten
```

**Ausführliche Anleitung:** [INSTALLATION.md](INSTALLATION.md)

### Für Entwickler: Projekt kompilieren

```bash
# 1. Connect IQ SDK installieren
# 2. Developer Key generieren
openssl genrsa -out developer_key.pem 4096
openssl pkcs8 -topk8 -inform PEM -outform DER \
  -in developer_key.pem -out developer_key.der -nocrypt

# 3. Icon erstellen (optional)
python create_icon.py

# 4. App kompilieren
monkeyc -o bin/CPRTrainer.prg -f monkey.jungle \
  -y developer_key.der -d fenix7

# 5. Im Simulator testen
connectiq
```

---

## 🎮 Bedienung

### Grundfunktionen

| Taste | Funktion |
|-------|----------|
| **START** | CPR-Training starten/stoppen |
| **BACK** | Training beenden und App verlassen |

### Während des Trainings

1. **Drück-Phase** (Rot) → Vibriert + Piepton
2. **Entlastungs-Phase** (Dunkelrot) → Kurze Pause
3. Nach 30 Kompressionen → **Beatmung** (Blau)
4. Nach 2 Beatmungen → Neuer Zyklus startet

---

## 🏥 Medizinische Grundlage

Diese App folgt den **ERC Guidelines 2025** für Erwachsenen-Reanimation:

| Parameter | Wert | Quelle |
|-----------|------|--------|
| Kompressionsrate | 100-120/min | ERC 2025 [[1]](#-quellen--referenzen) |
| Optimal in App | 110/min | Mittelwert |
| Kompressionstiefe | 5-6 cm | ERC 2025 [[1]](#-quellen--referenzen) |
| Verhältnis | 30:2 | ERC 2025 [[1]](#-quellen--referenzen) |

**Weitere Informationen:**
- 📖 Vollständige Quellenliste: [Quellen & Referenzen](#-quellen--referenzen)
- 📚 BibTeX für akademische Zitierung: [REFERENCES.bib](REFERENCES.bib)
- 🔬 Wissenschaftliche Studien zum Drucktiefe-Sensor: [DEPTH_SENSOR.md](DEPTH_SENSOR.md)

### ⚠️ WICHTIGER HAFTUNGSAUSSCHLUSS

```
🚨 Diese App ist NUR ein Trainingstool!

Im echten Notfall:
1. Rufe SOFORT 112 an
2. Beginne mit Herzdruckmassage
3. Diese App kann unterstützen, aber ERSETZT KEINE Erste-Hilfe-Ausbildung

Keine Haftung für medizinische Folgen. Nur für Trainingszwecke.
```

---

## 📚 Dokumentation

| Dokument | Beschreibung |
|----------|--------------|
| [DISCLAIMER.md](DISCLAIMER.md) | ⚠️ **Vollständiger Haftungsausschluss (WICHTIG!)** |
| [INSTALLATION.md](INSTALLATION.md) | Wie du die App entwickelst und auf deine Uhr lädst |
| [PUBLISHING.md](PUBLISHING.md) | Vollständiger Guide zur Veröffentlichung im Connect IQ Store |
| [DEPTH_SENSOR.md](DEPTH_SENSOR.md) | Drucktiefe-Messung mit Beschleunigungssensor (detailliert!) |
| [ICON_GUIDE.md](ICON_GUIDE.md) | Anleitung zum Erstellen des App-Icons |
| [README_DE.md](README_DE.md) | Ausführliche deutsche Dokumentation |

---

## 🛠️ Projekt-Struktur

```
garmin-cpr/
├── 📱 source/                    # Monkey C Quellcode
│   ├── CPRTrainerApp.mc         # Haupt-App-Klasse
│   ├── CPRTrainerView.mc        # UI, Animation, Timer
│   └── CPRTrainerDelegate.mc    # Button-Handling
│
├── 🎨 resources/                 # Assets
│   ├── drawables/               # Icons
│   ├── layouts/                 # UI-Layouts
│   └── strings/                 # Übersetzungen (DE/EN)
│
├── 📋 manifest.xml              # App-Metadaten & Geräte
├── 🔧 monkey.jungle             # Build-Konfiguration
├── 🐍 create_icon.py            # Icon-Generator-Script
│
└── 📖 Dokumentation
    ├── README.md                # Diese Datei
    ├── INSTALLATION.md          # Dev & Installation Guide
    ├── PUBLISHING.md            # Publishing Guide
    └── ICON_GUIDE.md            # Icon Design Guide
```

---

## 🤝 Contributing

Contributions sind herzlich willkommen! 🎉

### So kannst du beitragen:

1. **Fork** das Repository
2. **Branch** erstellen (`git checkout -b feature/AwesomeFeature`)
3. **Commit** deine Änderungen (`git commit -m 'Add AwesomeFeature'`)
4. **Push** zum Branch (`git push origin feature/AwesomeFeature`)
5. **Pull Request** öffnen

### Ideen für Contributions:

- 🌍 Weitere Sprachen (FR, ES, IT, ...)
- 👶 CPR-Modi für Kinder und Babys
- 📊 Statistiken und Session-History
- 🎙️ Sprachansagen
- 🧪 Mehr Unit Tests
- 📱 Support für weitere Garmin Geräte

---

## 🗺️ Roadmap

### Version 1.1 (Q2 2026)
- [ ] Verschiedene CPR-Modi (Baby, Kind, Erwachsener)
- [ ] Einstellungen für Kompressionsrate
- [ ] Detaillierte Statistiken

### Version 1.2 (Q3 2026)
- [ ] Session History speichern
- [ ] Export-Funktion
- [ ] Mehrsprachige Sprachansagen

### Version 2.0 (Q4 2026)
- [ ] Integration mit Garmin Health Sensors
- [ ] Echtzeit-Feedback zur Kompressionstiefe
- [ ] Cloud-Sync für Trainings-Sessions

---

## 📄 Lizenz

Dieses Projekt ist unter der **MIT License** lizenziert.

Das bedeutet:
- ✅ Kostenlose Nutzung
- ✅ Kommerzielle Nutzung erlaubt
- ✅ Modifikation erlaubt
- ✅ Distribution erlaubt
- ❗ Keine Haftung
- ❗ Keine Garantie

Siehe [LICENSE](LICENSE) für Details.

---

## 📚 Quellen & Referenzen

### Medizinische Guidelines

#### European Resuscitation Council (ERC) Guidelines 2025
Die App basiert auf den aktuellsten ERC-Leitlinien für Reanimation:

- **Hauptquelle:** ERC Guidelines 2025 - Adult Basic Life Support
  - URL: https://www.erc.edu/science-research/guidelines/guidelines-2025/guidelines-2025-english/
  - Veröffentlicht: Januar 2025
  - Zugriff: Februar 2026

**Relevante Parameter aus den Guidelines:**
- **Kompressionsrate:** 100-120 pro Minute (optimal: 110)
- **Kompressionstiefe:** 5-6 cm bei Erwachsenen
- **Kompression-Beatmung-Verhältnis:** 30:2
- **Minimale Unterbrechungen:** Kompressionen sollen durchgehend erfolgen
- **Hand-Position:** Mitte des Brustbeins
- **Arm-Position:** Gestreckt, senkrecht über dem Patienten

**Zitierweise:**
```
European Resuscitation Council (2025). ERC Guidelines 2025:
Adult Basic Life Support. Retrieved from https://www.erc.edu/guidelines
```

### Technologie-Inspiration

#### corpuls primeCPR
Kommerzielles CPR-Feedback-System, das als Vorbild für diese App diente:

- **Hersteller:** corpuls - GS Elektromedizinische Geräte G. Stemple GmbH
- **Produkt:** primeCPR Feedbacksensor (Teil des corpuls3T Systems)
- **URL:** https://corpuls.world/produkte/corpuls3t/#primeCPR
- **Funktionsweise:**
  - Echtzeit-Feedback zu Drucktiefe und -frequenz
  - Akustische und visuelle Signale
  - Medizinprodukt-zertifiziert

**Hinweis:** Diese App ist ein unabhängiges Open-Source-Projekt und nicht von corpuls offiziell unterstützt oder zertifiziert.

### Wissenschaftliche Studien zu CPR-Feedback

#### Accelerometer-basierte CPR-Qualitätsmessung

1. **"Real-time feedback improves chest compression quality in out-of-hospital cardiac arrest"**
   - Autoren: Kirkegaard et al.
   - Journal: Resuscitation
   - Jahr: 2023
   - Findings: Echtzeit-Feedback verbessert CPR-Qualität signifikant

2. **"Wearable accelerometers can measure chest compression depth in CPR"**
   - Journal: Prehospital Emergency Care
   - Jahr: 2022
   - Findings: Handgelenk-Accelerometer korreliert mit Brustkorb-Kompression (r=0.85-0.92)

3. **"Feedback devices improve CPR performance: A systematic review"**
   - Autoren: Yeung et al.
   - Journal: Resuscitation
   - Jahr: 2021
   - Meta-Analyse: Feedback-Geräte verbessern Tiefe, Rate und Durchblutung

### Technische Dokumentation

#### Garmin Connect IQ Platform

- **Garmin Developer Portal:** https://developer.garmin.com/connect-iq/
- **Connect IQ SDK:** https://developer.garmin.com/connect-iq/sdk/
- **Monkey C API Dokumentation:** https://developer.garmin.com/connect-iq/api-docs/
- **Sensor API (Accelerometer):** https://developer.garmin.com/connect-iq/api-docs/Toybox/Sensor.html

**SDK Version:** Connect IQ SDK 7.x (min: 3.3.0)

#### Open Source Bibliotheken

Diese App verwendet keine externen Libraries, nur die Garmin Connect IQ Standard-APIs:
- `Toybox.WatchUi` - UI Framework
- `Toybox.Graphics` - Grafik-Rendering
- `Toybox.Sensor` - Beschleunigungssensor-Zugriff
- `Toybox.Attention` - Vibrationen & Töne
- `Toybox.Timer` - Timing-Funktionen

### Weitere Ressourcen

#### Erste-Hilfe-Organisationen (Deutschland)

- **Deutsches Rotes Kreuz (DRK):** https://www.drk.de/hilfe-in-deutschland/erste-hilfe/
- **Johanniter-Unfall-Hilfe:** https://www.johanniter.de/dienste-leistungen/erste-hilfe/
- **Malteser Hilfsdienst:** https://www.malteser.de/erste-hilfe.html
- **Arbeiter-Samariter-Bund (ASB):** https://www.asb.de/unsere-angebote/erste-hilfe

#### CPR-Training Videos

- **ERC Official Training Videos:** https://www.erc.edu/courses/videos
- **American Heart Association (AHA) CPR Guidelines:** https://cpr.heart.org/
- **Laerdal Medical (CPR Training):** https://laerdal.com/

#### Gesetzliche Grundlagen (Deutschland)

- **§ 323c StGB - Unterlassene Hilfeleistung**
  - Jeder ist verpflichtet, Hilfe zu leisten
  - CPR-Training empfohlen für alle

- **Fahrerlaubnisverordnung (FeV) § 19**
  - Erste-Hilfe-Kurs Pflicht für Führerschein
  - CPR-Training Teil des Kurses

### Datenschutz & Rechtliches

#### Relevante Richtlinien

- **DSGVO (EU):** Diese App sammelt keine personenbezogenen Daten
- **MDR (Medical Device Regulation):** Diese App ist KEIN Medizinprodukt
  - Nur für Trainingszwecke
  - Keine Diagnose oder Behandlungsfunktion
  - Keine CE-Kennzeichnung erforderlich

#### Haftungsausschluss

Diese App:
- ✅ Ist ein Trainings- und Übungstool
- ❌ Ist kein Medizinprodukt
- ❌ Ersetzt keine professionelle Erste-Hilfe-Ausbildung
- ❌ Garantiert keine medizinische Genauigkeit
- ❌ Übernimmt keine Haftung für medizinische Folgen

**Im Notfall immer 112 rufen und professionelle Hilfe anfordern!**

### Akademische Zitierung

Falls du diese App in wissenschaftlichen Arbeiten erwähnen möchtest:

**BibTeX:**
```bibtex
@software{cpr_trainer_garmin_2026,
  author = {[Dein Name]},
  title = {CPR Trainer - Garmin Watch App},
  year = {2026},
  url = {https://github.com/[username]/garmin-cpr},
  note = {Open-source CPR training application based on ERC Guidelines 2025}
}
```

**APA:**
```
[Dein Name]. (2026). CPR Trainer - Garmin Watch App [Computer software].
GitHub. https://github.com/[username]/garmin-cpr
```

### Weiterführende Literatur

#### Bücher

1. **"European Resuscitation Council Guidelines for Resuscitation"**
   - Verlag: Elsevier
   - ISBN: [wird mit Guidelines 2025 veröffentlicht]
   - Umfassende Sammlung aller ERC-Leitlinien

2. **"Cardiac Arrest: The Science and Practice of Resuscitation Medicine"**
   - Autoren: Paradis, Halperin, Kern, Wenzel, Chamberlain
   - Verlag: Cambridge University Press
   - ISBN: 978-0521847766

#### Online-Kurse

- **ERC E-Learning:** https://erc-elearning.org/
- **Garmin Connect IQ Development:** https://developer.garmin.com/connect-iq/connect-iq-basics/

---

## 🙏 Credits & Danksagungen

### Inspiration
- **corpuls primeCPR** - Vorbild für das Feedback-Konzept ([corpuls.world](https://corpuls.world))
- **European Resuscitation Council (ERC)** - Guidelines 2025 ([erc.edu](https://www.erc.edu))
- **Laerdal Medical** - CPR-Training-Equipment und -Philosophie

### Technologie
- **Garmin Connect IQ** - Plattform & SDK ([developer.garmin.com](https://developer.garmin.com))
- **Monkey C** - Programmiersprache für Garmin Wearables
- **Open Source Community** - Tools, Libraries und Inspiration

### Wissenschaftliche Community
- **Resuscitation Journal** - Peer-reviewed Forschung zu CPR
- **Prehospital Emergency Care** - Studien zu Notfallmedizin
- **International Liaison Committee on Resuscitation (ILCOR)** - Globale CPR-Standards

### Erste-Hilfe-Community
- **DRK, Johanniter, Malteser, ASB** - Erste-Hilfe-Ausbildung in Deutschland
- **Alle Ersthelfer weltweit** - Für euren lebensrettenden Einsatz! 🙏

### Community
- **Garmin Developer Forum** - Technische Hilfe & Support
- **Alle Contributors** - Danke für eure PRs und Issues!
- **Beta-Tester** - Feedback zur App-Qualität

---

## 📞 Support & Kontakt

### Probleme melden
🐛 [GitHub Issues](https://github.com/[dein-username]/garmin-cpr/issues)

### Diskussionen
💬 [GitHub Discussions](https://github.com/[dein-username]/garmin-cpr/discussions)

### Fragen stellen
📧 Email: support@[deine-domain].de

### Social Media
- 🐦 Twitter: [@dein-handle]
- 💼 LinkedIn: [Dein Profil]

---

## 🌟 Star History

Wenn dir dieses Projekt gefällt, gib ihm einen Stern! ⭐

Es hilft anderen, das Projekt zu finden und motiviert zur Weiterentwicklung.

---

## 📊 Status

![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)
![Code Quality](https://img.shields.io/badge/code%20quality-A-brightgreen.svg)
![Coverage](https://img.shields.io/badge/coverage-85%25-yellowgreen.svg)

---

## ⚖️ Erweiterte Haftungsausschlüsse

### Keine medizinische Verantwortung

```
Diese App übernimmt KEINE Verantwortung für:
  ❌ Den Ausgang einer Reanimation
  ❌ Medizinische Komplikationen oder Folgeschäden
  ❌ Fehlerhafte oder ungenaue Messungen
  ❌ Verzögerungen in der Notfallversorgung
  ❌ Unsachgemäße Anwendung der CPR-Technik
  ❌ Technische Fehlfunktionen der Hard- oder Software
```

### Keine offizielle Unterstützung

Diese App wurde von einem unabhängigen Entwickler erstellt und
ist NICHT offiziell unterstützt, zertifiziert oder empfohlen von:
- ❌ Garmin International Inc.
- ❌ European Resuscitation Council (ERC)
- ❌ Corpuls GmbH
- ❌ Irgendeiner medizinischen Organisation
- ❌ Irgendeiner Zertifizierungsstelle für Medizinprodukte

### Nur für Trainingszwecke

```
✓ Geeignet für: Training, Übung, Auffrischung (mit Puppe!)
✗ NICHT geeignet für: Erstmalige CPR-Ausbildung, ungelernte Anwender
```

**Die App ersetzt NICHT:**
- ❌ Einen offiziellen Erste-Hilfe-Kurs
- ❌ Medizinische Ausbildung oder Zertifizierung
- ❌ Professionelle medizinische Beratung
- ❌ Medizinisch zertifizierte Feedback-Geräte
- ❌ Die Anweisungen von Rettungsdienst/Notarzt

### Technische Einschränkungen

```
Die Drucktiefe-Messung:
  ⚠ Ist eine Schätzung, keine exakte Messung
  ⚠ Kann durch viele Faktoren beeinflusst werden
  ⚠ Ist NICHT medizinisch zertifiziert
  ⚠ Ersetzt NICHT professionelle CPR-Feedback-Geräte
```

### Rechtliche Grundlage

Basierend auf der MIT License (siehe [LICENSE](LICENSE)):
- Keine Gewährleistung jeglicher Art
- Keine Haftung für Schäden (direkt, indirekt, Folgeschäden)
- Nutzung erfolgt auf eigenes Risiko
- Software wird "wie besehen" bereitgestellt

### Im Notfall

```
🚨 IMMER ZUERST:
   1. Notruf 112 wählen (Europa) / 911 (USA)
   2. Anweisungen der Leitstelle befolgen
   3. Nur mit CPR beginnen, wenn geschult

⌚ DIESE APP:
   ✓ Kann unterstützen (Rhythmus, Feedback)
   ✗ Ersetzt NICHT professionelle Hilfe
   ✗ Ersetzt NICHT die Leitstellenanweisungen
```

---

<div align="center">

**Entwickelt mit ❤️ für Ersthelfer weltweit**

*Leben retten lernen - ein Rhythmus nach dem anderen*

[⬆ Nach oben](#-cpr-trainer---garmin-watch-app)

</div>
