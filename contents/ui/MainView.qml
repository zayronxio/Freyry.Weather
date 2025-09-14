import QtQuick
import org.kde.plasma.plasmoid 2.0
import org.kde.kirigami as Kirigami
import "./js/fahrenheitFormatt.js" as FahrenheitFormatt

Item {

    property int generalMargin: 4

    property string formatTime: Plasmoid.configuration.UseFormat12hours ? "h:mm ap" : "h:mm"
    property var titles
    property string formattTime: ""
    property var valuesMainView: []

    property var listMetrics: [
    { name: "Feels Like", value: weatherData.apparentTemperature + "°"},
    { name: "UV Level", value: weatherData.currentUvIndexText },
    { name: "Humidity", value: weatherData.currentWeather + "%" },
    { name: "Max/Min", value: weatherData.dailyWeatherMax[0] + `|` + weatherData.dailyWeatherMin[0] },
    { name: "Rain", value: weatherData.dailyWeatherMax[0] + "%"},
    { name: "Wind Speed", value: windUnitsUpdate(weatherData.windSpeed, Plasmoid.configuration.windUnit) + " " + Plasmoid.configuration.windUnit},
    { name: "Sunrise / Sunset", value: sunriseOrSunset() },
    { name: "Cloud Cover", value: weatherData.cloudCover + "%"}
    ]

    function updateValues() {
        var newValues = [];
        for (var i = 0; i < titles.length; i++) {
            for (var o = 0; o < listMetrics.length; o++){
                if (titles[i] === listMetrics[o].name) {
                    newValues.push(listMetrics[o].value);
                }
            }
        }
        valuesMainView = newValues; // Reasignación dispara el binding
    }

    function sunriseOrSunset() {
        if (weatherData.hourlyIsDay[0] === 1) {
            return Qt.formatDateTime(weatherData.hourlyTimes[weatherData.hourlyIsDay.indexOf(0)], formatTime);
        } else {
            return Qt.formatDateTime(weatherData.hourlyTimes[weatherData.hourlyIsDay.indexOf(1)], formatTime);
        }
    }

    function windUnitsUpdate(kmh, x) {
        const metresPerSecond = kmh * (5 / 18);
        const milesPerHour = kmh * 0.621371;

        return x === "m/s"
        ? metresPerSecond
        : x === "mph"
        ? milesPerHour
        : kmh; // valor por defecto en km/h
    }

    Connections {
        target: weatherData
        function onDataChanged() {
            updateValues()
        }
    }

    Component.onCompleted: {
        titles = [].concat(Plasmoid.configuration.selectedMetrics)
        if (weatherData.updateWeather) {
            updateValues()
        }
    }

    Column {
        width: parent.width - generalMargin
        height: parent.height - generalMargin
        spacing: 4

        Item {
            id: currentConditionsSection
            width: parent.width
            height: 64

            Text {
                id: currentTemp
                height: currentConditionsSection.height
                text: weatherData.currentWeather
                color: Kirigami.Theme.textColor
                font.pixelSize: height
            }

            Text {
                id: tempUnit
                anchors.left: parent.left
                anchors.leftMargin: currentTemp.implicitWidth + 4
                anchors.bottom: maxMin.top
                text: temperatureUnit === "Celsius" ? "°C" : "°F"
                color: Kirigami.Theme.textColor
                verticalAlignment: Text.AlignVCenter
                height: 64 - maxMin.height -4
                font.pixelSize: currentTemp.height/2
            }

            Kirigami.Heading {
                id: maxMin// cityText
                //height: currentTemp.height - tempUnit.height
                anchors.left: parent.left
                anchors.leftMargin: currentTemp.implicitWidth + 4
                anchors.bottom: parent.bottom
                //color: weatherData.dailyWeatherMax[0] ? Kirigami.Theme.colorText : "transparent"
                text: weatherData.currentTextWeather ? weatherData.currentTextWeather : "--"
                font.weight: Font.DemiBold
                opacity: 0.6
                level: 5
            }

            Kirigami.Icon {
                id: weatherIcon
                width: parent.height
                height: width
                source: weatherData.currentIconWeather //It will be defined based on the API and the weather lib
                anchors.right: parent.right
            }
        }

        Item {
            id: detailsSection
            width: parent.width
            height: (parent.height - currentConditionsSection.height)
            Flow {
                id: detailFlow
                width: parent.width
                height: Kirigami.Units.gridUnit*4.5
                anchors.bottom: parent.bottom

                Repeater {
                    model: titles.length

                    Column {

                        width: detailFlow.width / 3
                        height: detailFlow.height/2
                        spacing: 4

                        Kirigami.Heading {
                            width: parent.width
                            text: titles[modelData] === "Sunrise / Sunset" ? weatherData.hourlyTimes[0] === 1 ? i18n("Sunset") : i18n("Sunrise") : i18n(titles[modelData])
                            horizontalAlignment: Text.AlignHCenter
                            font.weight: Font.DemiBold
                            level: 5
                        }

                        Kirigami.Heading {
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            text: valuesMainView[modelData] ? valuesMainView[modelData]  : "--"
                            font.weight: Font.DemiBold
                            opacity: 0.7
                            level: 5
                        }
                    }
                }
            }
        }
    }
}
