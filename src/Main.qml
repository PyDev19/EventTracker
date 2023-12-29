import QtQuick
import QtQuick.Controls.Material

ApplicationWindow {
    id: window
    visible: true

    Shortcut {
        sequence: "Shift+r"
        onActivated: {
        }
    }

    width: 340
    height: 625

    Material.theme: Material.Dark
    Material.accent: Material.Green

    StackView {
        id: main
        anchors.fill: parent
        anchors.centerIn: parent

        initialItem: SignupScreen {
            id: home_screen
        }
    }
}
