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

private:
    void initPostDatas();
private:
    QJsonObject m_postDatas;
    QJsonArray m_jsonArray;
};


#endif //CHATGPT_QML_POSTDATA_H
