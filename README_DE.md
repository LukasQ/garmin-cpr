# CPR Trainer - Garmin Connect IQ App

Eine Garmin Watch App, die bei der Herzdruckmassage (CPR) unterstützt mit visuellem und akustischem Feedback.

## 🎯 Features

- ✅ **110 Kompressionen pro Minute** - Optimaler Rhythmus nach ERC Guidelines 2025
- ✅ **30:2 Verhältnis** - 30 Herzdruckmassagen, 2 Beatmungen
- ✅ **Visuelles Feedback** - Fortschrittsanzeige im Uhrzeigersinn
- ✅ **Akustisches Feedback** - Vibrationen und Töne für jede Kompression
- ✅ **Zyklus-Tracking** - Automatische Zählung der Zyklen
- ✅ **Beatmungs-Erinnerung** - Deutliche Anzeige der Beatmungsphase
- ✅ **Universell** - Funktioniert auf allen gängigen Garmin Watches

## 📱 Unterstützte Geräte

- Fenix Serie (5, 6, 7)
- Forerunner Serie (245, 255, 945, 955)
- Venu Serie (1, 2, 2 Plus)
- Vivoactive Serie (3, 4)
- Epix 2
- Marq
- ... und viele weitere!

## 🚀 Quick Start

### Installation auf deine Uhr

1. **Download** die neueste `.prg` Datei aus den Releases
2. **Verbinde** deine Garmin Uhr per USB
3. **Kopiere** die Datei nach `GARMIN/GARMIN/APPS/`
4. **Trenne** die Uhr vom Computer
5. **Starte** die App: Menü → Aktivitäten → CPR Trainer

Detaillierte Anleitung: [INSTALLATION.md](INSTALLATION.md)

### Bedienung

1. **START-Taste** drücken → CPR-Training startet
2. **Folge dem Rhythmus** - Die Uhr vibriert bei jeder Kompression
3. **Beachte die Anzeige** - Wechsel zwischen Kompression (grün) und Beatmung (blau)
4. **STOP/BACK-Taste** → Training beenden

## 🏥 Medizinischer Hintergrund

Diese App basiert auf den **European Resuscitation Council (ERC) Guidelines 2025** für die Reanimation von Erwachsenen:

- **Kompressionsrate:** 100-120/min (optimal: 110/min)
- **Kompressionstiefe:** 5-6 cm
- **Kompression-Beatmung-Verhältnis:** 30:2
- **Kompressionen ohne Unterbrechung** bei einem Helfer

### ⚠️ Wichtiger Hinweis

Diese App ist **nur ein Trainingstool** und ersetzt keine professionelle Erste-Hilfe-Ausbildung!

**Im Notfall:**
1. 🚨 **112 anrufen** (Notruf)
2. 💪 Sofort mit Herzdruckmassage beginnen
3. 🎯 Diese App kann den Rhythmus unterstützen

## 👨‍💻 Für Entwickler

### Projekt-Setup

```bash
# Repository klonen
git clone https://github.com/[dein-username]/garmin-cpr.git
cd garmin-cpr

# Connect IQ SDK installieren (siehe INSTALLATION.md)

# Projekt kompilieren
monkeyc -o bin/CPRTrainer.prg -f monkey.jungle -y developer_key.der -d fenix7
```

### Projekt-Struktur

```
garmin-cpr/
├── source/                 # Monkey C Quellcode
│   ├── CPRTrainerApp.mc   # Haupt-App-Klasse
│   ├── CPRTrainerView.mc  # UI und Visualisierung
│   └── CPRTrainerDelegate.mc  # Input-Handling
├── resources/              # Assets und Ressourcen
│   ├── drawables/         # Icons und Grafiken
│   ├── layouts/           # Layout-XMLs
│   └── strings/           # Übersetzungen
├── manifest.xml           # App-Metadaten
├── monkey.jungle          # Build-Konfiguration
├── INSTALLATION.md        # Installations-Anleitung
└── PUBLISHING.md          # Veröffentlichungs-Guide
```

### Dependencies

- Garmin Connect IQ SDK 7.x oder höher
- OpenSSL (für Developer Key)
- Optional: Visual Studio Code mit Monkey C Extension

### Contributing

Contributions sind willkommen! 🎉

1. Fork das Repository
2. Erstelle einen Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit deine Änderungen (`git commit -m 'Add some AmazingFeature'`)
4. Push zum Branch (`git push origin feature/AmazingFeature`)
5. Öffne einen Pull Request

### Roadmap

- [ ] **v1.1:** Verschiedene CPR-Modi (Baby, Kind, Erwachsener)
- [ ] **v1.2:** Statistiken und Session-History
- [ ] **v1.3:** Mehrsprachige Sprachansagen
- [ ] **v2.0:** Integration mit Garmin Health Sensors
- [ ] **v2.1:** Export-Funktion für Trainings-Sessions

## 📄 Lizenz

Dieses Projekt ist lizenziert unter der MIT License - siehe [LICENSE](LICENSE) für Details.

## 🙏 Danksagungen

- **European Resuscitation Council (ERC)** für die Guidelines 2025
- **Corpuls** für die Inspiration durch primeCPR
- **Garmin Developer Community** für Support und Dokumentation

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/[dein-username]/garmin-cpr/issues)
- **Diskussionen:** [GitHub Discussions](https://github.com/[dein-username]/garmin-cpr/discussions)
- **Email:** support@[deine-domain].de

## 🌟 Credits

Entwickelt mit ❤️ für Ersthelfer und alle, die Leben retten wollen.

**Hinweis:** Diese App wurde von einem unabhängigen Entwickler erstellt und ist nicht offiziell von Garmin, dem ERC oder Corpuls unterstützt.

---

**Wenn diese App dir gefällt, gib dem Projekt einen Stern ⭐**
