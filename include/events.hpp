#ifndef EVENTS_HPP
#define EVENTS_HPP

#include <QObject>
#include <QNetworkAccessManager>

class Events: public QObject {
    Q_OBJECT
public:
    explicit Events(QObject *parent = nullptr);
    Q_INVOKABLE QString get_events(QString query);

private:
    QNetworkAccessManager *manager;
    QString *api_url;
};

#endif
