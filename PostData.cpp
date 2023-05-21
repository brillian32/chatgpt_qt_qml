//
// Created by 17305 on 2023/5/11.
//

#include "PostData.h"
#include <QJsonArray>
#include <QFile>
#include "QJsonDocument"
#include "qdatetime.h"
#include "qdir.h"

PostData::PostData() {
    initPostDatas();
    setFileNameWithStartTime();
}

PostData::~PostData() {

}

void PostData::initPostDatas() {

    QJsonObject _parameters;
    _parameters.insert("role","system");
    _parameters.insert("content",QString("用中文回答问题"));
    m_jsonArray.append(_parameters);
    m_postDatas["model"] = "gpt-3.5-turbo";
    m_postDatas["max_tokens"] = 1024;
    m_postDatas["temperature"] = 1;
    m_postDatas.insert("messages",m_jsonArray);
}

void PostData::addSinglePostData(const QString& role, QString& msg)
{
    QJsonObject parameters;
    parameters.insert("role",role);
    parameters.insert("content",msg);
    m_jsonArray.append(parameters);
    if(m_postDatas.contains("messages"))
    {
        m_postDatas.remove("messages");
    }
    m_postDatas.insert("messages",m_jsonArray);

    //todo test
    saveToLocalJson();
}

const QJsonObject &PostData::getPostDatas() {
    return m_postDatas;
}

void PostData::saveToLocalJson() {
    QFile file(m_fileName);
    if (!file.open(QIODevice::WriteOnly)) {
        qDebug() << "File open error";
    }
    else {
        qDebug() << "File open!";
    }
    QJsonDocument jsonDoc;
    jsonDoc.setObject(m_postDatas);
    // 将json以文本形式写入文件并关闭文件。
    file.write(jsonDoc.toJson());
    file.close();
}

void PostData::setFileNameWithStartTime() {
    QString directory = "E:/chatGptData";
    QDir dir(directory);
    if (!dir.exists()) {
        // 目录不存在，先创建
        dir.mkpath(directory);
    }
    auto currentTime = QTime::currentTime();
    m_fileName = QString("%3/chatGpt_session_%1_%2.json").arg(currentTime.toString("hh_mm_ss_zzz")).arg(QDate::currentDate().year()).arg(directory);
}

