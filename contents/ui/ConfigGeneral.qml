import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami

Item {
    id: root


    signal configurationChanged

    QtObject {
        id: sizeFontPanel
        property var value
    }

    property alias cfg_sizeFontPanel: sizeFontPanel.value
    property alias cfg_fontBoldWeather: fontBoldWeather.checked
    property alias cfg_UseFormat12hours: amPm.checked
    property alias cfg_onlyIcon: onlyIcon.checked
    property alias cfg_showTemperatureWeather: showTemperatureWeather.checked
    property alias cfg_showConditionsWeather: showConditionsWeather.checked

    Kirigami.FormLayout {
        width: root.width

        ComboBox {
            id: size
            Kirigami.FormData.label: i18n("Font Panel Size:")
            model: ListModel {
                Component.onCompleted: {
                    for (var i = 5; i <= 48; i++) {
                        append({ "text": i })
                    }
                }
            }
            onActivated: sizeFontPanel.value = currentValue
            Component.onCompleted: currentIndex = indexOfValue(sizeFontPanel.value)
        }
        Item {
            Kirigami.FormData.isSection: true
        }
        CheckBox {
            id: onlyIcon
            Kirigami.FormData.label: i18n("Only Icon Weather")
            onCheckedChanged: {
                if (checked) {
                    showTemperatureWeather.checked = false
                    showConditionsWeather.checked = false
                }
            }
        }

        CheckBox {
            id: showTemperatureWeather
            enabled: !onlyIcon.checked
            Kirigami.FormData.label: i18n("Show temperature weather")
        }

        CheckBox {
            id: showConditionsWeather
            enabled: !onlyIcon.checked
            Kirigami.FormData.label: i18n("Show weather conditions")
        }

        CheckBox {
            id: fontBoldWeather
            Kirigami.FormData.label: i18n("Font Bold")
        }
        Item {
            Kirigami.FormData.isSection: true
        }Item {
            Kirigami.FormData.isSection: true
        }
        CheckBox {
            id: amPm
            Kirigami.FormData.label: i18n("12-hour (AM/PM)")
        }
    }
}
