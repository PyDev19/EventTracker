#include "events_api.hpp"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QEventLoop>
#include <QByteArray>
#include <QJsonDocument>
#include <QJsonObject>

EventsApi::EventsApi(QObject *parent): QObject(parent) {
    manager = new QNetworkAccessManager();
    api_url = new QString("https://pydev19.pythonanywhere.com/events?query=");
}

QString EventsApi::get_events(QString query) {
    QUrl encoded_url = QUrl::fromUserInput(*api_url + query);
    QNetworkRequest request(encoded_url);
    
    QNetworkReply *response = manager->get(request);
    QEventLoop loop;
    QObject::connect(response, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();

    if (response->error() != QNetworkReply::NoError) {
        qDebug() << "Error: " << response->errorString();
        delete response;
        return "";
    }

    QByteArray response_data = response->readAll();
    delete response;

    return response_data;
}
