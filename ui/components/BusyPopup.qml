import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt.labs.lottieqt 1.0

Popup {
    id: busy_popup
    modal: true
    focus: true
    closePolicy: Popup.CloseOnPressOutside

    property var busy
    property var subtext
    
    function play() {
        success_animation.play()
    }

    function stop() {
        success_animation.stop()
    }
    
    anchors.centerIn: parent
    width: parent.width - 30
    height: parent.height - 550

    background: Rectangle {
         color: "#1c1b1f"
    }

    BusyIndicator {
        anchors.centerIn: parent
        visible: busy_popup.busy ? true : false
    }


    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40

        visible: busy_popup.busy ? false : true

        LottieAnimation {
            id: success_animation
            loops: 1
            quality: LottieAnimation.HighQuality
            source: "qrc:/EventTracker/animations/login_success.json"
            autoPlay: false
            Layout.alignment: Qt.AlignCenter
        }
        Label {
            text: busy_popup.subtext
            font.family: "Segoe UI"
            color: "white"
            font.pixelSize: 20
            font.bold: true
        }
    }
}
