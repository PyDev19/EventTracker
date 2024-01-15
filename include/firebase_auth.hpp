#ifndef FIREBASE_AUTH_HPP
#define FIREBASE_AUTH_HPP

#include <firebase/app.h>
#include <firebase/future.h>
#include <firebase/auth.h>
#include <firebase/auth/types.h>
#include <QObject>
#include <QJniEnvironment>
#include <QJniObject>
#include <qtmetamacros.h>
#include "firebase_firestore.hpp"

using namespace firebase;
using namespace firebase::auth;

/**
 * @brief The FirebaseAuth class provides authentication functionality using Firebase Authentication.
 *
 * This class allows users to log in, sign up, and sign out with Firebase Authentication.
 * It emits signals based on the authentication status and errors.
*/
class FirebaseAuth: public QObject {
    Q_OBJECT
public:
    /**
     * @brief Constructs a FirebaseAuth object.
     * @param firebase_db Pointer to the associated FirebaseFirestore instance.
     * @param firebase_app Pointer to the Firebase App instance.
     * @param parent Parent QObject (optional).
    */
    explicit FirebaseAuth(FirebaseFirestore *firebase_db, App *firebase_app, QObject *parent = nullptr);

    /**
     * @brief Attempts to log in the user with the provided email and password.
     * @param email A String that contains the user's email address.
     * @param password A String that contains the user's password.
    */
    Q_INVOKABLE void login(QString email, QString password);
    
    /**
     * @brief Attempts to sign up a new user with the provided email, password, and username.
     * @param email New user's email address.
     * @param password New user's password.
     * @param username New user's username.
    */
    Q_INVOKABLE void sign_up(QString email, QString password, QString username);

    /**
     * @brief Signs out the currently authenticated user.
     * @param no_emit If true, the signoutSuccess signal will not be emitted.
    */
    Q_INVOKABLE void sign_out(bool no_emit);

signals:
    /**
     * @brief Signal emitted when a login attempt is successful.
     * @param username Username of the authenticated user.
    */
    void loginSuccess(QString username);

    /**
     * @brief Signal emitted when a sign-up attempt is successful.
    */
    void signupSuccess();

    /**
     * @brief Signal emitted when a sign-out attempt is successful.
    */
    void signoutSuccess();

    /**
     * @brief Signal emitted when login credentials are incorrect.
    */
    void wrongCredentials();

    /**
     * @brief Signal emitted when attempting to access a non-existing user.
    */
    void userDoesNotExist();

    /**
     * @brief Signal emitted when attempting to access a disabled user.
    */
    void userDisabled();

    /**
     * @brief Signal emitted when an invalid email is provided during sign-up.
    */
    void invalidEmail();

    /**
     * @brief Signal emitted when a weak password is provided during sign-up.
    */
    void weakPassword();

    /**
     * @brief Signal emitted when attempting to sign up with an email that is already in use.
    */
    void duplicateEmail();
    
    /**
     * @brief Signal emitted when attempting to sign up with an username that is already in taken.
    */
    void duplicateUsername();

private:
    App *app; /**< Pointer to the Firebase App instance. */
    Auth *auth; /**< Pointer to the Firebase Auth instance. */
    FirebaseFirestore *firebase_firestore; /**< Pointer to the associated FirebaseFirestore instance. */
};

#endif
