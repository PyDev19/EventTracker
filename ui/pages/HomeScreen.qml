import QtQuick
import QtQml
import QtQuick.Controls.Material
import "../components/"

Page {
    header: Rectangle {
        id: page_header
        height: 100
        color: Material.color(Material.Green)

        Text {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            text: "Events Near You"
            font.pixelSize: 30
            color: "white"
            font.family: "Segoe UI"
            font.bold: true
        }

        Button {
            text: "Sign Out"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 0
            flat: true
            font.pixelSize: 15
            font.family: "Segoe UI"
            font.bold: true
            onClicked: {
                auth.sign_out(false)
            }
        }
    }

    ScrollView {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 5

        BusyIndicator {
            id: events_loading
            anchors.centerIn: parent
            visible: true
        }

        ListView {
            anchors.fill: parent
            spacing: 10

            model: ListModel {
                id: event_model
            }

            Component.onCompleted: {
                var data = JSON.parse(api.get_events("Events in McKinney, TX"));
                console.log(data.events.length);
                for (var i = 0; i < data.events.length; i++) {
                    var event = data.events[i];
                    event_model.append({
                        "cityState": event.city_state,
                        "date": event.date,
                        "streetAddress": event.street_address,
                        "title": event.title
                    });
                }
                events_loading.visible = false 
            }

            delegate: EventDelegate {}
        }
    }

    Connections {
        target: auth
        function onSignoutSuccess() {
            main.pop()
        }
    }
}
