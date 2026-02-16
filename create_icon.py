#!/usr/bin/env python3
"""
Einfaches Script zum Erstellen eines Placeholder Icons für die CPR Trainer App
Benötigt: pip install pillow
"""

from PIL import Image, ImageDraw, ImageFont
import os

def create_cpr_icon():
    """Erstellt ein einfaches CPR Icon mit Herz-Symbol"""

    # Erstelle 80x80 Bild mit rotem Hintergrund
    size = 80
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # Roter Kreis als Hintergrund
    margin = 5
    draw.ellipse([margin, margin, size-margin, size-margin],
                 fill=(220, 53, 69, 255))

    # Vereinfachtes Herz zeichnen
    center_x = size // 2
    center_y = size // 2

    # Herz als Polygon
    heart_scale = 1.5
    heart = [
        (center_x, center_y - 8*heart_scale),           # Spitze oben
        (center_x - 6*heart_scale, center_y - 12*heart_scale),  # Links oben
        (center_x - 10*heart_scale, center_y - 8*heart_scale),  # Links Mitte
        (center_x - 10*heart_scale, center_y - 4*heart_scale),  # Links unten
        (center_x, center_y + 8*heart_scale),           # Spitze unten
        (center_x + 10*heart_scale, center_y - 4*heart_scale),  # Rechts unten
        (center_x + 10*heart_scale, center_y - 8*heart_scale),  # Rechts Mitte
        (center_x + 6*heart_scale, center_y - 12*heart_scale),  # Rechts oben
    ]

    draw.polygon(heart, fill=(255, 255, 255, 255))

    # Grüne Puls-Linie durch die Mitte
    line_y = center_y + 2
    draw.line([(15, line_y), (30, line_y), (35, line_y-8),
               (40, line_y+8), (45, line_y), (65, line_y)],
              fill=(46, 204, 113, 255), width=3)

    # Speichern
    output_path = 'resources/drawables/launcher_icon.png'
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    img.save(output_path)
    print(f"✓ Icon erstellt: {output_path}")

    # Auch eine Vorschau-Version für Screenshots erstellen
    preview = img.resize((240, 240), Image.Resampling.LANCZOS)
    preview_path = 'launcher_icon_preview.png'
    preview.save(preview_path)
    print(f"✓ Vorschau erstellt: {preview_path}")

def create_simple_text_icon():
    """Erstellt ein simples Text-Icon als Alternative"""

    size = 80
    img = Image.new('RGBA', (size, size), (220, 53, 69, 255))
    draw = ImageDraw.Draw(img)

    # Weißer Rand
    draw.rectangle([2, 2, size-3, size-3], outline=(255, 255, 255, 255), width=2)

    # Text "CPR"
    try:
        font = ImageFont.truetype("arial.ttf", 20)
    except:
        try:
            font = ImageFont.truetype("Arial.ttf", 20)
        except:
            font = ImageFont.load_default()

    # Zentrierter Text
    text = "CPR"
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    x = (size - text_width) // 2
    y = (size - text_height) // 2 - 5

    draw.text((x, y), text, fill=(255, 255, 255, 255), font=font)

    # Kleines Plus-Symbol unten
    plus_y = size - 20
    draw.line([(size//2, plus_y-5), (size//2, plus_y+5)],
              fill=(255, 255, 255, 255), width=2)
    draw.line([(size//2-5, plus_y), (size//2+5, plus_y)],
              fill=(255, 255, 255, 255), width=2)

    # Speichern
    output_path = 'resources/drawables/launcher_icon_text.png'
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    img.save(output_path)
    print(f"✓ Text-Icon erstellt: {output_path}")

if __name__ == "__main__":
    print("CPR Trainer Icon Generator")
    print("=" * 40)

    try:
        print("\n1. Erstelle Herz-Icon...")
        create_cpr_icon()

        print("\n2. Erstelle Text-Icon (Alternative)...")
        create_simple_text_icon()

        print("\n✅ Fertig! Icons wurden erstellt.")
        print("\nNächste Schritte:")
        print("1. Schaue dir die Icons an")
        print("2. Wähle das bessere aus")
        print("3. Benenne es zu 'launcher_icon.png' um (falls nötig)")
        print("4. Kompiliere die App neu")

    except ImportError:
        print("\n❌ Fehler: PIL/Pillow ist nicht installiert")
        print("\nInstalliere es mit:")
        print("  pip install pillow")
        print("\nOder erstelle das Icon manuell (siehe ICON_GUIDE.md)")
    except Exception as e:
        print(f"\n❌ Fehler: {e}")
        print("\nSiehe ICON_GUIDE.md für alternative Methoden")
