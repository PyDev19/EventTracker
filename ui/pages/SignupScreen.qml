import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import "../components/"

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
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        spacing: 50

        Image {
            source: "qrc:/EventTracker/images/icon_128x128.png"
            Layout.alignment: Qt.AlignCenter
        }

        Label {
            text: "Event Tracker"
            font.bold: true
            font.pixelSize: 50
            font.family: "Segoe UI"
            color: "#8aca8d"
            Layout.alignment: Qt.AlignCenter
        }

        ColumnLayout {
            spacing: 15

            Layout.maximumWidth: parent.width - 30
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

            CredentialsField {
                id: _email_field
                placeholderText: "Email"
            }

            CredentialsField {
                id: _username_field
                placeholderText: "Username"
            }

            CredentialsField {
                id: _password_field
                placeholderText: "Password"
                echoMode: TextInput.Password
            }

            CredentialsField {
                id: confirm_password
                placeholderText: "Confirm Password"
                echoMode: TextInput.Password
            }

            ErrorLabel {
                id: error_label
            }

            Button {
                text: "Sign up"
                Material.background: Material.Green
                font.pixelSize: 20
                font.family: "Segoe UI"
                Layout.alignment: Qt.AlignCenter
                onClicked: {
                    if (_email_field.text === "") {
                        error_label.text = "Email is required"
                    } else if (_username_field.text === "") {
                        error_label.text = "Username is required"
                    } else if (_password_field.text === "") {
                        error_label.text = "Password is required"
                    } else if (_password_field.text != confirm_password.text) {
                        error_label.text = "Passwords do not match"
                    } else {
                        auth.sign_up(_email_field.text, _password_field.text, _username_field.text);
                    }
                }
            }
        }
    }

    Connections {
        target: auth
        
        function onSignupSuccess() {
            main.pop();
            warning_label.text = ""
        }
    }
}
