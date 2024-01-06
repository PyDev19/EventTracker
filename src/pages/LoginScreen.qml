import QtQuick
import QtQml
import QtQuick.Controls.Material
import QtQuick.Layouts

Page {
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
                text: "Login"
                font.bold: true
                font.pixelSize: 30
                font.family: "Segoe UI"
                color: "#8aca8d"
                Layout.alignment: Qt.AlignRight
            }

            TextField {
                id: email_field
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
                id: password_field
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

            ColumnLayout {
                spacing: 0
                
                Layout.maximumWidth: parent.width
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter

                Button {
                    id: login_button
                    text: "Login"
                    Material.background: Material.Green
                    font.pixelSize: 20
                    font.family: "Segoe UI"
                    Layout.alignment: Qt.AlignCenter
                    onClicked: {
                        auth.login(email_field.text, password_field.text);
                    }
                }

                Label {
                    text: "or"
                    font.bold: true
                    font.pixelSize: 20
                    font.family: "Segoe UI"
                    Layout.alignment: Qt.AlignCenter
                }

                Button {
                    id: new_account
                    text: "Create New Account"
                    Material.background: Material.Green
                    font.pixelSize: 20
                    font.family: "Segoe UI"
                    Layout.alignment: Qt.AlignCenter
                    onClicked: {
                        main.push(Qt.resolvedUrl("SignupScreen.qml"));
                    }
                }
            }
        }
    }

    Connections {
        target: auth

        function onLoginSuccess() {
            main.push(Qt.resolvedUrl("HomeScreen.qml"))
        }
    }
}
