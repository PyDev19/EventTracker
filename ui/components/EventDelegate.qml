import QtQuick
import QtQuick.Controls.Material

Rectangle {
    color: "#38363e"
    height: 125
    border.color: Material.color(Material.Green)
    border.width: 5
    radius: 20

    anchors.right: parent.right
    anchors.left: parent.left
    anchors.rightMargin: 10
    anchors.leftMargin: 10

    Column {
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10

        property var location: {
            if (model.streetAddress.includes(", ")) {
                return model.streetAddress.split(", ")[1]
            } else {
                return model.streetAddress
            }
        } 

        Text {
            text: model.title
            color: "white"
            font.bold: true
            font.family: "Segoe UI"
            font.pixelSize: 15 
        }

        Text {
            text: model.date
            color: "grey"
            font.family: "Segoe UI"
            font.pixelSize: 14 
        }


        Text {
            text: parent.location
            color: "grey"
            font.family: "Segoe UI"
            font.pixelSize: 14 
        }

        Text {
            text: model.cityState
            color: "grey"
            font.family: "Segoe UI"
            font.pixelSize: 14 
        }
    }
                        
    RoundButton {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 0
        icon.source: "data:image/svg+xml;utf8," + encodeURIComponent(
                        '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">' +
                        '<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708"/>' +
                        '</svg>')
        flat: true
    }
}
