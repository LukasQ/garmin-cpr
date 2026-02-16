using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Timer;
using Toybox.Attention;
using Toybox.Sensor;

/**
 * CPRTrainerView - Hauptansicht der CPR Trainer App
 * Zeigt visuelles Feedback im Uhrzeigersinn und gibt akustische Signale
 * Misst Drucktiefe über Beschleunigungssensor
 */
class CPRTrainerView extends WatchUi.View {

    // CPR Parameter nach ERC Guidelines
    const COMPRESSIONS_PER_MINUTE = 110; // Optimal zwischen 100-120
    const COMPRESSIONS_BEFORE_BREATH = 30;
    const BREATH_COUNT = 2;
    const COMPRESSION_INTERVAL = 60000 / COMPRESSIONS_PER_MINUTE; // ms pro Kompression

    // Drucktiefe-Parameter (5-6 cm ist optimal)
    const MIN_DEPTH_THRESHOLD = 1.5; // g-force (entspricht ca. 5 cm)
    const OPTIMAL_DEPTH_THRESHOLD = 2.0; // g-force (entspricht ca. 5.5 cm)
    const MAX_DEPTH_THRESHOLD = 2.5; // g-force (entspricht ca. 6 cm)

    // Status
    private var _isRunning = false;
    private var _compressionCount = 0;
    private var _cycleCount = 0;
    private var _timer;
    private var _currentAngle = 0; // Aktueller Winkel für Animation
    private var _pulsePhase = 0; // 0 = drücken, 1 = entlasten

    // Sensor-Daten
    private var _sensorEnabled = false;
    private var _accelerometerData = null;
    private var _lastAccelZ = 0.0;
    private var _maxAccelZ = 0.0; // Maximale Z-Beschleunigung in aktueller Kompression
    private var _compressionDepth = 0.0; // Geschätzte Drucktiefe
    private var _depthQuality = 0; // 0=zu flach, 1=gut, 2=zu tief

    // Statistiken
    private var _goodCompressions = 0;
    private var _shallowCompressions = 0;
    private var _deepCompressions = 0;

    function initialize() {
        View.initialize();
        _timer = new Timer.Timer();

        // Beschleunigungssensor aktivieren
        if (Sensor has :enableSensorEvents) {
            try {
                Sensor.setEnabledSensors([Sensor.SENSOR_ACCEL]);
                Sensor.enableSensorEvents(method(:onSensorData));
                _sensorEnabled = true;
            } catch (e) {
                System.println("Sensor nicht verfügbar: " + e.getErrorMessage());
                _sensorEnabled = false;
            }
        }
    }

