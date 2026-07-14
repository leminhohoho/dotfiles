import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

Item {
    id: islandBar
    implicitHeight: 32
    implicitWidth: 200

    PopupWindow {
        id: islandPopup
        visible: true
        anchor.item: islandBar
        anchor.rect.x: islandBar.width / 2
        anchor.rect.y: 0
        anchor.gravity: Qt.BottomEdge
        height: islandBar.height * 5
        width: islandBar.width * 2
        color: "transparent"

        mask: Region { 
            item: frame 
        }

        Rectangle {
            id: frame
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 6
            color: "#1D2021"
            
            property bool isExpanded: false
            
            width: isExpanded ? islandBar.width * 2 : islandBar.width
            height: isExpanded ? islandBar.height * 5 : islandBar.height
            
            Behavior on width {
                NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
            }
            Behavior on height {
                NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
            }

            MouseArea {
                id: frameMouseArea
                anchors.fill: parent
                hoverEnabled: true
                
                onEntered: {
                    collapseTimer.stop()
                    shrinkTimer.stop()
                    frame.isExpanded = true
                    expandCompleteTimer.start()
                }
                
                onExited: {
                    if (!frameMouseArea.containsMouse && !media.active) {
                        collapseTimer.start()
                    }
                }
            }

            Timer {
                id: expandCompleteTimer
                interval: 300 
                onTriggered: {
                    if (frame.isExpanded && frameMouseArea.containsMouse) {
                        media.opacity = 1
                    }
                }
            }

            Timer {
                id: collapseTimer
                interval: 100
                onTriggered: {
                    if (!frameMouseArea.containsMouse) {
                        media.opacity = 0
                        shrinkTimer.start()
                    }
                }
            }
            
            Timer {
                id: shrinkTimer
                interval: 300
                onTriggered: {
                    if (!frameMouseArea.containsMouse && media.opacity === 0) {
                        frame.isExpanded = false
                    }
                }
            }
            
            RowLayout {
                anchors.fill: parent
                Clock {
                    id: clock
                    anchors.centerIn: parent
                    opacity: frame.isExpanded ? 0 : 1

                    Behavior on opacity {
                        NumberAnimation { 
                            duration: 300
                            easing.type: Easing.InOutQuad 
                        }
                    }
                }

                Visualizer {
                    id: visualizer
                    anchors.right: parent.right 
                    opacity: frame.isExpanded ? 0 : 1
                    scale: 0.3

                    Behavior on opacity {
                        NumberAnimation { 
                            duration: 300
                            easing.type: Easing.InOutQuad 
                        }
                    }
                }
            }

            Media {
                id: media
                anchors.centerIn: parent
                opacity: 0
                imgHeight: islandBar.height * 5 - 24
                ambientBackgroundWidth: islandBar.width * 2
                
                Behavior on opacity {
                    NumberAnimation { 
                        duration: 300
                        easing.type: Easing.InOutQuad 
                    }
                }
            }
        }
    }
}
