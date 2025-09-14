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
    property int sectionHeight: 170
    property bool widgetExpanded: root.expanded

    Layout.preferredWidth: sectionWidth + Kirigami.Units.gridUnit
    Layout.preferredHeight: sectionHeight + Kirigami.Units.gridUnit
    clip: false
    Layout.minimumWidth: sectionWidth + Kirigami.Units.gridUnit
    Layout.minimumHeight: sectionHeight + Kirigami.Units.gridUnit
    Layout.maximumWidth: minimumWidth
    Layout.maximumHeight: minimumHeight

    property var sections: [mainWeatherView, hourlyForecastView, dailyForecastView]
    property int currentIndex: 0

    onWidgetExpandedChanged: {
        if (!widgetExpanded) {
            currentIndex = 0 // when the widget disappears, it returns to its original state, and when you open it again, the first section will be shown
        }
    }
    Header {
        id: header
        height: Kirigami.Units.gridUnit
        width: parent.width
        headerText: weatherData.city // name of city

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

