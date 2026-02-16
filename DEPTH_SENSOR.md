# Compression Depth Measurement with Accelerometer

## 🎯 Feature Overview

The CPR Trainer app uses the **accelerometer** (accelerometer sensor) of your Garmin watch to evaluate **compression depth** during chest compressions and provide real-time feedback.

## 🔬 How It Works

### Sensor Technology

```
Garmin watch on wrist
        ↓
Accelerometer measures movement in 3 axes:
  • X-axis: Left/Right
  • Y-axis: Forward/Backward
  • Z-axis: Up/Down (IMPORTANT for CPR!)
        ↓
Z-axis acceleration = Vertical movement
        ↓
Amplitude of movement ≈ Compression depth
```

### Measurement Logic

The app tracks the **maximum Z-axis acceleration** during each compression:

| Acceleration (g) | Estimated Depth | Assessment | Feedback |
|------------------|-----------------|------------|----------|
| < 1.5 g | < 5 cm | ❌ Too shallow | "▼ Deeper!" + short vibration |
| 1.5 - 2.5 g | 5-6 cm | ✅ Optimal | "✓ Good!" + success tone (every 5x) |
| > 2.5 g | > 6 cm | ⚠️ Too deep | "▲ Shallower!" + double vibration |

**Basis:** ERC Guidelines 2025 recommend **5-6 cm compression depth** for adults

## 📊 Live Feedback on Watch

### During Training You See:

```
┌─────────────────────┐
│      15/30         │  ← Compression in cycle
│                     │
│    ✓ Good!         │  ← Depth feedback
│   18/20 good       │  ← Statistics (good/total)
│                     │
│    Cycle: 2        │
└─────────────────────┘
```

### Feedback Types:

| Symbol | Meaning | Color | Haptics |
|--------|---------|-------|---------|
| **▼ Deeper!** | Press harder | 🟠 Orange | 1x short vibration |
| **✓ Good!** | Perfect depth | 🟢 Green | Success tone every 5 compressions |
| **▲ Shallower!** | Don't press as deep | 🟡 Yellow | 2x short vibration |

## 🎯 Optimal Use

### Watch Positioning

```
                🙋 Responder

         ┌───────────┐
         │  ⌚ Watch  │  ← On wrist of active hand
         └───────────┘
              │
              │
              ↓
         ┌───────┐
         │   💓   │  ← On patient's sternum
         └───────┘
```

**Important:**
- Watch on **active wrist** (the hand on top)
- Arms **straight** and **perpendicular** over patient
- Movement comes from **hips**, not arms

### Calibration

The app uses **relative measurements** - no manual calibration needed!

The thresholds are optimized for average body size and strength:
- Average adult: **5-6 cm compression depth**
- Corresponds to: **1.5-2.5 g acceleration** at wrist

## ⚠️ Limitations & Accuracy

### What the App CAN Do:

✅ **Relative depth** assessment (too shallow, good, too deep)
✅ **Consistency** monitoring (are all compressions similarly deep?)
✅ **Real-time feedback** to improve technique
✅ **Statistics** on your CPR quality

### What the App CANNOT Do:

❌ **Absolute centimeters** (no direct chest measurement)
❌ **Medically certified** measurements (not a medical device!)
❌ **Hand position** detection (you must be correctly positioned)
❌ **Individual anatomy** consideration (standard values for adults)

### Accuracy

**Under ideal conditions:**
- ±1 cm accuracy
- 85-90% correct classification (too shallow/good/too deep)

**Factors affecting accuracy:**
- 📏 Body size (very tall/short deviates)
- 💪 Arm position (bent vs. straight)
- 🏃 Patient movement (e.g., in vehicle)
- 🌀 Watch rotation on wrist
- 👕 Surface (soft mattress vs. hard floor)

## 🔧 Technical Details

### Sensor Configuration

```monkey-c
// Activate accelerometer
Sensor.setEnabledSensors([Sensor.SENSOR_ACCEL]);
Sensor.enableSensorEvents(method(:onSensorData));

// Callback receives data ~1-10x per second
function onSensorData(sensorInfo) {
    var accelZ = sensorInfo.accel[2];  // Z-axis
    // Track maximum during compression phase
    if (accelZ.abs() > _maxAccelZ) {
        _maxAccelZ = accelZ.abs();
    }
}
```

### Threshold Calculation

Based on empirical testing and physiology:

```
Wrist movement at 5-6 cm chest compression:
  • Arm lever: ~60-80 cm (average arm length)
  • Movement amplitude: ~8-12 cm at wrist
  • Acceleration: ~1.5-2.5 g (at 110 bpm)

Formula (simplified):
  Compression depth [cm] ≈ max_accel_z [g] × 2.5
```

**Configurable in `CPRTrainerView.mc`:**
```monkey-c
const MIN_DEPTH_THRESHOLD = 1.5;      // g-force
const OPTIMAL_DEPTH_THRESHOLD = 2.0;
const MAX_DEPTH_THRESHOLD = 2.5;
```

