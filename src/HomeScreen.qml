import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
    Column {
        anchors.centerIn: parent
        spacing: 100

        Label {
            id: app_title
            text: "Event Tracker"
            font.bold: true
            font.pixelSize: 50
            font.family: "Segoe UI"
            color: "#8aca8d"
        }

        Column {
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter
            Button {
                id: sign_up
                text: "Sign Up"
                highlighted: true
                contentItem: Text {
                    text: sign_up.text
                    horizontalAlignment : Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                    font.pixelSize: 25
                    font.family: "Segoe UI"
                }
            }

            Button {
                id: login
                text: "Login"
                width: sign_up.width
                highlighted: true
                contentItem: Text {
                    text: login.text
                    horizontalAlignment : Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                    font.pixelSize: 25
                    font.family: "Segoe UI"
                }
            }
        }
    }
}
