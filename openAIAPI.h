//
// Created by 17305 on 2023/4/5.
//

#ifndef CHATGPT_QML_OPENAIAPI_H
#define CHATGPT_QML_OPENAIAPI_H

#endif //CHATGPT_QML_OPENAIAPI_H
#include "qobject.h"
class openAIAPI : public QObject
{
Q_OBJECT
public:
    openAIAPI();
    ~openAIAPI();
    bool startPostRequest( QUrl url);
};