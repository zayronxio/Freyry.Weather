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

    Components.WeatherData {
        id: weatherData
    }

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground | PlasmaCore.Types.ConfigurableBackground
    preferredRepresentation: compactRepresentation

    property bool boldfonts: Plasmoid.configuration.fontBoldWeather
    property string temperatureUnit: Plasmoid.configuration.temperatureUnit
    property string sizeFontConfg: Plasmoid.configuration.sizeFontPanel

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
