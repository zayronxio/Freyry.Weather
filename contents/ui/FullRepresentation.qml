/*
 *  SPDX-FileCopyrightText: zayronxio
 *  SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick
import QtQuick.Layouts 1.15
import org.kde.plasma.plasmoid 2.0
import org.kde.kirigami as Kirigami

Item {
    id: main

    property int sectionWidth: 350
    property int sectionHeight: 100

    width: sectionWidth + Kirigami.Units.gridUnit
    height: sectionHeight + Kirigami.Units.gridUnit

    property var sections: [mainWeatherView, hourlyForecastView, dailyForecastView]
    property int currentIndex: 0

    Header {
        id: header
        height: Kirigami.Units.gridUnit
        width: parent.width
        headerText: weatherData.city

        onNext: currentIndex = (currentIndex + 1) % sections.length
        onPrev: currentIndex = (currentIndex - 1 + sections.length) % sections.length
    }
    Loader {
        width: parent.width
        height: parent.height - Kirigami.Units.gridUnit*1.5
        anchors.bottom: parent.bottom
        sourceComponent: sections[currentIndex]
    }

    Component { id: mainWeatherView;    MainView {} }
    Component { id: hourlyForecastView; HourlyForecast {} }
    Component { id: dailyForecastView;  DailyForecast {} }
}

