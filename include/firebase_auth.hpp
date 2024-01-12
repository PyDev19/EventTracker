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

using namespace firebase;
using namespace firebase::auth;

class FirebaseAuth: public QObject {
    Q_OBJECT
public:
    explicit FirebaseAuth(App *firebase_app, QObject *parent = nullptr);
    Q_INVOKABLE void login(QString email, QString password);
    Q_INVOKABLE void sign_up(QString email, QString password, QString username);
    Q_INVOKABLE void sign_out(bool no_emit);

signals:
    void loginSuccess(QString username);
    void signupSuccess();
    void signoutSuccess();
    void loginWrongCredentials();

private:
    App *app;
    Auth *auth;
};

#endif
