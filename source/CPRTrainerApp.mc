using Toybox.Application;
using Toybox.WatchUi;

/**
 * CPR Trainer App
 * Hilft bei der Herzdruckmassage mit visuellem und akustischem Feedback
 * Basiert auf ERC Guidelines 2025
 */
class CPRTrainerApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [new CPRTrainerView(), new CPRTrainerDelegate()];
    }

}
