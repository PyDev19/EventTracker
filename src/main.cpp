#include <QGuiApplication>
#include <QJniEnvironment>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <qnativeinterface.h>
#include <firebase/app.h>
#include "firebase_auth.hpp"

using namespace QNativeInterface;
using firebase::App;

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    app.setApplicationName("EventTracker");

    QJniEnvironment *jni_env = new QJniEnvironment();
    App* firebase_app = App::Create(AppOptions(), jni_env->jniEnv(), QAndroidApplication::context());

    QQmlApplicationEngine engine;
    
    FirebaseAuth firebase_auth(firebase_app);
    engine.rootContext()->setContextProperty("auth", &firebase_auth);

    const QUrl url(u"qrc:/EventTracker/Main.qml"_qs);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
        []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
