#ifndef FIREBASE_FIRESTORE_HPP
#define FIREBASE_FIRESTORE_HPP

#include <QObject>
#include <firebase/app.h>
#include <firebase/firestore.h>
#include <qtmetamacros.h>

using namespace firebase;
using namespace firebase::firestore;

class FirebaseFirestore: public QObject {
    Q_OBJECT // q object macro
public:
    /**
     * @brief Firestore database handler for app
     * Initializes firebase firestore data base for application
    **/
    FirebaseFirestore();

    /**
     * @brief Checks if username provided already exists in the firestore database
     * @param username Username the user is trying to set for their profile
     * @return true if the username is already in the database and false if the username isn't in the database 
    **/
    bool check_duplicate_username(QString username);

private: // these variables can be used in the entire class
    Firestore *db; // firestore database variable, used to access firebase database
};

#endif
