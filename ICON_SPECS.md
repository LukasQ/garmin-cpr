# Icon Design Specifications

## Technical Requirements

### File Specifications
- **Dimensions:** 80×80 px
- **Format:** PNG-24 with alpha channel
- **Color Space:** sRGB
- **Bit Depth:** 32-bit (24-bit RGB + 8-bit alpha)
- **Filename:** `launcher_icon.png`
- **Location:** `resources/drawables/`

### Display Requirements
- Must be legible at 40×40 px (50% scale)
- Works on both light and dark backgrounds
- High contrast for visibility
- No fine details that disappear when scaled

## Design Guidelines

### Safe Area
- **Outer margin:** 5 px from edge (recommended)
- **Effective canvas:** 70×70 px center area
- Keep critical elements within safe area

### Color Palette (Suggested)

#### Medical/Emergency Theme
```
Primary:   #DC3545 (Red - Emergency)
Secondary: #2ECC71 (Green - Life/Success)
Accent:    #FFFFFF (White - Clean)
Background: Transparent or #000000 (Black)
```

#### Contrast Requirements
- Minimum contrast ratio: 4.5:1
- Text/icons: Light on dark or dark on light
- Test on both backgrounds

### Design Concepts

#### Concept 1: Heart + Pulse
```
Base:  Red circle (#DC3545) - 70×70 px
Icon:  White heart - 40×45 px
Line:  Green pulse wave across center - 2 px stroke
Style: Flat, minimalist
```

#### Concept 2: Compression Symbol
```
Base:  Circular gradient (red to dark red)
Icon:  Two hands/arrows pressing down
Style: Simple geometric shapes
```

#### Concept 3: Medical Cross + Heart
```
Base:  Red background
Icon:  Simplified medical cross with heart center
Style: Bold, high contrast
```

## Illustrator Setup

### Artboard
```
Width:  80 px
Height: 80 px
Units:  Pixels
Color:  RGB
PPI:    72
```

### Export Settings
```
File → Export → Export for Screens

Format:         PNG
Scale:          1x (80×80 px)
                2x (160×160 px) - optional for preview
Color Space:    sRGB
Transparency:   Yes
Interlace:      No
Optimization:   Enabled
```

### Grid Setup (Optional)
```
Preferences → Guides & Grid
Gridline every: 10 px
Subdivisions:   2
Snap to Grid:   Enable while designing
```

## Vector Template (SVG Source)

Save your source file as:
- `resources/drawables/launcher_icon.svg` (source)
- `resources/drawables/launcher_icon.png` (export)

Keep SVG for future edits.

## Testing

### Quick Test
```bash
# Place PNG in resources/drawables/
# Build and check in simulator
monkeyc -o bin/test.prg -f monkey.jungle -y developer_key.der -d fenix7
connectiq
```

### Visual Tests
- [ ] Clear at 80×80 px
- [ ] Recognizable at 40×40 px
- [ ] Works on white background
- [ ] Works on black background
- [ ] No pixelation or artifacts
- [ ] Centered and balanced

## Reference Assets

### Current Assets to Replace
```
resources/drawables/
├── launcher_icon.png     ← Your design here (required)
└── launcher_icon.svg     ← Source file (optional)
```

### File Size
- Target: < 10 KB
- Maximum: 20 KB
- Typical: 5-8 KB for simple icon

## Design Tips

### DO
- ✅ High contrast colors
- ✅ Simple, bold shapes
- ✅ Recognizable medical theme
- ✅ Test at small sizes

### DON'T
- ❌ Gradients (if possible)
- ❌ Fine lines < 2 px
- ❌ Complex details
- ❌ Low contrast combinations

## Approval Checklist

Before committing:
- [ ] 80×80 px PNG with transparency
- [ ] File size < 20 KB
- [ ] Saved in `resources/drawables/`
- [ ] Looks good at 40×40 px
- [ ] Works on light/dark backgrounds
- [ ] Aligns with CPR/medical theme

---

**That's it. Design something awesome.** 🎨
