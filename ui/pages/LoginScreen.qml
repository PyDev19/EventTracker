import QtQuick
import QtQml
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt.labs.lottieqt 1.0
import "../components/"

Page {
     Popup {
        id: login_success_popup
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside

        property var busy: false
        property var username: ""
        
        anchors.centerIn: parent
        width: parent.width - 30
        height: parent.height - 550

        background: Rectangle {
             color: "#1c1b1f"
        }

        onClosed: {
            if (!busy) {
                login_success_timer.stop();
                main.push(Qt.resolvedUrl("HomeScreen.qml"));
            }
        }

        BusyIndicator {
            anchors.centerIn: parent
            visible: login_success_popup.busy ? true : false
        }
        
        ColumnLayout {
            anchors.centerIn: parent
            spacing: 40

            visible: login_success_popup.busy ? false : true

            LottieAnimation {
                id: login_success_animation
                loops: 1
                quality: LottieAnimation.HighQuality
                source: "qrc:/EventTracker/animations/login_success.json"
                autoPlay: false
                Layout.alignment: Qt.AlignCenter
            }
            Label {
                text: "Welcome " + login_success_popup.username + "!"
                font.family: "Segoe UI"
                color: "white"
                font.pixelSize: 20
                font.bold: true
            }
        }

    }

    Timer {
        id: login_success_timer
        interval : 2000
        onTriggered: {
            login_success_popup.close();
            main.push(Qt.resolvedUrl("HomeScreen.qml"));
        }
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
            }

            CredentialsField {
                id: password_field
                placeholderText: "Password"
                echoMode: TextInput.Password
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
                            login_success_popup.busy = true;
                            login_success_popup.open();
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
                        main.push(Qt.resolvedUrl("SignupScreen.qml"));
                    }
                }
            }
        }
    }

    Connections {
        target: auth

        function onLoginSuccess(username) {
            login_success_popup.busy = false;
            login_success_popup.username = username;
            login_success_animation.play();
            login_success_timer.start();
            email_field.text = ""
            password_field.text = ""
            error_label.text = ""
        }

        function onLoginWrongCredentials() {
            login_success_popup.busy = true;
            login_success_popup.close();
            login_success_animation.stop();
            login_success_timer.stop();
            error_label.text = "Email or Password is incorrect" 
        }
    }
}
