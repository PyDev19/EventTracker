// import QtQuick
import QtQuick.Controls.Material
import "./pages/"

ApplicationWindow {
    id: window
    visible: true

    // width: 340
    // height: 625

    Material.theme: Material.Dark
    Material.accent: Material.Green

    StackView {
        id: main
        anchors.fill: parent
        anchors.centerIn: parent

        initialItem: LoginScreen {}
    }
}
