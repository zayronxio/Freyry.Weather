import QtQuick
import org.kde.plasma.plasmoid 2.0
import org.kde.kirigami as Kirigami

Item {

    property int generalMargin: 4

    property var titles: ["Feels like", "Max/Min", "Wind", "UV", "Rain", "Sunrise"]
    property string formattTime: ""
    property var valuesMainView: []

    function updateValues() {
        var newValues = []

        if (weatherData.hourlyIsDay === 1) {
            titles[5] = "Sunrise"
            newValues.push(Qt.formatDateTime(weatherData.hourlyTimes[weatherData.hourlyIsDay.indexOf(0)], "h ap"))
        } else {
            titles[5] = "Sunset"
            newValues.push(Qt.formatDateTime(weatherData.hourlyTimes[weatherData.hourlyIsDay.indexOf(1)], "h ap"))
        }

        // valores principales
        newValues = [
            weatherData.apparentTemperature,
            weatherData.dailyWeatherMax[0] + ` | ` + weatherData.dailyWeatherMin[0],
            //weatherData.currentHumidity,
            weatherData.windSpeed,
            weatherData.currentUvIndexText,
            weatherData.dailyPrecipitationProbabilityMax[0],
            newValues[0] // Sunrise o Sunset
        ]

        valuesMainView = newValues
    }

    Connections {
        target: weatherData
        function onDataChanged() {
            updateValues()
        }
    }

    Component.onCompleted: {
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
                text: weatherData.currenWeather
                color: Kirigami.Theme.textColor
                font.pixelSize: height
            }

            Text {
                id: tempUnit
                anchors.left: parent.left
                anchors.leftMargin: currentTemp.implicitWidth + 4
                anchors.bottom: maxMin.top
                text: "°C"
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
                            text: i18n(titles[modelData])
                            horizontalAlignment: Text.AlignHCenter
                            font.weight: Font.DemiBold
                            level: 5
                        }

                        Kirigami.Heading {
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            text: valuesMainView[modelData] ? valuesMainView[modelData] : "--"
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
