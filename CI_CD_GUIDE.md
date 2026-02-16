# CI/CD Pipeline Guide für CPR Trainer

## 🚀 Übersicht

Dieses Projekt nutzt **GitHub Actions** für kontinuierliche Integration und Deployment. Alle Pipelines sind **kostenlos** für öffentliche Repositories.

## 📋 Verfügbare Workflows

### 1. **Build and Test** (`build.yml`)
- **Trigger:** Push auf `main` oder `develop`, Pull Requests
- **Läuft:** ~5-8 Minuten
- **Kosten:** Kostenlos (öffentliches Repo)

**Was es macht:**
- ✅ Kompiliert die App für Fenix 7, Venu 2, Forerunner 955
- ✅ Führt Code-Quality-Checks durch
- ✅ Validiert Dokumentation
- ✅ Lädt Build-Artifacts hoch (30 Tage)

**Artifacts:**
- `cpr-trainer-builds` - .prg Dateien zum Testen

### 2. **Release** (`release.yml`)
- **Trigger:** Git Tags mit Pattern `v*.*.*` (z.B. `v1.0.0`)
- **Läuft:** ~10-15 Minuten
- **Kosten:** Kostenlos (öffentliches Repo)

**Was es macht:**
- ✅ Kompiliert für ALLE 17+ unterstützten Geräte
- ✅ Erstellt universelle .iq Datei für Connect IQ Store
- ✅ Erstellt ZIP mit allen .prg Dateien
- ✅ Generiert SHA256 Checksums
- ✅ Erstellt automatisch GitHub Release mit Release Notes

**Release Assets:**
- `CPRTrainer-vX.X.X.iq` - Für Connect IQ Store
- `CPRTrainer-AllDevices-vX.X.X.zip` - Alle .prg Dateien
- `BUILD_INFO.txt` - Build-Informationen
- `SHA256SUMS.txt` - Checksums

### 3. **Pull Request Checks** (`pr-check.yml`)
- **Trigger:** Pull Requests (opened, synchronize, reopened)
- **Läuft:** ~3-5 Minuten
- **Kosten:** Kostenlos

**Was es macht:**
- ✅ Validiert PR-Titel (Conventional Commits)
- ✅ Prüft auf DISCLAIMER.md Änderungen (warnt)
- ✅ Checkt manifest.xml Version-Bump
- ✅ Sucht nach neuen TODO/FIXME Kommentaren
- ✅ Prüft auf große Dateien (>1MB)
- ✅ Validiert geänderte Monkey C Dateien
- ✅ Test-Build für Fenix 7

### 4. **Nightly Build** (`nightly.yml`)
- **Trigger:** Täglich um 2 Uhr UTC, oder manuell
- **Läuft:** ~15-20 Minuten
- **Kosten:** Kostenlos

**Was es macht:**
- ✅ Kompiliert für ALLE unterstützten Geräte
- ✅ Erstellt Kompatibilitäts-Report
- ✅ Lädt Build-Logs hoch (7 Tage)
- ✅ Warnt bei Fehlern

---

## 🎯 Wie verwende ich die Pipelines?

### Als Entwickler (während der Entwicklung)

#### 1. Feature entwickeln
```bash
git checkout -b feature/my-new-feature
# ... Code schreiben ...
git add .
git commit -m "feat(sensor): add xyz"
git push origin feature/my-new-feature
```

#### 2. Pull Request erstellen
- Gehe zu GitHub → Pull Requests → New Pull Request
- Fülle das PR-Template aus
- **Automatisch:** PR-Checks laufen los
- Warte auf grünes Häkchen ✅

#### 3. Nach Merge in main
- **Automatisch:** Build & Test Workflow läuft
- **Automatisch:** Artifacts werden erstellt

### Als Maintainer (Release erstellen)

#### 1. Version vorbereiten
```bash
# Version in manifest.xml erhöhen
vim manifest.xml
# Ändere: version="1.0.0" → version="1.0.1"

git add manifest.xml
git commit -m "chore: bump version to 1.0.1"
git push origin main
```

#### 2. Git Tag erstellen
```bash
git tag v1.0.1
git push origin v1.0.1
```

#### 3. Release-Workflow startet automatisch
- Kompiliert für alle Geräte
- Erstellt .iq und .zip Dateien
- Erstellt GitHub Release
- Release Notes werden generiert

#### 4. Release veröffentlichen
- Gehe zu GitHub → Releases
- Release ist automatisch erstellt (Draft = false)
- Bei Bedarf Release Notes anpassen
- Download-Links sind verfügbar

---

## 💰 Kosten-Übersicht

### GitHub Actions Free Tier (Öffentliches Repo)

| Feature | Free Tier | Dein Verbrauch |
|---------|-----------|----------------|
| **Minuten/Monat** | Unbegrenzt | ~100-200 min/Monat |
| **Concurrent Jobs** | 20 | Max. 4 (workflows) |
| **Storage** | 500 MB | ~10-20 MB |
| **Artifact Retention** | 90 Tage | 7-30 Tage konfiguriert |

**Kosten:** **0 EUR / Monat** 🎉

### Für Private Repositories

Wenn du das Repo privat machst:

| Account Typ | Free Minutes | Preis danach |
|-------------|--------------|--------------|
| **Free** | 2000 min/Monat | $0.008/min |
| **Pro** | 3000 min/Monat | $0.008/min |
| **Team** | 3000 min/Monat | $0.008/min |

**Dein Verbrauch:** ~100-200 min/Monat
→ **Passt locker in Free Tier!** ✅

---

## 🔧 Konfiguration anpassen

### Connect IQ SDK Version ändern

