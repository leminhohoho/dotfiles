import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

Row {
    id: visualizer
    spacing: 4
    visible: player.canPlay
    Layout.alignment: Qt.AlignHCenter

    function setColor (source) {
        if (source == "spotify") {
            return "#8EC07C"
        } else {
            return "#8EC07C"
        }
    }
    
    property var player: Mpris.players.values[0]
    property int barCount: 6
    property color barColor: setColor(player.identity)
    property int barWidth: 4
    property int maxBarHeight: 30
    property int animationSpeed: 40
    
    // Pause animation when music is not playing
    property bool isAnimating: player && player.playbackState === MprisPlaybackState.Playing
    
    Repeater {
        model: visualizer.barCount
        
        Item {
            width: visualizer.barWidth
            height: visualizer.maxBarHeight
            anchors.verticalCenter: parent.verticalCenter
            
            Rectangle {
                id: bar
                width: parent.width
                height: visualizer.maxBarHeight * 0.3
                radius: 2
                color: visualizer.barColor
                anchors.centerIn: parent
                
                property real phase: index * (Math.PI * 2 / visualizer.barCount)
                property real time: 0
                
                function updateHeight() {
                    var value = (Math.sin(phase + time) + 1) / 2
                    height = visualizer.maxBarHeight * (0.3 + value * 0.7)
                }
                
                Timer {
                    interval: visualizer.animationSpeed
                    repeat: true
                    running: visualizer.isAnimating  // Only run when playing
                    onTriggered: {
                        bar.time += 0.2
                        bar.updateHeight()
                    }
                }
            }
        }
    }
}
