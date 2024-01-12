import QtQuick.Controls.Material
import QtQuick.Layouts

TextField {
    Material.foreground: "#FFF"
    Material.accent: Material.LightGreen
    padding: 10
    font.pixelSize: 20
    font.family: "Segoe UI"
    Layout.maximumWidth: parent.width - 5
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignCenter
}
