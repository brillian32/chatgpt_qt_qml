import QtQuick
import QtQuick.Controls
//import FluentUI
//todo:
//1.自动滚下 //done
//2.保存与复原对话
//3.UI热加载接入
//4.上下按键访问最近的问题 //done
//5.增加皮肤颜色控制 //done
//6.模块化与异步加载


Window {
    id: mainWin
    color: "#21282d"
    height: 480
    width:480
    minimumHeight: 400
    minimumWidth:400
    objectName: "objMainWin"
    title: qsTr("chatgpt 3.5 turbo")
    visible: true

    Loader{
        anchors.fill: parent
        source: "./MsgContent.qml"
        //asynchronous : true
        Component.onCompleted: {
            console.log("MsgContent qml init");
        }
    }

    //皮肤配置最先初始化
    Loader{
        id: loder_skin
        //asynchronous : true
        source: "./SkinColor.qml"
        Component.onCompleted: {
            console.log("SkinColor qml init");
        }
    }

}

