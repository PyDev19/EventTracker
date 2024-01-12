#include "firebase_auth.hpp"
#include <cassert>
#include <firebase/auth/types.h>

FirebaseAuth::FirebaseAuth(App *firebase_app, QObject *parent): QObject(parent) {
    app = firebase_app;
    auth = Auth::GetAuth(app);
}

void FirebaseAuth::login(QString email, QString password) {
    Future<AuthResult> result = auth->SignInWithEmailAndPassword(email.toUtf8().constData(), password.toUtf8().constData());
    result.OnCompletion([this, result](const Future<AuthResult> &_result) {
        assert(_result.status() == kFutureStatusComplete);
        if (_result.error() == kAuthErrorNone) {
            User user = auth->current_user();
            emit loginSuccess(QString::fromStdString(user.display_name()));
        } else if (_result.error() == kAuthErrorUserNotFound || _result.error() == kAuthErrorWrongPassword) {
            emit loginWrongCredentials();
        } else if (_result.error() == kAuthErrorUserNotFound) {
            emit loginUserDoesNotExist();
        } else if (_result.error() == kAuthErrorUserDisabled) {
            emit loginUserDisabled();
        }
    });
}

void FirebaseAuth::sign_up(QString email, QString password, QString username) {
    Future<AuthResult> result = auth->CreateUserWithEmailAndPassword(email.toUtf8().constData(), password.toUtf8().constData());
    result.OnCompletion([this, username](const Future<AuthResult> &_result) {
        assert(_result.status() == kFutureStatusComplete);
        if (_result.error() == kAuthErrorNone) {
            User user = auth->current_user();
            if (user.is_valid()) {
                User::UserProfile profile;
                profile.display_name = username.toStdString().c_str();
                user.UpdateUserProfile(profile);
            }
            sign_out(true);
            emit signupSuccess();
        }
    });
}

void FirebaseAuth::sign_out(bool no_emit) {
    auth->SignOut();
    if (!no_emit) {
        emit signoutSuccess();
    }
}
