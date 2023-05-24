//
// Created by 17305 on 2023/4/6.
//
#include "include/GptResponseParseHelper.h"
#include "qjsondocument.h"
#include "qjsonvalue.h"
#include "qjsonobject.h"
#include "qjsonarray.h"
GptResponseParseHelper::GptResponseParseHelper(QByteArray response)
    :m_response(response) {
    parseResponse();
}

GptResponseParseHelper::~GptResponseParseHelper() {

}

void GptResponseParseHelper::parseResponse() {
    auto jsonString = QString::fromUtf8(m_response);
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonString.toUtf8());
    QJsonObject jsonObject = jsonDoc.object();
    QJsonArray choicesArray = jsonObject["choices"].toArray();

    auto firstObj = choicesArray.first().toObject();
    firstObj = firstObj["message"].toObject();
    m_anwserList.push_back(QPair<QString,QString>(firstObj["role"].toString(),firstObj["content"].toString()));
}

singleAnwser GptResponseParseHelper::getAnwser() {
    return m_anwserList.first();
}