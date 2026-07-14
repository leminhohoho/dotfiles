import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts


Text {
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    text: Qt.formatDateTime(clock.date, "hh:mm")
    color: "#EBDBB2"
    font.family: "JetBrainsMono Nerd Font Mono"
    font.pixelSize: 12
}
