//
// Created by 17305 on 2023/4/6.
//
#ifndef CHATGPT_QML_GPTRESPONSEPARSEHELPER_H
#define CHATGPT_QML_GPTRESPONSEPARSEHELPER_H

#include <QByteArray>
#include <QString>
#include "qlist.h"
using singleAnwser = QPair<QString,QString>;
class GptResponseParseHelper{

public:
    GptResponseParseHelper(QByteArray response);
    ~GptResponseParseHelper();
    singleAnwser getAnwser();
private:
    void parseResponse();

private:
    QByteArray m_response;

    QList<singleAnwser> m_anwserList; //角色列表
};
#endif //CHATGPT_QML_GPTRESEPONSPARSEHELPER_H

