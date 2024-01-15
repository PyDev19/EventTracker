import QtQuick.Controls.Material
import QtQuick.Layouts
import "../../components/"

Page {
    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        CredentialsField {
            id: email_field
            placeholderText: "Email"
            onTextChanged: {
                signup_stack.email = text
            }
        }
        
        CredentialsField {
            id: username_field
            placeholderText: "Username"
            onTextChanged: {
                signup_stack.username = text
            }
        }

        CredentialsField {
            id: phone_number_field
            placeholderText: "Phone No. (Optional)"
            onTextChanged: {
                signup_stack.phone = text
            }
        }
    }
}
