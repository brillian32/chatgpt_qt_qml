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

openAIAPI::openAIAPI() {

}

openAIAPI::~openAIAPI() {

}

bool openAIAPI::startPostRequest( QUrl url)
{
    QNetworkAccessManager* networkManager = new QNetworkAccessManager(this);

    // 设置代理
#ifdef SET_NET_PROXY
    QNetworkProxy proxy(QNetworkProxy::HttpProxy, "192.168.0.105", 7890);
    networkManager->setProxy(proxy);
#endif
    QNetworkRequest request(url);

    // 设置请求头部信息
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", "Bearer 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");

    QJsonObject parameters;
    parameters.insert("role","user");
    parameters.insert("content","What is the OpenAI mission?");

//    parameters.insert("messages", "{ \
//            "model": "gpt-3.5-turbo",
//            "messages": [{"role": "user", "content": "What is the OpenAI mission?"}]
//    });

    QJsonArray jsonArray;
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
            // 处理响应数据
            qDebug() << "Response: " << response;
        } else {
            // 处理错误
            qDebug() << "Error: " << reply->errorString();
            QByteArray response = reply->readAll();
            // 处理响应数据
            qDebug() << "Response: " << response;
        }

        // 释放资源
        reply->deleteLater();
        networkManager->deleteLater();
    });
    return false;
}

