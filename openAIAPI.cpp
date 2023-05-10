//
// Created by 17305 on 2023/4/5.
//

#include "qobject.h"
#include "openAIAPI.h"
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QUrlQuery>
#include <QJsonObject>
#include <QNetworkProxy>
#include <QJsonArray>
#include "GptResponseParseHelper.h"
openAIAPI::openAIAPI() {

}

openAIAPI::~openAIAPI() {

}

void openAIAPI::postRequest( )
{
    QUrl openaiUrl("https://api.openai.com/v1/chat/completions");
    QNetworkAccessManager* networkManager = new QNetworkAccessManager(this);
    // 设置代理
#ifdef SET_NET_PROXY
    QNetworkProxy proxy(QNetworkProxy::HttpProxy, "192.168.0.105", 7890);
    networkManager->setProxy(proxy);
#endif
    QNetworkRequest request(openaiUrl);

    // 设置请求头部信息
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", "Bearer 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");

    QJsonObject _parameters;
    _parameters.insert("role","system");
    _parameters.insert("content",QString("用中文回答问题"));
    QJsonObject parameters;
    parameters.insert("role","user");
    parameters.insert("content",m_msg);

    QJsonArray jsonArray;
    jsonArray.append(_parameters);
    jsonArray.append(parameters);
    // 创建 POST 数据
    QJsonObject postData;
    postData["model"] = "gpt-3.5-turbo";
    postData["max_tokens"] = 1024;
    postData["temperature"] = 1;
    postData.insert("messages",jsonArray);
    QJsonDocument postDataJson(postData);

    auto postJson = postDataJson.toJson();
    // 发送 POST 请求
    QNetworkReply* reply = networkManager->post(request, postJson);

    // 处理响应
    connect(reply, &QNetworkReply::finished, this, [=]() {
        if (reply->error() == QNetworkReply::NoError) {
            QByteArray response = reply->readAll();

            //解析response数据
            GptResponseParseHelper helper(response);
            auto parseResult = helper.getAnwser();

            // 响应数据
            emit sigAddMessage(parseResult.first ,parseResult.second);
            qDebug() << "Response: " << response ;
            qDebug() << parseResult.first<<":"<<parseResult.second ;
        } else {
            // 处理错误
            qDebug() << "Error: " << reply->errorString();
        }

        // 释放资源
        reply->deleteLater();
        networkManager->deleteLater();
    });
}

void openAIAPI::sendMessage(QString msg) {
    m_msg = msg;
    postRequest();
}

