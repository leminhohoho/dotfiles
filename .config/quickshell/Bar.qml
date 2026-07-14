import "./components"
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts


PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 40
    color: "transparent"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 10

        Workspaces { anchors.left: parent.left}

        Island {anchors.horizontalCenter: parent.horizontalCenter}

        Item { Layout.fillWidth: true }
    }
}
