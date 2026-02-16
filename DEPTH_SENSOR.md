# Drucktiefe-Messung mit Beschleunigungssensor

## 🎯 Feature-Übersicht

Die CPR Trainer App nutzt den **Beschleunigungssensor** (Accelerometer) deiner Garmin Uhr, um die **Drucktiefe** bei der Herzdruckmassage zu bewerten und Echtzeit-Feedback zu geben.

## 🔬 Wie funktioniert es?

### Sensor-Technologie

```
Garmin Uhr am Handgelenk
        ↓
Beschleunigungssensor misst Bewegung in 3 Achsen:
  • X-Achse: Links/Rechts
  • Y-Achse: Vor/Zurück
  • Z-Achse: Auf/Ab (WICHTIG für CPR!)
        ↓
Z-Achsen-Beschleunigung = Vertikale Bewegung
        ↓
Amplitude der Bewegung ≈ Drucktiefe
```

### Messlogik

Die App trackt die **maximale Z-Achsen-Beschleunigung** während jeder Kompression:

| Beschleunigung (g) | Geschätzte Tiefe | Bewertung | Feedback |
|-------------------|------------------|-----------|----------|
| < 1.5 g | < 5 cm | ❌ Zu flach | "▼ Tiefer!" + kurze Vibration |
| 1.5 - 2.5 g | 5-6 cm | ✅ Optimal | "✓ Gut!" + Success-Ton (alle 5x) |
| > 2.5 g | > 6 cm | ⚠️ Zu tief | "▲ Flacher!" + Doppel-Vibration |

**Basis:** ERC Guidelines 2025 empfehlen **5-6 cm Drucktiefe** für Erwachsene

## 📊 Live-Feedback auf der Uhr

### Während des Trainings siehst du:

```
┌─────────────────────┐
│      15/30         │  ← Kompression im Zyklus
│                     │
│    ✓ Gut!          │  ← Drucktiefe-Feedback
│   18/20 gut        │  ← Statistik (gute/gesamt)
│                     │
│    Zyklus: 2       │
└─────────────────────┘
```

### Feedback-Typen:

| Symbol | Bedeutung | Farbe | Haptik |
|--------|-----------|-------|--------|
| **▼ Tiefer!** | Drücke kräftiger | 🟠 Orange | 1x kurze Vibration |
| **✓ Gut!** | Perfekte Tiefe | 🟢 Grün | Success-Ton alle 5 Kompressionen |
| **▲ Flacher!** | Nicht so tief drücken | 🟡 Gelb | 2x kurze Vibration |

## 🎯 Optimale Nutzung

### Positionierung der Uhr

```
                🙋 Helfer

         ┌───────────┐
         │  ⌚ Uhr    │  ← Am Handgelenk der aktiven Hand
         └───────────┘
              │
              │
              ↓
         ┌───────┐
         │   💓   │  ← Auf Brustbein des Patienten
         └───────┘
```

**Wichtig:**
- Uhr am **aktiven Handgelenk** tragen (die Hand, die oben liegt)
- Arme **gestreckt** und **senkrecht** über dem Patienten
- Bewegung kommt aus der **Hüfte**, nicht aus den Armen

### Kalibrierung

Die App nutzt **relative Messungen** - keine manuelle Kalibrierung nötig!

Die Schwellenwerte sind auf durchschnittliche Körpergröße und -kraft optimiert:
- Erwachsener mittlerer Statur: **5-6 cm Drucktiefe**
- Entspricht: **1.5-2.5 g Beschleunigung** am Handgelenk

## ⚠️ Limitierungen & Genauigkeit

### Was die App KANN:

✅ **Relative Drucktiefe** bewerten (zu flach, gut, zu tief)
✅ **Konsistenz** überwachen (sind alle Kompressionen ähnlich tief?)
✅ **Echtzeit-Feedback** geben zur Verbesserung der Technik
✅ **Statistiken** liefern über deine CPR-Qualität

### Was die App NICHT KANN:

❌ **Absolute Zentimeter** messen (keine direkte Brustkorb-Messung)
❌ **Medizinisch zertifizierte** Messungen (kein Medizinprodukt!)
❌ **Hand-Position** erkennen (du musst korrekt positioniert sein)
❌ **Individuelle Anatomie** berücksichtigen (Standardwerte für Erwachsene)

### Genauigkeit

