#ifndef DATABASE_HPP
#define DATABASE_HPP

#include <QObject>
#include <firebase/firestore.h>
#include <qtmetamacros.h>

using namespace firebase;
using namespace firebase::firestore;

class FirebaseDatabase: public QObject {
    Q_OBJECT // q object macro
public:
    /**
     * @brief Firestore database handler for app
     * Initializes firebase firestore data base for application
    **/
    FirebaseDatabase();

    /**
     * @brief Checks if username provided already exists in the firestore database
     * @param username Username the user is trying to set for their profile
     * @param callback Function to call when username information has been retrieved
     * @return true if the username is already in the database and false if the username isn't in the database 
    **/
    void check_duplicate_username(QString username);

    void create_user(std::string user_uid, QString email, QString username, QString password, QString phone);

signals:
    void duplicateUsernameRetrieved(bool duplicate_username);
    void userCreated();

private: // these variables can be used in the entire class
    firestore::Firestore *firestore_db; // firestore database variable, used to access firebase database
};

#endif
