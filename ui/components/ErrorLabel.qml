import QtQuick.Controls.Material
import QtQuick.Layouts

Label {
    id: error_label
    Layout.alignment: Qt.AlignCenter
    font.bold: true
    font.family: "Segoe UI"
    color: Material.color(Material.Red)
    font.pixelSize: 15
}