    // Callback für Beschleunigungssensor-Daten
    function onSensorData(sensorInfo) {
        if (sensorInfo has :accel && sensorInfo.accel != null) {
            _accelerometerData = sensorInfo.accel;

            // Z-Achse ist die vertikale Bewegung (wichtig für Drucktiefe)
            var accelZ = _accelerometerData[2];
            if (accelZ != null) {
                _lastAccelZ = accelZ;

                // Tracke maximale Beschleunigung während Druckphase
                if (_isRunning && _pulsePhase == 0) {
                    var absAccelZ = accelZ.abs();
                    if (absAccelZ > _maxAccelZ) {
                        _maxAccelZ = absAccelZ;
                    }
                }
            }
        }
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Clear screen
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;
        var radius = (width < height ? width : height) / 2 - 20;

        // Zeichne äußeren Kreis
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(3);
        dc.drawCircle(centerX, centerY, radius);

        if (_isRunning) {
            // Zeichne Fortschritt im Uhrzeigersinn (Start oben, 12 Uhr)
            var progressAngle = (_compressionCount % COMPRESSIONS_BEFORE_BREATH) * 360.0 / COMPRESSIONS_BEFORE_BREATH;

            // Zeichne Fortschrittsarc (grün während Kompression)
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
            dc.setPenWidth(8);
            drawArc(dc, centerX, centerY, radius - 10, -90, -90 + progressAngle);

            // Zeichne Pulsindikator
            var pulseRadius = _pulsePhase == 0 ? radius - 30 : radius - 40;
            var pulseColor = _pulsePhase == 0 ? Graphics.COLOR_RED : Graphics.COLOR_DK_RED;
            dc.setColor(pulseColor, Graphics.COLOR_TRANSPARENT);
            dc.fillCircle(centerX, centerY, pulseRadius);

            // Zeige Kompressionszähler
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            var countText = (_compressionCount % COMPRESSIONS_BEFORE_BREATH).toString() + "/" + COMPRESSIONS_BEFORE_BREATH;
            dc.drawText(centerX, centerY - 40, Graphics.FONT_LARGE, countText, Graphics.TEXT_JUSTIFY_CENTER);

            // Zeige Drucktiefe-Feedback (wenn Sensor verfügbar)
            if (_sensorEnabled && _compressionCount > 0) {
                var depthText = "";
                var depthColor = Graphics.COLOR_WHITE;

                if (_depthQuality == 0) {
                    depthText = "▼ Tiefer!";
                    depthColor = Graphics.COLOR_ORANGE;
                } else if (_depthQuality == 1) {
                    depthText = "✓ Gut!";
                    depthColor = Graphics.COLOR_GREEN;
                } else if (_depthQuality == 2) {
                    depthText = "▲ Flacher!";
                    depthColor = Graphics.COLOR_YELLOW;
                }

                dc.setColor(depthColor, Graphics.COLOR_TRANSPARENT);
                dc.drawText(centerX, centerY - 10, Graphics.FONT_SMALL, depthText, Graphics.TEXT_JUSTIFY_CENTER);

                // Zeige Statistik klein unten
                var stats = _goodCompressions + "/" + _compressionCount;
                dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
                dc.drawText(centerX, centerY + 10, Graphics.FONT_TINY, stats + " gut", Graphics.TEXT_JUSTIFY_CENTER);
            }

            // Zeige Zyklen
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX, centerY + 30, Graphics.FONT_SMALL, "Zyklus: " + _cycleCount, Graphics.TEXT_JUSTIFY_CENTER);

            // Zeige Beatmungsphase
            if (_compressionCount % (COMPRESSIONS_BEFORE_BREATH + BREATH_COUNT) >= COMPRESSIONS_BEFORE_BREATH) {
                dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
                dc.drawText(centerX, centerY + 55, Graphics.FONT_MEDIUM, "BEATMEN!", Graphics.TEXT_JUSTIFY_CENTER);
            }
        } else {
            // Start-Screen
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX, centerY - 60, Graphics.FONT_LARGE, "CPR Trainer", Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(centerX, centerY - 25, Graphics.FONT_SMALL, "110/min", Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(centerX, centerY - 5, Graphics.FONT_SMALL, "30:2 Rhythmus", Graphics.TEXT_JUSTIFY_CENTER);

            // Sensor-Status anzeigen
            if (_sensorEnabled) {
                dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
                dc.drawText(centerX, centerY + 20, Graphics.FONT_TINY, "✓ Drucktiefe-Sensor", Graphics.TEXT_JUSTIFY_CENTER);
            } else {
                dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
                dc.drawText(centerX, centerY + 20, Graphics.FONT_TINY, "⚠ Nur Rhythmus", Graphics.TEXT_JUSTIFY_CENTER);
            }

            // Disclaimer
            dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX, centerY + 40, Graphics.FONT_XTINY, "Nur für geschulte", Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(centerX, centerY + 50, Graphics.FONT_XTINY, "Ersthelfer!", Graphics.TEXT_JUSTIFY_CENTER);

            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX, centerY + 70, Graphics.FONT_TINY, "START drücken", Graphics.TEXT_JUSTIFY_CENTER);
        }
    }

    // Hilfsfunktion zum Zeichnen eines Bogens
    private function drawArc(dc, centerX, centerY, radius, startAngle, endAngle) {
        var numPoints = 30;
        var angleStep = (endAngle - startAngle) / numPoints;

        for (var i = 0; i < numPoints; i++) {
            var angle1 = startAngle + i * angleStep;
            var angle2 = startAngle + (i + 1) * angleStep;

            var x1 = centerX + radius * Math.cos(angle1 * Math.PI / 180);
            var y1 = centerY + radius * Math.sin(angle1 * Math.PI / 180);
            var x2 = centerX + radius * Math.cos(angle2 * Math.PI / 180);
            var y2 = centerY + radius * Math.sin(angle2 * Math.PI / 180);

            dc.drawLine(x1, y1, x2, y2);
        }
    }

    // Called when this View is removed from the screen
    function onHide() {
        stopCPR();
    }

    // Start CPR Training
    function startCPR() {
        _isRunning = true;
        _compressionCount = 0;
        _cycleCount = 1;
        _pulsePhase = 0;
        _maxAccelZ = 0.0;
        _compressionDepth = 0.0;
        _depthQuality = 0;
        _goodCompressions = 0;
        _shallowCompressions = 0;
        _deepCompressions = 0;
        _timer.start(method(:onTimerTick), COMPRESSION_INTERVAL, true);
    }

    // Stop CPR Training
    function stopCPR() {
        _isRunning = false;
        _timer.stop();
    }

    // Toggle CPR on/off
    function toggleCPR() {
        if (_isRunning) {
            stopCPR();
        } else {
            startCPR();
        }
        WatchUi.requestUpdate();
    }

    // Timer callback für jede Kompression
    function onTimerTick() {
        var compressionInCycle = _compressionCount % (COMPRESSIONS_BEFORE_BREATH + BREATH_COUNT);

        if (compressionInCycle < COMPRESSIONS_BEFORE_BREATH) {
            // Kompressionsphase
            _pulsePhase = (_pulsePhase + 1) % 2;

            // Feedback geben
            if (_pulsePhase == 0) {
                // Druckphase beginnt - Reset für neue Messung
                _maxAccelZ = 0.0;

                // Vibration und Ton
                if (Attention has :vibrate) {
                    var vibeData = [
                        new Attention.VibeProfile(50, 100)
                    ];
                    Attention.vibrate(vibeData);
                }

                if (Attention has :playTone) {
                    Attention.playTone(Attention.TONE_BEEP);
                }
            }

            if (_pulsePhase == 1) {
                // Entlastungsphase - Analysiere Drucktiefe der letzten Kompression
                _compressionCount++;

                if (_sensorEnabled) {
                    // Bewerte die Drucktiefe basierend auf maximaler Beschleunigung
                    _compressionDepth = _maxAccelZ;

                    if (_compressionDepth < MIN_DEPTH_THRESHOLD) {
                        // Zu flach
                        _depthQuality = 0;
                        _shallowCompressions++;

                        // Zusätzliches haptisches Feedback: Kurze Vibration
                        if (Attention has :vibrate) {
                            var vibeData = [
                                new Attention.VibeProfile(30, 50)
                            ];
                            Attention.vibrate(vibeData);
                        }

                    } else if (_compressionDepth > MAX_DEPTH_THRESHOLD) {
                        // Zu tief
                        _depthQuality = 2;
                        _deepCompressions++;

                        // Feedback: Doppel-Vibration
                        if (Attention has :vibrate) {
                            var vibeData = [
                                new Attention.VibeProfile(30, 50),
                                new Attention.VibeProfile(30, 50)
                            ];
                            Attention.vibrate(vibeData);
                        }

                    } else {
                        // Optimal!
                        _depthQuality = 1;
                        _goodCompressions++;

                        // Feedback: Bestätigungs-Ton
                        if (Attention has :playTone && _compressionCount % 5 == 0) {
                            // Alle 5 guten Kompressionen ein Success-Ton
                            Attention.playTone(Attention.TONE_SUCCESS);
                        }
                    }
                }
            }
        } else {
            // Beatmungsphase
            _compressionCount++;

            // Nach 2 Beatmungen neuer Zyklus
            if (compressionInCycle == COMPRESSIONS_BEFORE_BREATH + BREATH_COUNT - 1) {
                _cycleCount++;

                // Längere Vibration für Zyklusende
                if (Attention has :vibrate) {
                    var vibeData = [
                        new Attention.VibeProfile(100, 300)
                    ];
                    Attention.vibrate(vibeData);
                }
            }
        }

        WatchUi.requestUpdate();
    }
}
