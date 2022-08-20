import QtQuick 2.12
import io.thp.pyotherside 1.4

Python {
    id: python

    property bool isLoading
    signal ready()

    function loadCategory(categoryPage, pythonFunction) {
        python.isLoading = true; 
        // Maybe add a timer not to show the loading bar when the delay is less then half a second.

        python.call(pythonFunction, [], function(myData) {
            python.isLoading = false;
            pStack.push(Qt.resolvedUrl(categoryPage), { "myData": myData });
        });
    }

    Component.onCompleted: {
        addImportPath(Qt.resolvedUrl('../../src/'));

        importModule('system_info', ready());
    }

    onError: {
        print(`Python error: ${traceback}`);
        // error(i18n.tr("Unknown error. View the logs for more info."));
    }
}