import QtQuick.Controls.Material
import QtQuick.Layouts
import "../../components/"

Page {
    id: initial_screen
    property var temp_pass: ""
    property var temp_cpass: ""
    ColumnLayout {
        anchors.fill: parent

        CredentialsField {
            id: password_field
            placeholderText: "Password"
            text: initial_screen.temp_pass
            password: true
            onTextChanged: {
                signup_stack.temp_pass = text
                if (password_field.text === "" && confirm_password_field.text === "") {
                    signup_error_label.text = ""
                }
            }
        }
                
        CredentialsField {
            id: confirm_password_field 
            placeholderText: "Confirm Password"
            text: initial_screen.temp_cpass
            password: true
            onTextChanged: {
                signup_stack.temp_cpass = text
                if (password_field.text === "" && confirm_password_field.text === "") {
                    signup_error_label.text = ""
                }
                if (password_field.text === text) {
                    signup_error_label.text = ""
                    signup_stack.password = text;
                } else {
                    signup_error_label.text = "Passwords do not match"
                }
            }
        }
    }
}
