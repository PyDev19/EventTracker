import QtQuick
import QtQml
import QtQuick.Controls.Material
import QtQuick.Layouts
import "../components/"

Page {
    id: login_screen
    BusyPopup {
        id: login_popup

        property var username
        subtext: "Welcome " + username + "!" 
        busy: true

        onClosed: {
            if (!busy) {
                login_timer.stop();
                main.push(Qt.resolvedUrl("HomeScreen.qml"));
            }
        }
    }

    Timer {
        id: login_timer
        interval : 3000
        onTriggered: {
            login_popup.close();
        }
    }

    function login_error() {
        login_popup.busy = true;
        login_popup.close();
        login_popup.stop();
        login_timer.stop();
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
            spacing: 20

            Layout.maximumWidth: parent.width - 30
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            Label {
                text: "Login"
                font.bold: true
                font.pixelSize: 30
                font.family: "Segoe UI"
                color: "#8aca8d"
                Layout.alignment: Qt.AlignLeft
            }

            CredentialsField {
                id: email_field
                placeholderText: "Email"
                Layout.maximumWidth: parent.width - 5
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
            }

            CredentialsField {
                id: password_field
                placeholderText: "Password"
                password: true
                Layout.maximumWidth: parent.width - 5
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
            }


            ColumnLayout {
                spacing: 0
                
                Layout.maximumWidth: parent.width
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
                
                ErrorLabel {
                    id: error_label
                }

                Button {
                    id: login_button
                    text: "Login"
                    Material.background: Material.Green
                    font.pixelSize: 20
                    font.family: "Segoe UI"
                    Layout.alignment: Qt.AlignCenter
                    onClicked: {
                        if (email_field.text === "") {
                            error_label.text = "Email is required";
                        } else if (password_field.text === "") {
                            error_label.text = "Password is required";
                        } else {
                            auth.login(email_field.text, password_field.text);
                            login_popup.busy = true;
                            login_popup.open();
                        }
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
                        email_field.text = ""
                        password_field.text = ""
                        main.push(Qt.resolvedUrl("SignUpScreen.qml"));
                    }
                }
            }
        }
    }

    Connections {
        target: auth

        function onLoginSuccess(username) {
            login_popup.busy = false;
            login_popup.username = username;
            login_popup.play();
            login_timer.start();
            email_field.text = ""
            password_field.text = ""
            error_label.text = ""
        }

        function onWrongCredentials() {
            login_screen.login_error()
            error_label.text = "Email or Password is incorrect" 
        }

        function onUserDoesNotExist() {
            login_screen.login_error()
            error_label.text = "User does not exist"
        }

        function onUserDisabled() {
            login_screen.login_error()
            error_label.text = "User does not exist"
        }
    }
}
