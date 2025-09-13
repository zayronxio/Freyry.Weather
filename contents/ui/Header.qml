import QtQuick
import org.kde.kirigami as Kirigami

Item {
    id: header
    property string headerText

    signal next
    signal prev

    Kirigami.Heading {
        width: parent.width
        font.weight: Font.DemiBold
        text: headerText ? headerText : "unknown"
        anchors.horizontalCenter: parent.horizontalCenter
        color: Kirigami.Theme.textColor
        level: 5
    }
    Kirigami.Icon {
        width: 24
        height: width
        source: "draw-arrow-back-symbolic"
        anchors.right: nextIcon.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: Kirigami.Units.gridUnit*2
        MouseArea {
            height: header.height
            width: parent.width
            onClicked: {
                prev()
            }
        }
    }
    Kirigami.Icon {
        id: nextIcon
        width: 24
        height: width
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        source: "draw-arrow-forward-symbolic"
        MouseArea {
            height: header.height
            width: parent.width
            onClicked: {
                next()
            }
        }
    }
}
