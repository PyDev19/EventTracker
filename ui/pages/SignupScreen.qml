import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import "../components/"
import "./signup/"

Page {
    id: signup_screen

    function signup_error() {
        signup_popup.busy = true;
        signup_popup.close();
        signup_popup.stop();
        signup_timer.stop();
    }

    property var step: 0

    BusyPopup {
        id: signup_popup

        busy: true
        subtext: "Sign Up Successfull!\nRedirecting to login..."

        onClosed: {
            if (!busy) {
                signup_timer.stop();
                main.pop();
            }
        }
    }

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
        icon.source: "qrc:/EventTracker/images/left_chevron.svg" 
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
            
            StackView {
                id: signup_stack
                Layout.alignment: Qt.AlignCenter
                Layout.maximumWidth: parent.width
                Layout.fillWidth: true
                height: stack_height

                property var stack_height: current_page.height
                
                property var temp_pass: ""
                property var temp_cpass: ""
                property var email
                property var username
                property var phone
                property var password

                initialItem: InitialScreen { id: current_page } 
            }

            ErrorLabel {
                id: signup_error_label
            }

            Row {
                Layout.alignment: Qt.AlignCenter
                spacing: 5
                Button {
                    id: previous_button
                    Material.background: Material.Green
                    text: "Previous"
                    font.pixelSize: 15
                    font.bold: true
                    font.family: "Segoe UI"
                    Layout.alignment: Qt.AlignCenter
                    visible: signup_screen.step > 0
                    onClicked: {
                        signup_screen.step--;
                        signup_stack.pop()
                    }
                }

                Button {
                    Material.background: Material.Green
                    text: signup_screen.step === 0 ? "Next" : "Finish"
                    font.pixelSize: 15
                    font.bold: true
                    font.family: "Segoe UI"
                    Layout.alignment: Qt.AlignCenter
                    width: previous_button.width
                    onClicked: {
                        if (text === "Next") {
                            signup_screen.step++;
                            signup_stack.push(Qt.resolvedUrl("signup/FinalScreen.qml"), {
                                "temp_pass": signup_stack.temp_pass,
                                "temp_cpass": signup_stack.temp_cpass
                            })
                            if (signup_stack.email === "") {
                                signup_error_label.text = "Email is required"
                            } else if (signup_stack.username === "") {
                                signup_error_label.text = "Username is required"
                            }
                        } else {
                            if (signup_stack.password === "") {
                                signup_error_label.text = "Password is required"
                            } else {
                                let password = signup_stack.password
                                if (password.match(/\d/g) === null) {
                                    signup_error_label.text = "Password must contain a number"
                                } else if (password.match(/[\p{P}\p{S}\s]/g) === null) {
                                    signup_error_label.text = "Password must contain a special character"
                                } else if (password.match(/[a-zA-z]/g) === null) {
                                    signup_error_label.text = "Password must contain a letter"
                                } else if (password.match(/.{8,}/g) === null) {
                                    signup_error_label.text = "Password must be atleast 8 characters long"
                                } else {
                                    signup_error_label.text = ""
                                    auth.sign_up(signup_stack.email, password, signup_stack.username, signup_stack.phone);
                                    signup_popup.busy = true;
                                    signup_popup.open();
                                }
                            } 
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: signup_timer
        interval: 3000
        onTriggered: {
            signup_popup.close();
        }
    }

    Connections {
        target: auth

        function onSignupSuccess() {
            signup_popup.busy = false;
            signup_popup.play();
            signup_timer.start();
        }

        function onInvalidEmail() {
            signup_screen.signup_error();
            signup_screen.step--;
            signup_stack.pop()
            signup_error_label.text = "Email is invalid, try a another email"
        }

        function onWeakPassword() {
            signup_screen.signup_error();
            signup_error_label.text = "Password is too weak"
        }
        
        function onDuplicateEmail() {
            signup_screen.signup_error()
            signup_screen.step--;
            signup_stack.pop()
            signup_error_label.text = "Email is already in use"
        }

        function onDuplicateUsername() {
            signup_screen.signup_error()
            signup_screen.step--;
            signup_stack.pop()
            signup_error_label.text = "Username is already taken"
        }
    }
}
