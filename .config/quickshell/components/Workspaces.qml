import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Repeater {
    model: 10

    Rectangle {
        width: 40
        height: 32

        property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

        visible: ws != null

        color: isActive ? "#689D6A" : hoverArea.containsMouse ? "#689D6A" : "#60689D6A"
        radius: 6

        Text {
            anchors.centerIn: parent
            text: index + 1
            font.family: "JetBrainsMono Nerd Font Mono"
            font.pixelSize: 12
            color: isActive ? "#EBDBB2" : hoverArea.containsMouse ? "#EBDBB2" : "#689D6A"

            Behavior on color {
                ColorAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        MouseArea {
            id: hoverArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: Hyprland.dispatch("workspace " + (index + 1))
        }
    }
}