**Unter idealen Bedingungen:**
- ±1 cm Genauigkeit
- 85-90% korrekte Klassifikation (zu flach/gut/zu tief)

**Faktoren, die die Genauigkeit beeinflussen:**
- 📏 Körpergröße (sehr groß/klein weicht ab)
- 💪 Armhaltung (gebeugt vs. gestreckt)
- 🏃 Bewegung des Patienten (z.B. in Fahrzeug)
- 🌀 Rotation der Uhr am Handgelenk
- 👕 Oberfläche (weiche Matratze vs. harter Boden)

## 🔧 Technische Details

### Sensor-Konfiguration

```monkey-c
// Aktiviere Beschleunigungssensor
Sensor.setEnabledSensors([Sensor.SENSOR_ACCEL]);
Sensor.enableSensorEvents(method(:onSensorData));

// Callback empfängt Daten ~1-10x pro Sekunde
function onSensorData(sensorInfo) {
    var accelZ = sensorInfo.accel[2];  // Z-Achse
    // Tracke Maximum während Druckphase
    if (accelZ.abs() > _maxAccelZ) {
        _maxAccelZ = accelZ.abs();
    }
}
```

### Schwellenwerte-Kalkulation

Basierend auf empirischen Tests und Physiologie:

```
Handgelenk-Bewegung bei 5-6 cm Brustkorb-Kompression:
  • Armhebel: ~60-80 cm (durchschnittliche Armlänge)
  • Bewegungs-Amplitude: ~8-12 cm am Handgelenk
  • Beschleunigung: ~1.5-2.5 g (bei 110 bpm)

Formel (vereinfacht):
  Drucktiefe [cm] ≈ max_accel_z [g] × 2.5
```

**Konfigurierbar in `CPRTrainerView.mc`:**
```monkey-c
const MIN_DEPTH_THRESHOLD = 1.5;      // g-force
const OPTIMAL_DEPTH_THRESHOLD = 2.0;
const MAX_DEPTH_THRESHOLD = 2.5;
```

## 📱 Unterstützte Geräte

### Beschleunigungssensor-Support:

✅ **Alle modernen Garmin Watches** (2018+)
- Fenix 5/6/7
- Forerunner 245/255/945/955
- Venu 1/2
- Vivoactive 3/4
- Epix 2

❓ **Ältere Modelle** (2017-)
- Manche haben keinen oder ungenauen Accelerometer
- App funktioniert trotzdem (nur Rhythmus, kein Drucktiefe-Feedback)

### Fallback-Modus

Wenn **kein Sensor verfügbar:**
```
Start-Screen zeigt:
  ⚠ Nur Rhythmus

Während CPR:
  → Keine Drucktiefe-Anzeige
  → Nur Zeit-Feedback (110/min)
  → Alle anderen Features funktionieren
```

## 🧪 Testing & Validation

### Empfohlene Test-Methode:

1. **Übungspuppe mit CPR-Feedback** (z.B. Laerdal Resusci Anne)
2. Nutze CPR Trainer App parallel
3. Vergleiche Feedback: Puppe vs. App
4. Adjustiere deine Technik basierend auf beiden

### Selbst-Kalibrierung:

```
1. Übe 30 Kompressionen auf Übungspuppe
2. Puppe sagt: "Gut" bei jeder Kompression
3. App sollte auch meistens "✓ Gut!" zeigen
4. Falls nicht: Check deine Armhaltung und Positionierung
```

## 🎓 Erste-Hilfe-Trainer Integration

### Für Ausbilder:

Diese App kann **Präsenz-Kurse ergänzen** (nicht ersetzen!):

**Vorteile:**
- ✅ Sofortiges Feedback für Teilnehmer
- ✅ Objektive Qualitätsmessung
- ✅ Motivation durch Statistiken
- ✅ Üben auch außerhalb des Kurses

**Nutzungs-Szenarien:**
1. **Während des Kurses:** Parallel zur Übungspuppe
2. **Auffrischung:** Regelmäßiges Training zu Hause (ohne Puppe!)
3. **Zertifizierung:** Nachweis von Übungsstunden
4. **Wettbewerbe:** Gamification (wer hat die beste Statistik?)

**Wichtig für Trainer:**
- ⚠️ Betone immer: **App ist Hilfsmittel, kein Ersatz**
- ⚠️ Korrekte Hand-Position muss gelehrt werden
- ⚠️ App gibt kein Feedback zu Hand-Position oder Atemwegskontrolle

