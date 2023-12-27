import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

ApplicationWindow {
    id: window
    visible: true

    width: 340
    height: 625

    Material.theme: Material.Dark
    Material.accent: Material.Green

    Rectangle {
        id: main
        color: "transparent"
        anchors.fill: parent
        anchors.centerIn: parent

        HomeScreen {
            id: home_screen
            anchors.fill: parent
        }
    }
}
