import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami

Item {
    id: root


    QtObject {
        id: units
        property var wind
        property var temperatureUnit
    }
    QtObject {
        id: coordinates
        property var latitude
        property var longitude
    }

    FindCity {
        id: findCity
        onReady: {
            coordinates.longitud = findCity.selectedLatitude
            coordinates.longitud = findCity.selectedLongitude
        }
    }

    property var windUnits: ["km/h","mph", "m/s"]
    property var temperatureUnits: ["Celsius","Fahrenheit"]

    property alias cfg_windUnit: units.wind
    property alias cfg_temperatureUnit: units.temperatureUnit
    property alias cfg_ipLocation: ipLocation.checked
    property alias cfg_longitudeLocalized: coordinates.longitude
    property alias cfg_latitudeLocalized: coordinates.longitude

    property var allMetrics: [
        { name: "Wind Speed", selected: false },
        { name: "Feels Like", selected: false },
        { name: "UV Index", selected: false },
        { name: "Humidity", selected: false },
        { name: "Pressure", selected: false },
        { name: "Rain", selected: false },
        { name: "Sunrise", selected: false },
        { name: "Sunset", selected: false }
    ]

    Kirigami.FormLayout {
        width: root.width
        CheckBox {
            id: ipLocation
            Kirigami.FormData.label: i18n("Use Location of your ip")
        }
        Item {
            Kirigami.FormData.isSection: true
        }
        Button {
            text: i18n("Search Coordinates")
            onClicked: {
                findCity.open()
            }
        }
        TextField {
            Kirigami.FormData.label: i18n("Latitude")
            text: findCity.selectedLatitude === 0 ? "unknown" : findCity.selectedLatitude
            enabled: false
            visible: !ipLocation.checked
        }
        TextField {
            Kirigami.FormData.label: i18n("Longitude")
            text: findCity.selectedLongitude === 0 ? "unknown" : findCity.selectedLongitude
            enabled: false
            visible: !ipLocation.checked
        }

        Item {
            Kirigami.FormData.isSection: true
        }
        ComboBox {
            id: windUnitBox
            Kirigami.FormData.label: i18n("Wind Unit:")
            model: windUnits

            onActivated: units.wind = currentValue
            Component.onCompleted: currentIndex = indexOf(units.wind)
        }

        ComboBox {
            id: unitsBox
            Kirigami.FormData.label: i18n("Temperature Unit:")
            model: temperatureUnits
            onActivated: units.temperatureUnit = currentValue
            Component.onCompleted: currentIndex = indexOf(units.temperatureUnit)
        }
        Item {
            Kirigami.FormData.isSection: true
        }
        Item {
            Kirigami.FormData.isSection: true
        }
        Kirigami.Heading {
            width: parent.width
            font.weight: Font.DemiBold
            text:i18n("Weather Metrics")
            anchors.horizontalCenter: parent.horizontalCenter
            color: Kirigami.Theme.textColor
            level: 4
        }
        Repeater {
            model: metricsLayout.allMetrics
            CheckBox {
                text: modelData.name
                checked: modelData.selected
                Kirigami.FormData.label: i18n(allMetrics.name)
                onClicked: {
                    if (checked) {
                        if (metricsLayout.currentSelected < metricsLayout.maxSelected) {
                            metricsLayout.currentSelected++
                            modelData.selected = true
                        } else {
                            // Limitar selección a 6
                            checked = false
                        }
                    } else {
                        metricsLayout.currentSelected--
                        modelData.selected = false
                    }
                }
            }
        }
    }
}
