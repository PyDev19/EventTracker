#include <QGuiApplication>
#include <QJniEnvironment>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <qnativeinterface.h>
#include <firebase/app.h>
#include "auth.hpp"
#include "database.hpp"
#include "events.hpp"

using namespace QNativeInterface;
using firebase::App;

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    app.setApplicationName("EventTracker");

    QJniEnvironment *jni_env = new QJniEnvironment();
    App* firebase_app = App::Create(AppOptions(), jni_env->jniEnv(), QAndroidApplication::context());

    QQmlApplicationEngine engine;
    
    FirebaseDatabase firebase_firestore;
    FirebaseAuth firebase_auth(&firebase_firestore, firebase_app);
    Events events;
    engine.rootContext()->setContextProperty("auth", &firebase_auth);
    engine.rootContext()->setContextProperty("api", &events);
    engine.rootContext()->setContextProperty("db", &firebase_firestore);

    const QUrl url(u"qrc:/EventTracker/Main.qml"_qs);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
        []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
