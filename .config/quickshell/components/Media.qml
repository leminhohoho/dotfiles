import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Services.Mpris
import Quickshell.Widgets


Rectangle {
    anchors.fill: parent
    color: "transparent"

    property var player: Mpris.players.values[0]
    property var imgHeight: 128
    property var ambientBackgroundWidth: 128
    property bool active: false
    function formatTime(seconds) {
        var minutes = Math.floor(seconds / 60)
        var seconds = Math.floor(seconds % 60)
        return minutes + ":" + (seconds < 10 ? "0" : "") + seconds
    }

    ClippingRectangle {
        height: imgHeight + 24
        width: ambientBackgroundWidth
        clip: true
        color: "transparent"
        radius: 6

        Image {
            source: (player && player.canSeek && parent.parent.opacity == 1) ? player.trackArtUrl : ""
            height: parent.height
            width: parent.width
            asynchronous: true
            cache: true
            layer.enabled: parent.opacity == 1
            layer.effect: MultiEffect {
                blurEnabled: true
                blurMax: 128
                brightness: 0.2
                blur: 1.0
                colorizationColor: "#1D2021"
                colorization: 0.8
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 12
        color: "transparent"
        RowLayout {
            anchors.fill: parent
            spacing: 12
            ClippingWrapperRectangle {
                Layout.preferredHeight: imgHeight
                Layout.preferredWidth: imgHeight
                Layout.maximumWidth: imgHeight
                Layout.maximumHeight: imgHeight
                radius: 4
                color: "transparent"
                clip: true
                Image {
                    source: ( player && parent.parent.opacity == 1 && player.canSeek ) ? player.trackArtUrl : ""
                    width: parent.width
                    height: parent.height
                    asynchronous: true
                    cache: true
                }
            }
            ColumnLayout {
                Layout.leftMargin: 4
                Layout.rightMargin: 4
                
                // Song name
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 20
                    clip: true
        
                    Text {
                    id: songText
                        text: player ? (player.trackTitle || "No song playing") : "No player found"
                        color: "#EBDBB2"
                        font.family: "JetBrainsMono Nerd Font Mono"
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignHCenter
            
                        property bool needsScrolling: width > parent.width
            
                        x: needsScrolling ? (parent.width - width) : (parent.width - width) / 2
            
                        NumberAnimation on x {
                            from: parent.width
                            to: -songText.width
                            duration: 16000
                            loops: Animation.Infinite
                            running: songText.needsScrolling && parent.visible
                        }
                    }
                }
                // Artist name
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 20
                    clip: true
        
                    Text {
                        id: songArtists
                        text: player ? (player.trackArtists || "Unkown artist") : "No player found"
                        color: "#A89984"
                        font.family: "JetBrainsMono Nerd Font Mono"
                        font.pixelSize: 11
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        bottomPadding: 32
            
                        property bool needsScrolling: width > parent.width
            
                        x: needsScrolling ? (parent.width - width) : (parent.width - width) / 2
            
                        NumberAnimation on x {
                            from: parent.width
                            to: -songArtists.width
                            duration: 16000
                            loops: Animation.Infinite
                            running: songArtists.needsScrolling && parent.visible
                        }
                    }
                }
                // Progress bar
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    Text { 
                        text:formatTime(player.position) 
                        color: "#D5C4A1"
                        font.family: "JetBrainsMono Nerd Font Mono"
                        font.pixelSize: 10
                        rightPadding: 2
                    }
                    Rectangle {
                        id: progressBar
                        Layout.fillWidth: true
                        Layout.preferredHeight: 4
                        color: "#665C54"
                        radius: 2
                        Timer {
                            id: updateDuration
                            interval: 1000
                            repeat: true
                            onTriggered: {
                                player.positionChanged()
                            }
                            running: true
                        }
                        Rectangle {
                            id: ghostProgress
                            height: parent.height
                            width: 0
                            radius: 2
                            color: "#928374"
                        }
                        Rectangle {
                            id: progress
                            height: parent.height
                            width: (player && player.length > 0) ? (player.position / player.length) * parent.width : 0
                            radius: 2
                            color: "#EBDBB2"
                        }
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
            
                            onPositionChanged: {
                                if (player && player.canSeek && player.length > 0) {
                                    var percent = mouseX / width
                                    percent = Math.max(0, Math.min(percent, 1))
                                    if (pressed) {
                                        player.position = percent * player.length
                                    }
                                    ghostProgress.width = percent * parent.width
                                }
                            }
            
                            onClicked: {
                                if (player && player.canSeek && player.length > 0) {
                                    var percent = mouseX / width
                                    percent = Math.max(0, Math.min(percent, 1))
                                    player.position = percent * player.length
                                }
                            }
                            onEntered: {
                                active = true
                                if (player && player.canSeek && player.length > 0) {
                                    var percent = mouseX / width
                                    percent = Math.max(0, Math.min(percent, 1))
                                    ghostProgress.width = percent * parent.width
                                }
                            }
                            onExited: {
                                ghostProgress.width = 0
                                active = false
                            }
                        }
                    }
                    Text { 
                        id: rightTime
                        text: formatTime(player.length) 
                        color: "#D5C4A1"
                        font.family: "JetBrainsMono Nerd Font Mono"
                        font.pixelSize: 10
                        leftPadding: 2
                    }
                }
                Item { height: 8 } // Spacer
                // buttons
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 12
                    Item {
                        Text {
                            id: prevButton
                            anchors.centerIn: parent
                            text:  ""                       
                            font.pixelSize: 20
                            color: "#BDAE93"
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: player.previous()
                                hoverEnabled: true
                                onEntered: {
                                    active = true
                                    prevButton.color = "#EBDBB2"
                                }
                                onExited: {
                                    active = false
                                    prevButton.color = "#BDAE93"
                                }
                            }
                            Behavior on color {
                                ColorAnimation { duration: 200; easing.type: Easing.InOutQuad }
                            }
                        }
                    }
                    Item { width: 16 } // Spacer
                    Item {
                        Text {
                            id: playButton
                            anchors.centerIn: parent
                            text: {
                                if (player.playbackState === MprisPlaybackState.Playing) {
                                    return ""
                                } else if (player.playbackState === MprisPlaybackState.Paused) {
                                    return ""
                                }
                            }
                            font.pixelSize: 20
                            color: "#BDAE93"
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    if (player.playbackState === MprisPlaybackState.Playing) {
                                        player.pause()
                                    } else if (player.playbackState === MprisPlaybackState.Paused) {
                                        player.play()
                                    }
                                }
                                hoverEnabled: true
                                onEntered: {
                                    active = true
                                    playButton.color = "#EBDBB2"
                                }
                                onExited: {
                                    active = false
                                    playButton.color = "#BDAE93"
                                }
                            }
                            Behavior on color {
                                ColorAnimation { duration: 200; easing.type: Easing.InOutQuad }
                            }
                        }
                    }
                    Item { width: 16 } // Spacer
                    
                    Item {
                        Text {
                            id: nextButton
                            anchors.centerIn: parent
                            text:  ""
                            font.pixelSize: 20
                            color: "#BDAE93"
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: player.next()
                                hoverEnabled: true
                                onEntered: {
                                    active = true
                                    nextButton.color = "#EBDBB2"
                                }
                                onExited: {
                                    active = false
                                    nextButton.color = "#BDAE93"
                                }
                            }
                            Behavior on color {
                                ColorAnimation { duration: 200; easing.type: Easing.InOutQuad }
                            }
                        }
                    }
                }
            }
        }
    }
}
