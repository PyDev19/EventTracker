#include <QGuiApplication>
#include <QJniEnvironment>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <qnativeinterface.h>
#include <firebase/app.h>
#include "firebase_auth.hpp"
#include "firebase_firestore.hpp"
#include "events_api.hpp"

using namespace QNativeInterface;
using firebase::App;

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    app.setApplicationName("EventTracker");

    QJniEnvironment *jni_env = new QJniEnvironment();
    App* firebase_app = App::Create(AppOptions(), jni_env->jniEnv(), QAndroidApplication::context());

    QQmlApplicationEngine engine;
    
    FirebaseFirestore firebase_firestore;
    FirebaseAuth firebase_auth(&firebase_firestore, firebase_app);
    EventsApi events_api;
    engine.rootContext()->setContextProperty("auth", &firebase_auth);
    engine.rootContext()->setContextProperty("api", &events_api);
    engine.rootContext()->setContextProperty("db", &firebase_firestore);

    const QUrl url(u"qrc:/EventTracker/Main.qml"_qs);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
        []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
