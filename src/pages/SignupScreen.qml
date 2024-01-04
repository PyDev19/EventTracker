import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Page {
    Button {
        text: "Back"
        font.pixelSize: 20
        font.family: "Segoe UI"
        anchors.top: parent.top
        anchors.topMargin: 10
        onClicked: {
            main.pop(); 
        }
        flat: true
        icon.source: "data:image/svg+xml;utf8," + encodeURIComponent(
                '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">' +
                '<path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>' +
                '</svg>')
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
                id: _email_field
                placeholderText: "Email"
                Material.foreground: "#FFF"
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
                Material.foreground: "#FFF"
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
                Material.foreground: "#FFF"
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
                Material.foreground: "#FFF"
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
                text: "Sign up"
                Material.background: Material.Green
                font.pixelSize: 20
                font.family: "Segoe UI"
                Layout.alignment: Qt.AlignCenter
                onClicked: {
                    if (_password_field.text == confirm_password.text) {
                        auth.sign_up(_email_field.text, _password_field.text);
                    } 
                }
            }
        }
    }

    Connections {
        target: auth
        
        function onSignupSuccess() {
            main.pop();
        }
    }
}
