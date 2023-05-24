#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "include/openAIAPI.h"
#include <QObject>
#include <QQmlContext>
#include "qicon.h"
#include "qtranslator.h"
#include "QTimer"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    openAIAPI api;

    auto translator = new QTranslator(engine.rootContext());

    const QUrl url(u"qrc:/chatgpt_qml/qml/main.qml"_qs);
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
    //auto qmlObj = rootObjs.first();
    auto qmlObj = rootObjs.first()->findChild<QObject*>("msg_content",Qt::FindChildrenRecursively);
    if(!qmlObj)
    {
        qWarning()<<"Cpp get qml property obj:"<<"null";
    }

    QObject::connect(&api,SIGNAL(sigAddMessage(QVariant,QVariant)),
                     qmlObj,SLOT(addChatMessage(QVariant,QVariant)));
    QObject::connect(&api,SIGNAL(sigReplyfalied(QVariant)),
                     qmlObj,SLOT(replyError(QVariant)));

    QGuiApplication::setWindowIcon(QIcon(":/img/resource/logo.png"));

    //多语言
//    QCoreApplication::installTranslator(translator);
//    auto ret = translator->load(":/lang/lang_zh.qm");
//    //auto ret = translator->load("lang_zh.qm","C:\\Users\\17305\\Documents\\chatgpt_qml\\chatgpt_qt_qml");
//    if(!ret) qDebug()<<"error load lang";

    return app.exec();
}
