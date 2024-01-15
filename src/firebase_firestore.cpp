#include "firebase_firestore.hpp"
#include <firebase/firestore/collection_reference.h>
#include <firebase/firestore/document_reference.h>
#include <firebase/firestore/document_snapshot.h>
#include <firebase/firestore/firestore_errors.h>

FirebaseFirestore::FirebaseFirestore() {
    db = Firestore::GetInstance(); // initialize firebase firestore database
}

bool FirebaseFirestore::check_duplicate_username(QString username) {
    bool duplicate_username = false;
    CollectionReference users = db->Collection("Users");
    DocumentReference taken_usernames = users.Document("TakenUsernames");
    taken_usernames.Get().OnCompletion([username, &duplicate_username](const Future<DocumentSnapshot> &future) {
        if (future.error() == kErrorOk) { // if document reference has been retrieved with no error
            const DocumentSnapshot &document = *future.result(); // get document snapshot from document reference 

            // Check if the document exists
            if (document.exists()) {
                // Check if the username field exists in the document
                if (document.Get(username.toStdString()).is_valid()) {
                    duplicate_username = true; // if the username already exists then set duplicate_username to true
                } else {
                    duplicate_username = false; // if the username doesn't exists then set duplicate_username to false
                }
            }
        }
    });

    return duplicate_username; // return duplicate_username variable
}
