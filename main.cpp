#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "openAIAPI.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qDebug()<<"test";
    openAIAPI api;
    QUrl openaiUrl("https://api.openai.com/v1/chat/completions");
    api.startPostRequest(openaiUrl);
    const QUrl url(u"qrc:/chatgpt_qml/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
