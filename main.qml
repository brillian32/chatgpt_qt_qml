import QtQuick
import QtQuick.Controls

Window {
    id: mainWin
    height: 480
    title: qsTr("chatgpt 3.5 turbo")
    visible: true
    width: 640
    color:"#21282d"
    objectName: "objMainWin"

    ListModel {
        id:modelList
        ListElement {
            role: "system"
            msg: "用中文回答"
        }
    }

    ListView {

        width: mainWin.width
        height: 600
        anchors.topMargin : 10
        anchors.top : rectMessageEdit.bottom
        anchors.left : rectMessageEdit.left
        model: modelList
        spacing: 5
        delegate: Rectangle {
            height: 25
            width: parent.width
            border.width: 2
            radius:4
            border.color: "gray"
            Text {
                text:role + ":    " +msg
                anchors.centerIn: parent
            }
        }
    }
    function addChatMessage(arg1,arg2){
        console.log("qml slot runing",arg1,arg2)
        var data = {"role":arg1, "msg":arg2}
        modelList.append(data)
    }

    Button {
        id: sendBtn
        anchors.left: rectMessageEdit.right
        anchors.leftMargin: 4
        anchors.verticalCenter: rectMessageEdit.verticalCenter
        text: "send"

        //设置按钮背景颜色
        background: Rectangle {
            color: "#55e5c5"
            radius:4
        }
        onPressed: {
            console.log(inputData.text)
            var data = {"role":"user", "msg":inputData.text}
            modelList.append(data)
            openAIAPI.sendMessage(inputData.text)
        }

    }
    Rectangle {
        id: rectMessageEdit
        border.color: "#2e2f30"
        border.width: 2
        height: 32
        radius: 6
        width: 250
        x: 10
        y: 10

        TextInput {
            id: inputData
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            autoScroll: true
            clip: true
            color: "#6c4f4f"
            font.family: "Microsoft YaHei"
            font.pixelSize: 16
            horizontalAlignment: Text.AlignLeft
            selectByMouse: true
            selectionColor: "#2e2f30"
            verticalAlignment: Text.AlignVCenter
            width: parent.width - 4
            //validator:RegExpValidator regExp:/[0-9A-Za-z]+/}
            wrapMode: TextInput.NoWrap

            onTextChanged: console.log(inputData.text)

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color: "#999999"
                font.family: "Microsoft YaHei"
                font.pixelSize: 14
                text: qsTr("edit message here")
                visible: (inputData.text === "" & !inputData.focus) ? true : false
            }
        }
    }

}
