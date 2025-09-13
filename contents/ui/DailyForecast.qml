import QtQuick
import org.kde.kirigami as Kirigami

Item {

    property var iconsDaysForecast: []
    property var weatherMaxDaysForecast: []
    property var weatherMinDaysForecast: []
    property var rainDaysForecast: []
    property var timesDaysForecast: []

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
                    height: days.implicitHeight + icon.implicitHeight + max.implicitHeight + min.implicitHeight + rain.implicitHeight + spacing*3
                    anchors.centerIn: parent
                    spacing: 4
                    Kirigami.Heading {
                        id: days
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        text: timesDaysForecast[modelData +  1] === undefined ? "--" : timesDaysForecast[modelData +  1]
                        level: 5
                    }
                    Kirigami.Icon {
                        id: icon
                        source: iconsDaysForecast[modelData +  1]
                        width: 24
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: width
                    }
                    Kirigami.Heading {
                        id: max
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        text: weatherMaxDaysForecast[modelData +  1] === undefined ? "--" : weatherMaxDaysForecast[modelData +  1]
                        level: 5
                    }
                    Kirigami.Heading {
                        id: min
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        text: weatherMinDaysForecast[modelData +  1] === undefined ? "--" : weatherMinDaysForecast[modelData +  1]
                        level: 5
                    }
                    Kirigami.Heading {
                        id: rain
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        text: rainDaysForecast[modelData +  1] === undefined ? "--" : "💧" +  rainDaysForecast[modelData +  1]
                        level: 5
                    }

                }
            }
        }
    }

    Connections {
        target: weatherData
        function onDataChanged() {
            timesDaysForecast = weatherData.dailyTime.map(function(iso) {
                var dateDayTime = new Date((iso + "T00:00:00"))
                console.log(dateDayTime, iso)
                return dateDayTime.toLocaleString(Qt.locale(), "ddd");
            })

            iconsDaysForecast = weatherData.iconsDailyWather
            weatherMaxDaysForecast = weatherData.dailyWeatherMax
            weatherMinDaysForecast = weatherData.dailyWeatherMin
            rainDaysForecast = weatherData.dailyPrecipitationProbabilityMax
        }
    }


    Component.onCompleted: {
        timesDaysForecast = weatherData.dailyTime.map(function(iso) {
            var dateDayTime = new Date((iso + "T00:00:00"))
            console.log(dateDayTime, iso)
            return dateDayTime.toLocaleString(Qt.locale(), "ddd");
            console.log(timesDaysForecast)
        })

        iconsDaysForecast = weatherData.iconsDailyWather
        weatherMaxDaysForecast = weatherData.dailyWeatherMax
        weatherMinDaysForecast = weatherData.dailyWeatherMin
        rainDaysForecast = weatherData.dailyPrecipitationProbabilityMax
    }
}
