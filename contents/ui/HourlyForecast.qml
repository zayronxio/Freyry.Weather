import QtQuick
import org.kde.kirigami as Kirigami

Item {

    property var iconsHourlyForecast: []
    property var weatherHourlyForecast: []
    property var rainHourlyForecast: []
    property var timesDatesForecast

    Row {
        anchors.fill: parent
        spacing: 4
        Repeater {
            model: 5
            delegate: Item {
                width: (parent.width - (parent.spacing * 5))/6
                height: parent.height
                Column {
                    width: parent.width
                    height: hours.implicitHeight + icon.implicitHeight + temperature.implicitHeight + rain.implicitHeight + spacing*3
                    anchors.centerIn: parent
                    spacing: 12
                    Kirigami.Heading {
                        id: hours
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        text: timesDatesForecast[modelData + 1] === undefined ? "--" : timesDatesForecast[modelData + 1]
                        level: 5
                    }
                    Kirigami.Icon {
                        id: icon
                        source: iconsHourlyForecast[modelData + 1]
                        width: 24
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                    }
                    Kirigami.Heading {
                        id: temperature
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        text: weatherHourlyForecast[modelData + 1] === undefined ? "--" : weatherHourlyForecast[modelData + 1]
                        level: 5
                    }
                    Kirigami.Heading {
                        id: rain
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        text: rainHourlyForecast[modelData + 1] === undefined ? "--" : "💧" +  rainHourlyForecast[modelData + 1]
                        level: 5
                    }

                }
            }
        }
    }

    Connections {
        target: weatherData
        function onDataChanged() {
            timesDatesForecast = weatherData.hourlyTimes.map(function(iso) {
                var dateTime = new Date(iso)
                return Qt.formatDateTime(dateTime, "h ap")
            })

            iconsHourlyForecast = weatherData.iconsHourlyWeather
            weatherHourlyForecast = weatherData.hourlyWeather
            rainHourlyForecast = weatherData.hourlyPrecipitationProbability
        }
    }


    Component.onCompleted: {
        timesDatesForecast = weatherData.hourlyTimes.map(function(iso) {
            var dateTime = new Date(iso)
            return Qt.formatDateTime(dateTime, "h ap")
        })

        iconsHourlyForecast = weatherData.iconsHourlyWeather
        weatherHourlyForecast = weatherData.hourlyWeather
        rainHourlyForecast = weatherData.hourlyPrecipitationProbability
    }
}
