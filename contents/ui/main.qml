import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 1.15
import "components" as Components
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore

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

    compactRepresentation: CompactRepresentation {

    }
    fullRepresentation: FullRepresentation {
        width: sectionWidth + Kirigami.Units.gridUnit
        height: sectionHeight + Kirigami.Units.gridUnit
        Layout.minimumWidth: sectionWidth + Kirigami.Units.gridUnit
        Layout.minimumHeight: sectionHeight + Kirigami.Units.gridUnit
        Layout.maximumWidth: minimumWidth
        Layout.maximumHeight: minimumHeight
    }
}
