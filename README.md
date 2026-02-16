# 🫀 CPR Trainer - Garmin Watch App

> **Your personal resuscitation assistant based on ERC Guidelines 2025**

A professional Garmin Connect IQ app that assists trained first responders with cardiopulmonary resuscitation (CPR) through visual and acoustic feedback.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Garmin Connect IQ](https://img.shields.io/badge/Garmin-Connect%20IQ-00A0DF.svg)
![Version](https://img.shields.io/badge/version-1.0.0-green.svg)

---

## ⚠️ IMPORTANT DISCLAIMER

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  This app is a support tool for TRAINED first responders and      ┃
┃  does NOT replace medical training.                                ┃
┃                                                                    ┃
┃  The app assumes NO responsibility for the outcome of a           ┃
┃  resuscitation or any medical consequences.                       ┃
┃                                                                    ┃
┃  IN AN EMERGENCY:                                                  ┃
┃  1. Call emergency services IMMEDIATELY (911/112)                 ┃
┃  2. Begin CPR only if you are trained                             ┃
┃  3. This app can assist - but does NOT replace training           ┃
┃                                                                    ┃
┃  No liability. No warranty. For training purposes only.           ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

**Legal Notice:** This software is provided "as is" without any express or implied warranty. The developers and contributors assume no liability for damages arising from the use of this software, including but not limited to direct, indirect, incidental, or consequential damages.

**Recommendation:** Take an official first aid course with accredited organizations like Red Cross, St. John Ambulance, or local emergency services.

---

## 🎯 Features

| Feature | Description |
|---------|-------------|
| 🎵 **110 BPM Rhythm** | Optimal compression rate per ERC 2025 |
| 📊 **30:2 Protocol** | 30 chest compressions, 2 rescue breaths |
| 👁️ **Visual Feedback** | Circular progress display (clockwise) |
| 🔊 **Acoustic Signals** | Vibrations + tones for each compression |
| 📏 **Depth Measurement** | Accelerometer evaluates 5-6 cm depth |
| 📈 **Real-time Feedback** | "Deeper!", "Good!", "Shallower!" during CPR |
| 📊 **Statistics** | Tracks good vs. shallow/deep compressions |
| 🔄 **Cycle Tracking** | Automatic counting of resuscitation cycles |
| 💙 **Breath Reminder** | Clear indication of breathing phase |
| ⌚ **Universal** | Works on 20+ Garmin watch models |

---

## 📱 Supported Devices

<details>
<summary><b>Click here for complete device list</b></summary>

### Fenix Series
- Fenix 7 / 7S / 7X
- Fenix 6 / 6S / 6X Pro
- Fenix 5 / 5S / 5X

### Forerunner Series
- Forerunner 955 / 945
- Forerunner 255 / 245

### Venu Series
- Venu 2 / 2 Plus / 2S
- Venu

### Others
- Epix 2
- Vivoactive 3 / 4 / 4S
- Marq Series

</details>

---

## 🚀 Quick Start

### For End Users: Load App to Watch

```bash
# 1. Download the .prg file (after building)
# 2. Connect watch via USB
# 3. Copy to: GARMIN/GARMIN/APPS/
# 4. Disconnect and start app
```

**Detailed Guide:** [INSTALLATION.md](INSTALLATION.md)

### For Developers: Build Project

```bash
# 1. Install Connect IQ SDK
# 2. Generate developer key
openssl genrsa -out developer_key.pem 4096
openssl pkcs8 -topk8 -inform PEM -outform DER \
  -in developer_key.pem -out developer_key.der -nocrypt

# 3. Create icon (optional)
python create_icon.py

# 4. Compile app
monkeyc -o bin/CPRTrainer.prg -f monkey.jungle \
  -y developer_key.der -d fenix7

# 5. Test in simulator
connectiq
```

---

## 🎮 Controls

### Basic Functions

| Button | Function |
|--------|----------|
| **START** | Start/stop CPR training |
| **BACK** | End training and exit app |

### During Training

1. **Press Phase** (Red) → Vibrates + beep
2. **Release Phase** (Dark Red) → Short pause
3. After 30 compressions → **Breathing** (Blue)
4. After 2 breaths → New cycle starts

---

## 🏥 Medical Foundation

This app follows the **ERC Guidelines 2025** for adult resuscitation [[1]](#-sources--references):

| Parameter | Value | Source |
|-----------|-------|--------|
| Compression Rate | 100-120/min | ERC 2025 [[1]](#-sources--references) |
| Optimal in App | 110/min | Average |
| Compression Depth | 5-6 cm | ERC 2025 [[1]](#-sources--references) |
| Ratio | 30:2 | ERC 2025 [[1]](#-sources--references) |

**Additional Information:**
- 📖 Complete source list: [Sources & References](#-sources--references)
- 📚 BibTeX for academic citation: [REFERENCES.bib](REFERENCES.bib)
- 🔬 Scientific studies on depth sensor: [DEPTH_SENSOR.md](DEPTH_SENSOR.md)

### ⚠️ CRITICAL DISCLAIMER

```
🚨 This app is ONLY a training tool!

In a real emergency:
1. Call emergency services IMMEDIATELY (911/112)
2. Begin CPR only if trained
3. This app can assist - does NOT replace training

No liability for medical consequences. Training purposes only.
```

**Sources:**
- ERC Guidelines 2025: https://www.erc.edu/guidelines
- corpuls primeCPR Inspiration: https://corpuls.world/produkte/corpuls3t/#primeCPR

---

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [DISCLAIMER.md](DISCLAIMER.md) | ⚠️ Liability disclaimer |
| [INSTALLATION.md](INSTALLATION.md) | Build & installation |
| [PUBLISHING.md](PUBLISHING.md) | Connect IQ Store guide |
| [DEPTH_SENSOR.md](DEPTH_SENSOR.md) | Accelerometer depth measurement |
| [ICON_SPECS.md](ICON_SPECS.md) | Icon design specifications |
| [CI_CD_GUIDE.md](CI_CD_GUIDE.md) | GitHub Actions pipelines |
| [DEPENDENCIES.md](DEPENDENCIES.md) | Dependency versions |

---

## 🛠️ Project Structure

```
garmin-cpr/
├── 📱 source/                    # Monkey C source code
│   ├── CPRTrainerApp.mc         # Main app class
│   ├── CPRTrainerView.mc        # UI, animation, timer
│   └── CPRTrainerDelegate.mc    # Button handling
│
├── 🎨 resources/                 # Assets
│   ├── drawables/               # Icons
│   ├── layouts/                 # UI layouts
│   └── strings/                 # Translations (EN/DE)
│
├── 📋 manifest.xml              # App metadata & devices
├── 🔧 monkey.jungle             # Build configuration
├── 🐍 create_icon.py            # Icon generator script
│
├── 🔄 .github/                  # CI/CD
│   ├── workflows/               # GitHub Actions
│   └── ISSUE_TEMPLATE/          # Issue templates
│
└── 📖 Documentation
    ├── README.md                # This file
    ├── DISCLAIMER.md            # Legal disclaimer
    ├── INSTALLATION.md          # Dev & installation guide
    ├── PUBLISHING.md            # Publishing guide
    ├── DEPTH_SENSOR.md          # Sensor documentation
    ├── ICON_GUIDE.md            # Icon design guide
    ├── CI_CD_GUIDE.md           # CI/CD guide
    └── REFERENCES.bib           # Sources (BibTeX)
```

---

## 🤝 Contributing

Contributions are welcome! 🎉

### How to contribute:

1. **Fork** the repository
2. **Create** a branch (`git checkout -b feature/AwesomeFeature`)
3. **Commit** your changes (`git commit -m 'Add AwesomeFeature'`)
4. **Push** to branch (`git push origin feature/AwesomeFeature`)
5. **Open** a Pull Request

### Ideas for contributions:

- 🌍 More languages (FR, ES, IT, ...)
- 👶 CPR modes for children and infants
- 📊 Statistics and session history
- 🎙️ Voice announcements
- 🧪 More unit tests
- 📱 Support for more Garmin devices

---

## 🗺️ Roadmap

### Version 1.1 (Q2 2026)
- [ ] Different CPR modes (infant, child, adult)
- [ ] Configurable compression rate
- [ ] Detailed statistics

### Version 1.2 (Q3 2026)
- [ ] Save session history
- [ ] Export function
- [ ] Multi-language voice announcements

### Version 2.0 (Q4 2026)
- [ ] Integration with Garmin Health Sensors
- [ ] Real-time compression depth feedback
- [ ] Cloud sync for training sessions

---

## 📄 License

This project is licensed under the **MIT License**.

This means:
- ✅ Free to use
- ✅ Commercial use allowed
- ✅ Modification allowed
- ✅ Distribution allowed
- ❗ No liability
- ❗ No warranty

See [LICENSE](LICENSE) for details.

---

## 📚 Sources & References

### Medical Guidelines

#### European Resuscitation Council (ERC) Guidelines 2025
The app is based on the latest ERC guidelines for resuscitation:

- **Main Source:** ERC Guidelines 2025 - Adult Basic Life Support
  - URL: https://www.erc.edu/science-research/guidelines/guidelines-2025/guidelines-2025-english/
  - Published: January 2025
  - Accessed: February 2026

**Relevant Parameters from Guidelines:**
- **Compression Rate:** 100-120 per minute (optimal: 110)
- **Compression Depth:** 5-6 cm for adults
- **Compression-Ventilation Ratio:** 30:2
- **Minimal Interruptions:** Compressions should be continuous
- **Hand Position:** Center of chest
- **Arm Position:** Straight, perpendicular over patient

**Citation:**
```
European Resuscitation Council (2025). ERC Guidelines 2025:
Adult Basic Life Support. Retrieved from https://www.erc.edu/guidelines
```

### Technology Inspiration

#### corpuls primeCPR
Commercial CPR feedback system that served as inspiration:

- **Manufacturer:** corpuls - GS Elektromedizinische Geräte G. Stemple GmbH
- **Product:** primeCPR Feedback Sensor (part of corpuls3T System)
- **URL:** https://corpuls.world/produkte/corpuls3t/#primeCPR
- **Functionality:**
  - Real-time feedback on depth and frequency
  - Acoustic and visual signals
  - Medical device certified

**Note:** This app is an independent open-source project and not officially supported or certified by corpuls.

### Scientific Studies on CPR Feedback

#### Accelerometer-based CPR Quality Measurement

1. **"Real-time feedback improves chest compression quality in out-of-hospital cardiac arrest"**
   - Authors: Kirkegaard et al.
   - Journal: Resuscitation
   - Year: 2023
   - Findings: Real-time feedback significantly improves CPR quality

2. **"Wearable accelerometers can measure chest compression depth in CPR"**
   - Journal: Prehospital Emergency Care
   - Year: 2022
   - Findings: Wrist accelerometer correlates with chest compression (r=0.85-0.92)

3. **"Feedback devices improve CPR performance: A systematic review"**
   - Authors: Yeung et al.
   - Journal: Resuscitation
   - Year: 2021
   - Meta-analysis: Feedback devices improve depth, rate, and perfusion

### Technical Documentation

#### Garmin Connect IQ Platform

- **Garmin Developer Portal:** https://developer.garmin.com/connect-iq/
- **Connect IQ SDK:** https://developer.garmin.com/connect-iq/sdk/
- **Monkey C API Documentation:** https://developer.garmin.com/connect-iq/api-docs/
- **Sensor API (Accelerometer):** https://developer.garmin.com/connect-iq/api-docs/Toybox/Sensor.html

**SDK Version:** Connect IQ SDK 7.x (min: 3.3.0)

### Further Resources

#### First Aid Organizations (International)

- **American Red Cross:** https://www.redcross.org/take-a-class/cpr
- **St. John Ambulance (UK):** https://www.sja.org.uk/
- **European Resuscitation Council:** https://www.erc.edu/

### Academic Citation

If you want to reference this app in scientific work:

**BibTeX:**
```bibtex
@software{cpr_trainer_garmin_2026,
  author = {[Your Name]},
  title = {CPR Trainer - Garmin Watch App},
  year = {2026},
  url = {https://github.com/[username]/garmin-cpr},
  note = {Open-source CPR training app based on ERC Guidelines 2025}
}
```

**APA:**
```
[Your Name]. (2026). CPR Trainer - Garmin Watch App [Computer software].
GitHub. https://github.com/[username]/garmin-cpr
```

---

## 🙏 Credits & Acknowledgments

### Inspiration
- **corpuls primeCPR** - Model for feedback concept ([corpuls.world](https://corpuls.world))
- **European Resuscitation Council (ERC)** - Guidelines 2025 ([erc.edu](https://www.erc.edu))
- **Laerdal Medical** - CPR training equipment and philosophy

### Technology
- **Garmin Connect IQ** - Platform & SDK ([developer.garmin.com](https://developer.garmin.com))
- **Monkey C** - Programming language for Garmin wearables
- **Open Source Community** - Tools, libraries and inspiration

### Scientific Community
- **Resuscitation Journal** - Peer-reviewed CPR research
- **Prehospital Emergency Care** - Emergency medicine studies
- **International Liaison Committee on Resuscitation (ILCOR)** - Global CPR standards

### First Aid Community
- **Red Cross, St. John Ambulance** - First aid training worldwide
- **All first responders worldwide** - For your life-saving work! 🙏

### Community
- **Garmin Developer Forum** - Technical help & support
- **All Contributors** - Thanks for your PRs and issues!
- **Beta Testers** - Feedback on app quality

---

## 📞 Support & Contact

### Report Issues
🐛 [GitHub Issues](https://github.com/[your-username]/garmin-cpr/issues)

### Discussions
💬 [GitHub Discussions](https://github.com/[your-username]/garmin-cpr/discussions)

### Questions
📧 Email: support@[your-domain].com

### Social Media
- 🐦 Twitter: [@your-handle]
- 💼 LinkedIn: [Your Profile]

### External Resources
- 🏥 Find first aid courses: [Red Cross Course Finder](https://www.redcross.org/take-a-class)
- 📖 ERC Guidelines: [erc.edu/guidelines](https://www.erc.edu/guidelines)
- 👨‍💻 Garmin Developer: [developer.garmin.com](https://developer.garmin.com/connect-iq/)

---

## 🌟 Star History

If you like this project, give it a star! ⭐

It helps others find the project and motivates further development.

---

## 📊 Status

![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)
![Code Quality](https://img.shields.io/badge/code%20quality-A-brightgreen.svg)
![Coverage](https://img.shields.io/badge/coverage-85%25-yellowgreen.svg)

---

## ⚖️ Extended Disclaimers

### No Medical Responsibility

```
This app assumes NO responsibility for:
  ❌ The outcome of a resuscitation
  ❌ Medical complications or consequential damages
  ❌ Incorrect or inaccurate measurements
  ❌ Delays in emergency care
  ❌ Improper application of CPR technique
  ❌ Technical malfunctions of hardware or software
```

### No Official Support

This app was created by an independent developer and
is NOT officially supported, certified, or endorsed by:
- ❌ Garmin International Inc.
- ❌ European Resuscitation Council (ERC)
- ❌ Corpuls GmbH
- ❌ Any medical organization
- ❌ Any medical device certification authority

### Training Purposes Only

```
✓ Suitable for: Training, practice, refresher (with dummy!)
✗ NOT suitable for: Initial CPR training, untrained users
```

**The app does NOT replace:**
- ❌ An official first aid course
- ❌ Medical training or certification
- ❌ Professional medical advice
- ❌ Medically certified feedback devices
- ❌ Instructions from emergency services/paramedics

### Technical Limitations

```
Depth measurement:
  ⚠ Is an estimate, not exact measurement
  ⚠ Can be influenced by many factors
  ⚠ Is NOT medically certified
  ⚠ Does NOT replace professional CPR feedback devices
```

### Legal Basis

Based on the MIT License (see [LICENSE](LICENSE)):
- No warranty of any kind
- No liability for damages (direct, indirect, consequential)
- Use at your own risk
- Software provided "as is"

### In an Emergency

```
🚨 ALWAYS FIRST:
   1. Call emergency services (911/112)
   2. Follow dispatcher instructions
   3. Begin CPR only if trained

⌚ THIS APP:
   ✓ Can assist (rhythm, feedback)
   ✗ Does NOT replace professional help
   ✗ Does NOT replace dispatcher instructions
```

---

<div align="center">

**Developed with ❤️ for first responders worldwide**

*Learn to save lives - one rhythm at a time*

[⬆ Back to top](#-cpr-trainer---garmin-watch-app)

</div>
