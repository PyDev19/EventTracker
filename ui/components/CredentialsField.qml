import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

TextField {
    id: credentials_field
    
    property var password: false
    property var password_visible: password ? true : false
    property var visible_icon: "qrc:/EventTracker/images/password_visible.svg" 
    property var hidden_icon: "qrc:/EventTracker/images/password_hidden.svg"
    
    Material.foreground: "#FFF"
    Material.accent: Material.LightGreen
    padding: 10
    font.pixelSize: 20
    font.family: "Segoe UI"
    echoMode: password_visible ? TextInput.Password : TextInput.Normal
    
    Layout.alignment: Qt.AlignCenter
    Layout.maximumWidth: parent.width - 10
    Layout.fillWidth: true

    RoundButton {
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.verticalCenter: parent.verticalCenter
        focusPolicy: Qt.NoFocus
        onClicked: {
            credentials_field.password_visible = !credentials_field.password_visible
        }
        flat: true
        visible: credentials_field.password && credentials_field.text.length > 0

        Image {
            anchors.centerIn: parent
            source: credentials_field.password_visible ? credentials_field.visible_icon : credentials_field.hidden_icon
        }
    }
}
