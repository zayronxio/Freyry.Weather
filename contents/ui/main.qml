import QtQuick
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid
import org.kde.plasma.core 2.0 as PlasmaCore
import "components" as Components
import org.kde.kirigami as Kirigami
import org.kde.ksvg as KSvg

import QtQuick
import QtQuick.Controls
import "components" as Components
import QtQuick.Layouts 1.1
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support

PlasmoidItem {
    id: root

    property var days: []

    property var valuesMainView: []
    Components.WeatherData {
        id: weatherData

        onDataChanged: {
            console.log("efcotss")
            valuesMainView = []

            valuesMainView.push(apparentTemperature);
            valuesMainView.push(windSpeed);
            valuesMainView.push(currentUvIndexText);
            valuesMainView.push(dailyPrecipitationProbabilityMax[0]);
            console.log(valuesMainView)
        }
    }

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground | PlasmaCore.Types.ConfigurableBackground
    preferredRepresentation: compactRepresentation

    property bool boldfonts: plasmoid.configuration.boldfonts
    property string temperatureUnit: plasmoid.configuration.temperatureUnit
    property string sizeFontConfg: plasmoid.configuration.sizeFontConfig

    DayOfWeekRow {
        id: daysWeek
        visible:  false
        delegate: Item {
            Component.onCompleted: {
                days.push(shortName)
            }
        }
    }

    compactRepresentation: CompactRepresentation {

    }
    fullRepresentation: FullRepresentation {
    }
}
