#include "database.hpp"
#include <qdebug.h>

using namespace firebase;
using namespace firebase::firestore;

FirebaseDatabase::FirebaseDatabase() {
    firestore_db = firestore::Firestore::GetInstance(); // initialize firebase firestore database
}

void FirebaseDatabase::check_duplicate_username(QString username) {
    bool duplicate_username = false;

    CollectionReference users = firestore_db->Collection("Users");
    DocumentReference taken_usernames = users.Document("TakenUsernames");
    taken_usernames.Get().OnCompletion([&duplicate_username, username, this](const Future<DocumentSnapshot> &future) {
        if (future.status() == kFutureStatusComplete) {
            if (future.error() == kErrorNone) {
                const DocumentSnapshot *snapshot = future.result();
                
                if (snapshot && snapshot->exists()) {
                    // Check if the username field exists in the document
                    duplicate_username = snapshot->Get(username.toUtf8().constData()).is_valid();
                    emit duplicateUsernameRetrieved(duplicate_username);
                }
            }
        }
    });
}

void FirebaseDatabase::create_user(std::string user_uid, QString email, QString username, QString password, QString phone) {
    CollectionReference users = firestore_db->Collection("Users");

    MapFieldValue user_data{
        {"email", FieldValue::String(email.toStdString())},
        {"username", FieldValue::String(username.toStdString())},
        {"phone", FieldValue::String(phone.toStdString())},
    };

    MapFieldValue taken_username {
        {username.toStdString(), FieldValue::Boolean(true)}
    };

    users.Document(user_uid).Set(user_data).OnCompletion([=](Future<void> future) {
        if (future.status() == kFutureStatusComplete) {
            if (future.error() == kErrorNone) {
                users.Document("TakenUsernames").Update(taken_username).OnCompletion([=](Future<void> future) {
                    if (future.status() == kFutureStatusComplete) {
                        if (future.error() == kErrorNone) {
                            emit userCreated();
                        }
                    }
                });
            }
        }
    });
}
