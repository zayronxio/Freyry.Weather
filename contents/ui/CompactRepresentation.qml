import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore

Item {
    id: weatherWidget

    Layout.minimumWidth: widgetWidth
    Layout.minimumHeight: widgetHeight

    readonly property bool isVerticalLayout: Plasmoid.formFactor === PlasmaCore.Types.Vertical
    property bool showShortWeatherText: weatherData.currentShortTextWeather
    property bool shortWeatherTextActive: actualHeight > 34
    property int fontSize: Plasmoid.configuration.sizeFontPanel
    property int actualHeight: parent.height
    property int widgetWidth: shortWeatherTextActive ? mainTemperature.implicitWidth : mainTemperature.implicitWidth + shortWeatherLabel.width
    property int widgetHeight: isVerticalLayout ? verticalWrapper.implicitHeight : parent.height

    MouseArea {
        id: toggleMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.expanded = !root.expanded
    }

    // Horizontal Layout (default)
    RowLayout {
        id: horizontalLayout
        width: weatherIcon.width + temperatureColumn.width + weatherIcon.width * 0.3
        height: parent.height
        spacing: weatherIcon.width / 5
        visible: !isVerticalLayout

        Kirigami.Icon {
            id: weatherIcon
            width: actualHeight < 17 ? 16 : actualHeight < 24 ? 22 : 24
            height: width
            source: weatherData.currentIconWeather
            roundToIconSize: false
        }

        Column {
            id: temperatureColumn
            width: widgetWidth
            height: mainTemperature.implicitHeight
            anchors.verticalCenter: parent.verticalCenter

            Row {
                id: mainTemperatureRow
                width: temperatureLabel.implicitWidth + unitLabel.implicitWidth
                height: temperatureLabel.implicitHeight
                anchors.verticalCenter: shortWeatherTextActive ? undefined : parent.verticalCenter

                Label {
                    id: temperatureLabel
                    height: parent.height
                    width: parent.width - unitLabel.implicitWidth
                    text: weatherData.currentWeather
                    font.bold: true
                    font.pixelSize: fontSize
                    color: PlasmaCore.Theme.textColor
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }

                Label {
                    id: unitLabel
                    height: parent.height
                    width: parent.width - temperatureLabel.implicitWidth
                    text: (weatherWidget.temperatureUnit === "Celsius") ? " °C " : " °F "
                    font.bold: true
                    font.pixelSize: fontSize
                    color: PlasmaCore.Theme.textColor
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Item {
                id: shortWeatherLabelWrapper
                height: shortWeatherLabel.implicitHeight
                width: shortWeatherLabel.implicitWidth
                visible: shortWeatherTextActive && showShortWeatherText

                Label {
                    id: shortWeatherLabel
                    text: weatherData.currentShortTextWeather
                    font.pixelSize: fontSize
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }

    // Vertical Layout (for panels)
    ColumnLayout {
        id: verticalWrapper
        width: parent.width
        height: weatherIconVertical.height + temperatureVertical.implicitHeight
        spacing: 2
        visible: isVerticalLayout

        Kirigami.Icon {
            id: weatherIconVertical
            width: parent.width < 17 ? 16 : parent.width < 24 ? 22 : 24
            height: width
            source: weatherData.currentIconWeather
            anchors.left: parent.left
            anchors.right: parent.right
            roundToIconSize: false
        }

        Row {
            id: verticalTemperatureRow
            width: temperatureVertical.implicitWidth + unitVertical.implicitWidth
            height: temperatureVertical.implicitHeight
            Layout.alignment: Qt.AlignHCenter

            Label {
                id: temperatureVertical
                height: parent.height
                text: weatherData.currentTemperature
                font.bold: true
                font.pixelSize: fontSize
                color: PlasmaCore.Theme.textColor
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                id: unitVertical
                height: parent.height
                text: (weatherWidget.temperatureUnit === "Celsius") ? " °C" : " °F"
                font.bold: true
                font.pixelSize: fontSize
                color: PlasmaCore.Theme.textColor
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    Component.onCompleted: {
        width = horizontalLayout.width
    }
}


