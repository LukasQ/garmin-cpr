# App Icon Erstellen

Das Launcher Icon ist das erste, was Nutzer von deiner App sehen. Hier ist eine Anleitung zum Erstellen eines professionellen Icons.

## Anforderungen

- **Größe:** 80x80 Pixel (PNG)
- **Format:** PNG mit Transparenz
- **Design:** Einfach, klar erkennbar, auch bei 40x40 Pixel
- **Farben:** Kontrastreiche Farben

## Design-Vorschlag für CPR Trainer

### Konzept 1: Herz mit Puls
```
- Rotes Herz-Symbol
- Weiße oder grüne Puls-Linie durch die Mitte
- Schwarzer oder transparenter Hintergrund
```

### Konzept 2: Hände auf Herz
```
- Zwei weiße Hände (symbolisch)
- Rotes Herz in der Mitte
- Grüner Kreis als Hintergrund
```

### Konzept 3: CPR Rhythmus
```
- Runder Kreis mit 30 kleinen Punkten
- 2 größere Punkte für Beatmungen
- Rot-grünes Farbschema
```

## Online Icon-Generatoren (Kostenlos)

### 1. Canva (Empfohlen für Anfänger)
1. Gehe zu https://www.canva.com
2. Wähle "Custom Size" → 80x80 px
3. Suche nach "Heart" oder "Medical" Icons
4. Füge Text "CPR" hinzu (optional)
5. Download als PNG

### 2. Figma (Empfohlen für Designer)
1. Gehe zu https://www.figma.com
2. Erstelle neues Design 80x80 px
3. Nutze Vector Tools für präzise Shapes
4. Export als PNG 2x (160x160) → Scale down to 80x80

### 3. GIMP (Kostenlos, Open Source)
1. Download GIMP: https://www.gimp.org
2. Neue Datei: 80x80 px
3. Zeichne oder importiere Icons
4. Export als PNG

### 4. AI-generiert (Schnellste Methode)
```
Prompt für DALL-E, Midjourney oder Stable Diffusion:
"Simple minimalist app icon, red heart with white pulse line,
medical CPR symbol, flat design, 80x80 pixels, clean, professional"
```

## Icon mit Code generieren (Python)

Falls du ein einfaches Icon programmatisch erstellen möchtest:

```python
from PIL import Image, ImageDraw

# Erstelle 80x80 Bild
img = Image.new('RGBA', (80, 80), (0, 0, 0, 0))
draw = ImageDraw.Draw(img)

# Roter Kreis als Hintergrund
draw.ellipse([5, 5, 75, 75], fill=(220, 53, 69, 255))

# Weißes Herz (vereinfacht)
heart_points = [
    (40, 25), (35, 20), (30, 20), (25, 25), (25, 30), (40, 50),
    (55, 30), (55, 25), (50, 20), (45, 20), (40, 25)
]
draw.polygon(heart_points, fill=(255, 255, 255, 255))

# Speichern
img.save('launcher_icon.png')
print("Icon erstellt: launcher_icon.png")
```

## Einfaches Placeholder-Icon

Für den Anfang kannst du auch ein simples Text-Icon verwenden:

```python
from PIL import Image, ImageDraw, ImageFont

img = Image.new('RGBA', (80, 80), (220, 53, 69, 255))
draw = ImageDraw.Draw(img)

# Text "CPR"
try:
    font = ImageFont.truetype("arial.ttf", 24)
except:
    font = ImageFont.load_default()

draw.text((40, 40), "CPR", fill=(255, 255, 255, 255),
          font=font, anchor="mm")

img.save('launcher_icon.png')
```

## Icon in Projekt einbinden

1. Speichere das Icon als `launcher_icon.png`
2. Kopiere es nach: `resources/drawables/`
3. Stelle sicher, dass es in `drawables.xml` referenziert ist:
   ```xml
   <bitmap id="LauncherIcon" filename="launcher_icon.png" />
   ```

## Icon testen

### Im Simulator
```bash
connectiq
# Lade deine App → Icon erscheint in der App-Liste
```

### Auf der Uhr
Übertrage die App und checke:
- Ist das Icon klar erkennbar?
- Funktioniert es auf hellem und dunklem Hintergrund?
- Ist es auch bei kleiner Größe noch erkennbar?

## Design-Tipps

### ✅ DO's
- **Einfach halten** - Weniger ist mehr
- **Kontrastreiche Farben** - Gut lesbar
- **Symbolisch** - Nutze universelle Symbole (Herz = medizinisch)
- **Konsistent** - Passt zum App-Design

### ❌ DON'Ts
- Kein Text (außer 2-3 Buchstaben)
- Keine komplexen Details
- Keine niedrige Auflösung
- Keine rechtlich geschützten Symbole

## Rechtliche Hinweise

### Sichere Icon-Quellen
- **Creative Commons:** https://thenounproject.com (mit Lizenz beachten!)
- **Font Awesome:** https://fontawesome.com (Free Icons)
- **Material Icons:** https://fonts.google.com/icons
- **Flaticon:** https://www.flaticon.com (Free mit Attribution)

### Achtung bei:
- ❌ Google Bilder (meist urheberrechtlich geschützt)
- ❌ Offizielle Medizin-Logos (Rotes Kreuz, etc.)
- ❌ Marken-Symbole (Nike-Check, etc.)

## Finale Checkliste

Bevor du veröffentlichst:
- [ ] Icon ist 80x80 Pixel
- [ ] Format ist PNG mit Transparenz
- [ ] Icon ist auch bei 40x40 erkennbar
- [ ] Funktioniert auf hellem und dunklem Hintergrund
- [ ] Keine Urheberrechtsverletzungen
- [ ] Passt zum App-Thema (CPR/Medizin)
- [ ] Professionelles Aussehen

## Professionelle Hilfe

Falls du kein Icon selbst erstellen möchtest:

**Freelancer-Plattformen:**
- Fiverr: €5-20 für einfaches Icon
- Upwork: €20-50 für professionelles Icon
- 99designs: Icon-Contest ab €100

**Typische Anfrage:**
```
Ich brauche ein 80x80 Pixel App Icon für eine CPR-Trainer App.
Das Icon sollte ein Herz mit Puls-Linie zeigen, medizinisch wirken,
und in rot-grün-weißen Farben gehalten sein. Bitte als PNG mit Transparenz.
```

---

Viel Erfolg beim Icon-Design! 🎨
