//
// Created by 17305 on 2023/4/5.
//

#ifndef CHATGPT_QML_OPENAIAPI_H
#define CHATGPT_QML_OPENAIAPI_H


#include "qobject.h"
#include "qvariant.h"
class openAIAPI : public QObject
{
Q_OBJECT
public:
    openAIAPI();
    ~openAIAPI();
    void postRequest();
    Q_INVOKABLE void sendMessage(QString msg);

    signals:
    void sigAddMessage(QVariant role,QVariant content);

private:
    QString m_msg;
};

#endif //CHATGPT_QML_OPENAIAPI_H