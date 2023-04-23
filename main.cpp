#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "openAIAPI.h"
#include <QObject>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    openAIAPI api;

    const QUrl url(u"qrc:/chatgpt_qml/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    //在qml中声明对象，使得qml中能使用c++对象方法
    engine.rootContext()->setContextProperty("openAIAPI",&api);

    //连接qml响应的槽/function
    auto rootObjs= engine.rootObjects();
    auto qmlObj = rootObjs.first();
    qDebug()<<"Cpp get qml property objectName:"<<qmlObj->property("objectName");
    QObject::connect(&api,SIGNAL(sigAddMessage(QVariant,QVariant)),
                     qmlObj,SLOT(addChatMessage(QVariant,QVariant)));

    return app.exec();
}
