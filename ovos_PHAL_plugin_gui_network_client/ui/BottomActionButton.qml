/*
 * Copyright 2018 by Aditya Mehra <aix.m@outlook.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

import QtQuick.Layouts 1.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.kirigami 2.19 as Kirigami
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import Mycroft 1.0 as Mycroft
import Qt5Compat.GraphicalEffects

Rectangle {
    id: bottomActionButtonControl
    color: Qt.lighter(Kirigami.Theme.backgroundColor, 0.8)
    property var buttonText
    property var buttonIcon
    property var buttonAction
    property string connectionName
    
    Kirigami.Icon {
        id: buttonIconItem
        anchors.top: parent.top        
        anchors.topMargin: Mycroft.Units.gridUnit / 2
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.height * 0.4
        height: width
        source: buttonIcon

        ColorOverlay {
            anchors.fill: parent
            source: buttonIconItem
            color: Kirigami.Theme.textColor
        }
    }

    Label {
        id: buttonTextItem
        anchors.top: buttonIconItem.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 4
        text: buttonText
        horizontalAlignment: Text.AlignHCenter
        color: Kirigami.Theme.textColor
    }

    MouseArea {
        anchors.fill: parent
        onClicked: (mouse)=> {
            Mycroft.SoundEffects.playClickedSound(Qt.resolvedUrl("sounds/ui_sounds_clicked.wav"))
            if (connectionName){
                console.log("Deleting " + connectionName)
                Mycroft.MycroftController.sendRequest(buttonAction, {"connection_name": connectionName})
                Mycroft.MycroftController.sendRequest("ovos.phal.gui.network.client.internal.back", {})
            } else {
                Mycroft.MycroftController.sendRequest(buttonAction, {})
            }
        }

        onPressed: (mouse)=> {
            bottomActionButtonControl.color = Qt.darker(Kirigami.Theme.backgroundColor, 0.8)
        }

        onReleased: (mouse)=> {
            bottomActionButtonControl.color = Qt.lighter(Kirigami.Theme.backgroundColor, 0.8)
        }
    }
}