In allen Workflow-Dateien:
```yaml
# Ändere diese URL:
wget https://developer.garmin.com/downloads/connect-iq/sdks/connectiq-sdk-lin-7.2.1.zip

# Zu neuerer Version:
wget https://developer.garmin.com/downloads/connect-iq/sdks/connectiq-sdk-lin-7.3.0.zip
```

Und Cache-Key aktualisieren:
```yaml
key: ${{ runner.os }}-connectiq-sdk-7.3.0  # Version anpassen
```

### Artifact Retention ändern

```yaml
- uses: actions/upload-artifact@v3
  with:
    retention-days: 30  # Ändere: 1-90 Tage
```

### Nightly Build Zeit ändern

```yaml
schedule:
  - cron: '0 2 * * *'  # Format: Minute Stunde Tag Monat Wochentag
  # Beispiele:
  # '0 0 * * *'  = Mitternacht UTC
  # '0 12 * * *' = 12 Uhr Mittags UTC
  # '0 0 * * 1'  = Jeden Montag Mitternacht
```

### Weitere Geräte hinzufügen

In `release.yml`:
```yaml
DEVICES=(
  "fenix7:Fenix7"
  "dein_neues_geraet:NeuesGeraet"  # Hinzufügen
)
```

---

## 🐛 Troubleshooting

### Build schlägt fehl: "monkeyc: command not found"

**Problem:** SDK nicht korrekt installiert

**Lösung:**
```yaml
# Prüfe SDK-Download-URL
# Manchmal ändert Garmin die URLs
# Aktuellste URL von developer.garmin.com holen
```

### Release wird nicht erstellt

**Problem:** Git Tag nicht korrekt

**Lösung:**
```bash
# Tag muss mit 'v' beginnen und Semantic Versioning folgen
git tag v1.0.0  # ✅ Korrekt
git tag 1.0.0   # ❌ Falsch (fehlt 'v')
git tag release-1.0.0  # ❌ Falsch (wrong pattern)
```

### Cache wird nicht genutzt

**Problem:** Cache-Key hat sich geändert

**Lösung:**
```bash
# Lösche alte Caches manuell:
# GitHub Repo → Actions → Caches → Delete Cache

# Oder warte 7 Tage (automatische Löschung)
```

### Artifact Upload schlägt fehl

**Problem:** Zu groß oder zu viele Dateien

**Lösung:**
```yaml
# Filtere genauer:
path: bin/*.prg  # Nur .prg Dateien
# Statt:
path: bin/       # Alle Dateien
```

### Workflow läuft nicht

**Problem:** Workflow-Datei Syntax-Fehler

**Lösung:**
```bash
# Validiere YAML Syntax online:
# https://www.yamllint.com/

# Oder lokal:
pip install yamllint
yamllint .github/workflows/build.yml
```

---

## 📊 Monitoring & Logs

### Workflow-Status sehen

1. Gehe zu: GitHub Repo → **Actions** Tab
2. Sieh alle Workflow-Runs
3. Klicke auf einen Run für Details
4. Klicke auf einen Job für Logs

### Artifacts herunterladen

1. Gehe zu: Actions → Workflow Run
2. Scrolle runter zu "Artifacts"
3. Klicke auf Artifact-Name zum Download

### Badges hinzufügen

In README.md:
```markdown
![Build Status](https://github.com/[username]/garmin-cpr/workflows/Build%20and%20Test/badge.svg)
![Release](https://github.com/[username]/garmin-cpr/workflows/Create%20Release/badge.svg)
```

---

## 🔐 Secrets & Permissions

### Benötigte Secrets

**Keine!** 🎉

Alle Workflows nutzen nur:
- `GITHUB_TOKEN` - Automatisch verfügbar
- Öffentliche URLs (SDK Download)

### Permissions

Workflows haben nur Lese-Zugriff, außer:
- `release.yml` - Benötigt `contents: write` für Releases

---

## 🚀 Best Practices

### 1. Branch Protection

Schütze `main` Branch:
```
Settings → Branches → Add Rule
- Branch name pattern: main
- ☑ Require status checks to pass before merging
  ☑ build / Build Connect IQ App
  ☑ pr-validation / Validate Pull Request
- ☑ Require branches to be up to date before merging
```

### 2. Conventional Commits

Nutze semantische Commit-Messages:
```bash
feat(sensor): add heart rate monitoring
fix(ui): correct compression counter display
docs: update installation guide
chore: bump version to 1.0.1
```

### 3. Semantic Versioning

Folge SemVer für Tags:
- `v1.0.0` → Major.Minor.Patch
- `v1.0.1` → Patch (Bugfix)
- `v1.1.0` → Minor (neues Feature)
- `v2.0.0` → Major (Breaking Change)

### 4. Changelog pflegen

Erstelle `CHANGELOG.md`:
```markdown
# Changelog

## [1.0.1] - 2026-02-16
### Fixed
- Drucktiefe-Sensor Kalibrierung verbessert

## [1.0.0] - 2026-02-15
### Added
- Initial Release
- 110 BPM Rhythmus
- Drucktiefe-Messung
```

---

## 📞 Support

Bei Problemen:
1. 📖 Lies diese Anleitung
2. 🔍 Prüfe [GitHub Actions Logs](https://github.com/[username]/garmin-cpr/actions)
3. 🐛 Erstelle ein [Issue](https://github.com/[username]/garmin-cpr/issues)
4. 💬 Frage in [Discussions](https://github.com/[username]/garmin-cpr/discussions)

---

## 📚 Weitere Ressourcen

- [GitHub Actions Dokumentation](https://docs.github.com/en/actions)
- [Garmin Connect IQ Developer Guide](https://developer.garmin.com/connect-iq/)
- [YAML Syntax](https://yaml.org/)
- [Semantic Versioning](https://semver.org/)

---

**Happy Building! 🚀**