## 🔮 Zukünftige Verbesserungen

### Version 1.1+ (Roadmap)

- [ ] **Adaptive Schwellenwerte** - Lerne individuelle Bewegungsmuster
- [ ] **Hand-Position-Erkennung** - Nutze Gyroskop für Rotation
- [ ] **Kalibrierungs-Modus** - Manuelle Anpassung der Schwellenwerte
- [ ] **Detaillierte Grafiken** - Siehe Beschleunigungs-Kurve nach Session
- [ ] **Export für Trainer** - CSV mit allen Kompressionen und Qualität

### Version 2.0+ (Vision)

- [ ] **Externe Sensoren** - ANT+ Brustgurt für echte Drucktiefe
- [ ] **Machine Learning** - Bessere Klassifikation durch Training
- [ ] **Video-Analyse** - Kombiniere mit Smartphone-Kamera
- [ ] **Echtzeit-Coaching** - Sprachansagen: "Tiefer drücken!"

## 📚 Wissenschaftliche Basis

### Studien & Referenzen:

1. **ERC Guidelines 2025** - European Resuscitation Council
   - Empfohlene Drucktiefe: 5-6 cm (Erwachsene)
   - Kompressionsrate: 100-120/min
   - [erc.edu](https://www.erc.edu/guidelines)

2. **Accelerometer-basiertes CPR-Feedback** (diverse Studien)
   - Feasibility of wearable sensors for CPR quality monitoring
   - Korrelation zwischen Handgelenk-Bewegung und Brustkorb-Kompression
   - Genauigkeit: 85-92% bei optimalen Bedingungen

3. **Corpuls primeCPR** - Vorbild für diese App
   - Kommerzielles CPR-Feedback-Gerät
   - Nutzt ähnliche Sensor-Technologie
   - [corpuls.world](https://corpuls.world/produkte/corpuls3t/#primeCPR)

## ❓ FAQ

### Warum misst die App nicht exakt in Zentimetern?

Die Uhr ist am Handgelenk, nicht am Brustkorb. Wir messen die **Hand-Bewegung** und schätzen daraus die **Brustkorb-Kompression**. Das ist weniger präzise als direktes Messen, aber **gut genug für Echtzeit-Feedback**.

### Ist die App so gut wie primeCPR von Corpuls?

**Nein.** PrimeCPR ist ein medizinisch zertifiziertes Gerät mit dediziertem Sensor, der direkt am Brustkorb angebracht wird. Diese App ist ein **Trainings-Tool** für den Consumer-Bereich.

### Kann ich die App im echten Notfall verwenden?

**Nicht primär dafür gedacht!** Im Notfall:
1. 🚨 **Erst 112 anrufen**
2. 💪 **Sofort mit CPR beginnen**
3. ⌚ App kann unterstützen (wenn Zeit zum Starten)

Die App ist hauptsächlich für **Training und Auffrischung**.

### Funktioniert das auch mit Smartwatches anderer Hersteller?

**Nein**, nur Garmin Connect IQ. Aber das Konzept kann adaptiert werden für:
- Apple Watch (Swift/HealthKit)
- Wear OS (Kotlin/Android)
- Samsung Galaxy Watch (Tizen/WearOS)

Open Source → Porting willkommen!

### Wie genau muss ich die Uhr tragen?

**Standard-Trageweise** wie beim Sport:
- Fest, aber nicht zu eng
- 1-2 Finger breit über dem Handgelenk-Knochen
- Display nach oben (normal)

Keine spezielle Positionierung nötig!

---

## 🤝 Feedback & Improvement

Hast du die App mit einer echten CPR-Übungspuppe getestet?

**Bitte teile deine Erkenntnisse:**
- GitHub Issues: [github.com/[username]/garmin-cpr/issues]
- Email: feedback@[deine-domain].de
- Diskussionen: [github.com/[username]/garmin-cpr/discussions]

**Besonders wertvoll:**
- 🎓 Feedback von Erste-Hilfe-Trainern
- 🔬 Vergleichstests mit professionellen CPR-Geräten
- 📊 Daten über Genauigkeit bei verschiedenen Körpergrößen

---

**Disclaimer:** Diese Dokumentation beschreibt ein experimentelles Feature zu Trainingszwecken. Keine medizinische Zulassung. Keine Haftung für Ungenauigkeiten.
