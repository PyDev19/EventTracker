import QtQuick
import QtQuick.Controls.Material

Page {
    header: Rectangle {
        id: page_header
        height: 50
        color: Material.color(Material.LightGreen)
        
        Text {
            anchors.centerIn: parent
            text: "Events Near You"
            font.pixelSize: 20
            color: "white"
            font.family: "Segoe UI"
            font.bold: true
        }

        Button {
            text: "Sign Out"
            anchors.right: parent.right
            anchors.rightMargin: 0
            flat: true
            font.pixelSize: 12
            font.family: "Segoe UI"
            font.bold: true
            onClicked: {
                auth.sign_out()
            }
        }
    }

    Connections {
        target: auth
        function onSignoutSuccess() {
            main.pop()
        }
    }
}
