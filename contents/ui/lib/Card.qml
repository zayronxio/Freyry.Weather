/*
 *    SPDX-FileCopyrightText: zayronxio
 *    SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick
import Qt5Compat.GraphicalEffects
import org.kde.plasma.plasmoid 2.0
import org.kde.kirigami as Kirigami

Item {
    id: root


    HelperCard {
        id: background
        isShadow: false
        width: parent.width
        height:  parent.height
        visible: true
    }

    HelperCard {
        id: shadow
        isShadow: true
        width: parent.width
        height:  parent.height
        visible: true
        opacity: 0.8
    }
    HelperCard {
        id: mask
        isMask: true
        height:  parent.height
        width: parent.width
        visible: false
    }
}
