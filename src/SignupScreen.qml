import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Page {
    Button {
        text: "Back"
        font.pixelSize: 20
        font.family: "Segoe UI"
        flat: true
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40

        Label {
            text: "Event Tracker"
            font.bold: true
            font.pixelSize: 50
            font.family: "Segoe UI"
            color: "#8aca8d"
            Layout.alignment: Qt.AlignCenter
        }

        ColumnLayout {
            spacing: 20

            Layout.maximumWidth: parent.width - 5
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            Label {
                text: "Sign Up"
                font.bold: true
                font.pixelSize: 30
                font.family: "Segoe UI"
                color: "#8aca8d"
                Layout.alignment: Qt.AlignRight
            }

            TextField {
                id: email_field
                placeholderText: "Email"
                Material.foreground: Material.White
                Material.accent: Material.LightGreen
                padding: 10
                font.pixelSize: 20
                font.family: "Segoe UI"
                Layout.maximumWidth: parent.width - 5
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
            }

            TextField {
                id: _username_field
                placeholderText: "Username"
                Material.foreground: Material.White
                Material.accent: Material.LightGreen
                padding: 10
                font.pixelSize: 20
                font.family: "Segoe UI"
                Layout.maximumWidth: parent.width - 5
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
            }

            TextField {
                id: _password_field
                placeholderText: "Password"
                Material.foreground: Material.White
                Material.accent: Material.LightGreen
                padding: 10
                echoMode: TextInput.Password
                font.pixelSize: 20
                font.family: "Segoe UI"
                Layout.maximumWidth: parent.width - 5
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
            }

            TextField {
                id: confirm_password
                placeholderText: "Confirm Password"
                Material.foreground: Material.White
                Material.accent: Material.LightGreen
                padding: 10
                echoMode: TextInput.Password
                font.pixelSize: 20
                font.family: "Segoe UI"
                Layout.maximumWidth: parent.width - 5
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
            }

            Button {
                text: "Sign Up"
                Material.background: Material.Green
                font.pixelSize: 20
                font.family: "Segoe UI"
                Layout.alignment: Qt.AlignCenter
            }
        }
    }
}
