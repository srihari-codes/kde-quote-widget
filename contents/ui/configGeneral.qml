import QtQuick 2.15
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Dialogs 1.1 as QtDialogs
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrols 2.0 as KQuickControls
import org.kde.plasma.core 2.0 as PlasmaCore

Kirigami.FormLayout {
    id: page

    property font cfg_quoteFont
    property alias cfg_textColor: colorButton.color
    property alias cfg_intervalSeconds: intervalSpinBox.value
    property alias cfg_quotesText: quotesEditor.text

    function loadDefaultQuotes() {
        if (quotesEditor.text.length > 0) {
            return
        }

        var request = new XMLHttpRequest()
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE
                    && (request.status === 0 || request.status === 200)) {
                quotesEditor.text = request.responseText.trim()
            }
        }
        request.open("GET", Qt.resolvedUrl("../data/quotes.txt"))
        request.send()
    }

    Component.onCompleted: loadDefaultQuotes()

    RowLayout {
        Kirigami.FormData.label: i18n("Font:")
        Layout.fillWidth: true

        QQC2.TextField {
            readOnly: true
            text: cfg_quoteFont.family + " " + cfg_quoteFont.pointSize + "pt"
            font: cfg_quoteFont
            Layout.fillWidth: true
        }

        QQC2.Button {
            icon.name: "document-edit"
            text: i18n("Choose...")
            onClicked: fontDialog.open()
        }
    }

    KQuickControls.ColorButton {
        id: colorButton
        Kirigami.FormData.label: i18n("Text color:")
    }

    QQC2.SpinBox {
        id: intervalSpinBox
        Kirigami.FormData.label: i18n("Change quote every:")
        from: 5
        to: 86400
        editable: true
        textFromValue: function(value) { return value + " seconds" }
        valueFromText: function(text) {
            var value = parseInt(text)
            return isNaN(value) ? 60 : value
        }
    }

    QQC2.Label {
        Kirigami.FormData.label: i18n("Quotes:")
        text: i18n("One quote per line. Empty lines and lines starting with # are ignored.")
        wrapMode: Text.WordWrap
        Layout.fillWidth: true
    }

    QQC2.ScrollView {
        Layout.fillWidth: true
        Layout.preferredHeight: 230

        QQC2.TextArea {
            id: quotesEditor
            placeholderText: i18n("Enter one quote per line")
            selectByMouse: true
            wrapMode: TextEdit.Wrap
        }
    }

    QtDialogs.FontDialog {
        id: fontDialog
        title: i18n("Select quote font")
        font: !cfg_quoteFont || cfg_quoteFont.family === ""
              ? PlasmaCore.Theme.defaultFont : cfg_quoteFont
        onAccepted: cfg_quoteFont = font
    }
}
