#include "firebase_auth.hpp"
#include <cassert>

FirebaseAuth::FirebaseAuth(App *firebase_app, QObject *parent): QObject(parent) {
    app = firebase_app;
    auth = Auth::GetAuth(app);
}

void FirebaseAuth::login(QString email, QString password) {
    Future<AuthResult> result = auth->SignInWithEmailAndPassword(email.toUtf8().constData(), password.toUtf8().constData());
    result.OnCompletion([this](const Future<AuthResult> &_result) {
        assert(_result.status() == kFutureStatusComplete);
        if (_result.error() == kAuthErrorNone) {
            emit loginSuccess();
        }
    });
}

void FirebaseAuth::sign_up(QString email, QString password) {
    Future<AuthResult> result = auth->CreateUserWithEmailAndPassword(email.toUtf8().constData(), password.toUtf8().constData());
    result.OnCompletion([this](const Future<AuthResult> &_result) {
        assert(_result.status() == kFutureStatusComplete);
        if (_result.error() == kAuthErrorNone) {
            emit signupSuccess();
        }
    });
}

void FirebaseAuth::sign_out() {
    auth->SignOut();
    emit signoutSuccess();
}
