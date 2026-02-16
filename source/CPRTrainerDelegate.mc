using Toybox.WatchUi;

/**
 * CPRTrainerDelegate - Behandelt Benutzereingaben
 */
class CPRTrainerDelegate extends WatchUi.BehaviorDelegate {

    private var _view;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    // Handle SELECT button press (Start/Stop)
    function onSelect() {
        var view = WatchUi.View.getActiveView();
        if (view instanceof CPRTrainerView) {
            view.toggleCPR();
        }
        return true;
    }

    // Handle MENU button (kann später für Einstellungen genutzt werden)
    function onMenu() {
        return false;
    }

    // Handle BACK button (Stop und Exit)
    function onBack() {
        var view = WatchUi.View.getActiveView();
        if (view instanceof CPRTrainerView) {
            view.stopCPR();
        }
        System.exit();
        return true;
    }
}
