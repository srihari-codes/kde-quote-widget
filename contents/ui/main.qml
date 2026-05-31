import QtQuick 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
    id: root

    readonly property string quotesFile: Qt.resolvedUrl("../data/quotes.txt")
    property var quotes: []
    property int currentIndex: -1
    property string currentQuote: "Loading quote..."

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation

    function useQuoteText(text) {
        var lines = text.split(/\r?\n/)
        var loadedQuotes = []
        for (var i = 0; i < lines.length; i++) {
            var quote = lines[i].trim()
            if (quote.length > 0 && quote.charAt(0) !== "#") {
                loadedQuotes.push(quote)
            }
        }

        quotes = loadedQuotes
        currentIndex = -1
        showNextQuote()
    }

    function loadQuotes() {
        var configuredQuotes = Plasmoid.configuration.quotesText
        if (configuredQuotes && configuredQuotes.trim().length > 0) {
            useQuoteText(configuredQuotes)
            return
        }

        var request = new XMLHttpRequest()
        request.onreadystatechange = function() {
            if (request.readyState !== XMLHttpRequest.DONE) {
                return
            }

            if (request.status !== 0 && request.status !== 200) {
                currentQuote = "Could not read quotes.txt"
                return
            }

            useQuoteText(request.responseText)
        }
        request.open("GET", quotesFile)
        request.send()
    }

    function showNextQuote() {
        if (quotes.length === 0) {
            currentQuote = "Add quotes in Configure Minute Quote"
            return
        }

        currentIndex = (currentIndex + 1) % quotes.length
        currentQuote = quotes[currentIndex]
    }

    Timer {
        interval: Math.max(5, Plasmoid.configuration.intervalSeconds) * 1000
        running: true
        repeat: true
        onTriggered: root.showNextQuote()
    }

    Connections {
        target: Plasmoid.configuration
        function onQuotesTextChanged() { root.loadQuotes() }
    }

    Component.onCompleted: loadQuotes()

    Plasmoid.fullRepresentation: Item {
        implicitWidth: 360
        implicitHeight: 100

        Text {
            anchors.fill: parent
            anchors.margins: 8
            text: root.currentQuote
            color: Plasmoid.configuration.textColor
            font: Plasmoid.configuration.quoteFont
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
        }
    }
}
