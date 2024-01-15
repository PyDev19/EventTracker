#include "firebase_auth.hpp"
#include <cassert>

FirebaseAuth::FirebaseAuth(FirebaseFirestore *firebase_db, App *firebase_app, QObject *parent): QObject(parent) {
    app = firebase_app; // initialized class firebase app variable with provided firebase app arguement
    auth = Auth::GetAuth(app); // initliazte class firebase auth with firebase app
    firebase_firestore = firebase_db; // initialize class firebase firstore variable with arguement
}

void FirebaseAuth::login(QString email, QString password) {
    // Attempt to sign in with email and password
    Future<AuthResult> result = auth->SignInWithEmailAndPassword(email.toUtf8().constData(), password.toUtf8().constData());
    
    // Set up callback for completion of sign-in attempt
    result.OnCompletion([this, result](const Future<AuthResult> &_result) {
        assert(_result.status() == kFutureStatusComplete);
        
        // Check if the sign-in was successful
        if (_result.error() == kAuthErrorNone) {
            User user = auth->current_user(); // Retrieve current user and emit loginSuccess signal with username
            emit loginSuccess(QString::fromStdString(user.display_name()));
        } else if (_result.error() == kAuthErrorUserNotFound || _result.error() == kAuthErrorWrongPassword) {
            emit wrongCredentials(); // Emit signal for wrong credentials
        } else if (_result.error() == kAuthErrorUserNotFound) {
            emit userDoesNotExist(); // Emit signal for user not found
        } else if (_result.error() == kAuthErrorUserDisabled) {
            emit userDisabled(); // Emit signal for disabled user
        }
    });
}

void FirebaseAuth::sign_up(QString email, QString password, QString username) {
    // Attempt to create a new user with email and password
    Future<AuthResult> result = auth->CreateUserWithEmailAndPassword(email.toUtf8().constData(), password.toUtf8().constData());
    
    // Set up callback for completion of sign-up attempt
    result.OnCompletion([this, username](const Future<AuthResult> &_result) {
        assert(_result.status() == kFutureStatusComplete); // check if the result has been retrieved
        
        // Check if the sign-up was successful
        if (_result.error() == kAuthErrorNone) {
            User user = auth->current_user(); // Retrieve current user
            
            // Update user profile with provided username
            if (user.is_valid()) {
                User::UserProfile profile;
                profile.display_name = username.toStdString().c_str();
                user.UpdateUserProfile(profile);
            }
            
            sign_out(true); // Sign out the user (no_emit is true to prevent signoutSuccess signal emission)
            
            emit signupSuccess(); // Emit signal for successful sign-up
        } else if (_result.error() == kAuthErrorInvalidEmail) {
            emit invalidEmail(); // Emit signal for invalid email during sign-up
        } else if (_result.error() == kAuthErrorWeakPassword) {
            emit weakPassword(); // Emit signal for weak password during sign-up
        } else if (_result.error() == kAuthErrorEmailAlreadyInUse) {
            emit duplicateEmail(); // Emit signal for email already in use during sign-up
        }
    });
}

void FirebaseAuth::sign_out(bool no_emit) {
    auth->SignOut(); // Sign out the current user
    
    // Emit signoutSuccess signal if no_emit is false
    if (!no_emit) {
        emit signoutSuccess();
    }
}