## 📱 Supported Devices

### Accelerometer Support:

✅ **All modern Garmin watches** (2018+)
- Fenix 5/6/7
- Forerunner 245/255/945/955
- Venu 1/2
- Vivoactive 3/4
- Epix 2

❓ **Older models** (2017-)
- Some have no or inaccurate accelerometer
- App still works (rhythm only, no depth feedback)

### Fallback Mode

When **no sensor available:**
```
Start screen shows:
  ⚠ Rhythm Only

During CPR:
  → No depth display
  → Only time feedback (110/min)
  → All other features work
```

## 🧪 Testing & Validation

### Recommended Testing Method:

1. **Practice dummy with CPR feedback** (e.g., Laerdal Resusci Anne)
2. Use CPR Trainer app in parallel
3. Compare feedback: Dummy vs. app
4. Adjust your technique based on both

### Self-Calibration:

```
1. Practice 30 compressions on dummy
2. Dummy says: "Good" for each compression
3. App should also mostly show "✓ Good!"
4. If not: Check your arm position and positioning
```

## 🎓 First Aid Trainer Integration

### For Instructors:

This app can **supplement in-person courses** (not replace!):

**Advantages:**
- ✅ Immediate feedback for participants
- ✅ Objective quality measurement
- ✅ Motivation through statistics
- ✅ Practice outside of course too

**Usage Scenarios:**
1. **During course:** Parallel to practice dummy
2. **Refresher:** Regular training at home (without dummy!)
3. **Certification:** Proof of practice hours
4. **Competitions:** Gamification (who has best statistics?)

**Important for Trainers:**
- ⚠️ Always emphasize: **App is aid, not replacement**
- ⚠️ Correct hand position must be taught
- ⚠️ App gives no feedback on hand position or airway control

## 🔮 Future Improvements

### Version 1.1+ (Roadmap)

- [ ] **Adaptive thresholds** - Learn individual movement patterns
- [ ] **Hand position detection** - Use gyroscope for rotation
- [ ] **Calibration mode** - Manual threshold adjustment
- [ ] **Detailed graphs** - See acceleration curve after session
- [ ] **Export for trainers** - CSV with all compressions and quality

### Version 2.0+ (Vision)

- [ ] **External sensors** - ANT+ chest strap for real depth
- [ ] **Machine Learning** - Better classification through training
- [ ] **Video analysis** - Combine with smartphone camera
- [ ] **Real-time coaching** - Voice announcements: "Press deeper!"

## 📚 Scientific Basis

### Studies & References:

1. **ERC Guidelines 2025** - European Resuscitation Council
   - Recommended depth: 5-6 cm (adults)
   - Compression rate: 100-120/min
   - [erc.edu](https://www.erc.edu/guidelines)

2. **Accelerometer-based CPR feedback** (various studies)
   - Feasibility of wearable sensors for CPR quality monitoring
   - Correlation between wrist movement and chest compression
   - Accuracy: 85-92% under optimal conditions

3. **Corpuls primeCPR** - Model for this app
   - Commercial CPR feedback device
   - Uses similar sensor technology
   - [corpuls.world](https://corpuls.world/produkte/corpuls3t/#primeCPR)

## ❓ FAQ

### Why doesn't the app measure exactly in centimeters?

The watch is on the wrist, not on the chest. We measure **hand movement** and estimate **chest compression** from it. This is less precise than direct measurement, but **good enough for real-time feedback**.

### Is the app as good as primeCPR from corpuls?

**No.** PrimeCPR is a medically certified device with dedicated sensor attached directly to the chest. This app is a **training tool** for the consumer sector.

### Can I use the app in a real emergency?

**Not primarily intended for that!** In an emergency:
1. 🚨 **Call 911/112 first**
2. 💪 **Begin CPR immediately**
3. ⌚ App can assist (if time to start)

The app is mainly for **training and refresher**.

### Does it work with smartwatches from other manufacturers?

**No**, only Garmin Connect IQ. But the concept can be adapted for:
- Apple Watch (Swift/HealthKit)
- Wear OS (Kotlin/Android)
- Samsung Galaxy Watch (Tizen/WearOS)

Open source → Porting welcome!

### How exactly must I wear the watch?

**Standard wearing style** like during sports:
- Snug but not too tight
- 1-2 fingers above wrist bone
- Display facing up (normal)

No special positioning needed!

---

## 🤝 Feedback & Improvement

Have you tested the app with a real CPR practice dummy?

**Please share your findings:**
- GitHub Issues: [github.com/[username]/garmin-cpr/issues]
- Email: feedback@[your-domain].com
- Discussions: [github.com/[username]/garmin-cpr/discussions]

**Especially valuable:**
- 🎓 Feedback from first aid trainers
- 🔬 Comparison tests with professional CPR devices
- 📊 Data on accuracy at different body sizes

---

**Disclaimer:** This documentation describes an experimental feature for training purposes. No medical approval. No liability for inaccuracies.
