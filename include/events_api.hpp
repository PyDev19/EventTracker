#ifndef EVENTS_API_HPP
#define EVENTS_API_HPP

#include <QObject>
#include <QNetworkAccessManager>

class EventsApi: public QObject {
    Q_OBJECT
public:
    explicit EventsApi(QObject *parent = nullptr);
    Q_INVOKABLE QString get_events(QString query);

private:
    QNetworkAccessManager *manager;
    QString *api_url;
};

#endif
