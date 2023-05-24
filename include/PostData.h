//
// Created by 17305 on 2023/5/11.
//

#ifndef CHATGPT_QML_POSTDATA_H
#define CHATGPT_QML_POSTDATA_H
#include <QJsonObject>
#include <QJsonArray>


class PostData {

public:
    PostData();
    ~PostData();
    void addSinglePostData(const QString& role, QString& msg);
    const QJsonObject& getPostDatas();
    void  saveToLocalJson();


private:
    //该类设定要求在启动时构造，要获取启动时的时间戳
    void setFileNameWithStartTime();
    void initPostDatas();
private:
    QJsonObject m_postDatas;
    QJsonArray m_jsonArray;
    qint64 m_startTimeStamp = 0;
    QString m_fileName;
};


#endif //CHATGPT_QML_POSTDATA_H
