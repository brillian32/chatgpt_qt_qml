import QtQuick
import QtQuick.Controls

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

    function addChatMessage(arg1, arg2) {
        console.log("qml slot runing", arg1, arg2);
        var data = {
            "role": arg1,
            "msg": arg2
        };
        modelList.append(data);
        loading.end_loading();
    }
    function replyError(arg1) {
        console.log("qml slot runing", arg1);
        var data = {
            "role": "Error",
            "msg": arg1
        };
        modelList.append(data);
        loading.end_loading();
        }

    ListModel {
        id: modelList
        ListElement {
            msg: "用中文回答问题"
            role: "system"
        }
    }
    Rectangle {
        id: listViewRect
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottomMargin :15
        anchors.bottom :rectMessageEdit.top
        color: "transparent"
        width: mainWin.width - 20
    }
    ListView {
        id: listViewMesg
        anchors.fill: listViewRect
        clip: true
        interactive: true //元素可拖动
        model: modelList
        orientation: ListView.Vertical
        parent: listViewRect
        spacing: 5

        ScrollBar.vertical: ScrollBar {
            id: scrollBar
            minimumSize: 0.1
            size: 0.5
            width: 10

            onActiveChanged: {
                console.log("onActiveChanged========================");
                active = true;
            }

            background: Rectangle {
                color: "#21282d"
            }
            contentItem: Rectangle {
                color: scrollBar.pressed ? "#4a545c" : "#394048"
                radius: width / 2
            }
        }
        delegate: Rectangle {
            id: chatMsgRect
            border.color: "#55e5c5"
            border.width: 1
            color: "#45f3bf"
            height: roleText.height + msgText.height + 10 + 5
            radius: 4
            width: listViewMesg.width

            Text {
                id: roleText
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 5
                color: "#21282d"
                height: 20
                text: role
            }
            TextEdit {
                id: msgText
                anchors.left: parent.left
                anchors.leftMargin: 10 //鏂囧瓧鍏у宸﹁竟璺�
                anchors.top: roleText.bottom
                anchors.topMargin: 5
                color: "#f0f8fe"
                leftPadding: 4
                readOnly: true
                selectByMouse: true
                text: msg
                textFormat: TextEdit.MarkdownText
                width: parent.width - 20
                wrapMode: TextInput.WrapAnywhere
                z: 1
            }
            Rectangle {
                //msg文字背景
                anchors.fill: msgText
                border.color: "#55e5c5"
                border.width: 1
                color: "#111416"
                radius: 3
                z: 0
            }
        }
    }
    Button {
        //发送按钮
        id: sendBtn
        anchors.left: rectMessageEdit.right
        anchors.leftMargin: 4
        anchors.verticalCenter: rectMessageEdit.verticalCenter
        text: "send"

        onPressed: {
            console.log(inputData.text);
            var data = {
                "role": "user",
                "msg": inputData.text
            };
            modelList.append(data);
            openAIAPI.sendMessage(inputData.text);
            inputData.clear();
            loading.start_loading()
        }

        //按钮背景色
        background: Rectangle {
            color: "#55e5c5"
            radius: 4
        }
    }
    Rectangle {
        id: rectMessageEdit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 25
        border.color: "#2e2f30"
        border.width: 2
        height: inputData.height + 8
        radius: 6
        width: parent.width - 100

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
            wrapMode: TextInput.WrapAnywhere

            onAccepted: {
                console.log("onAccepted...");

                console.log(inputData.text);
                var data = {
                    "role": "user",
                    "msg": inputData.text
                };
                modelList.append(data);
                openAIAPI.sendMessage(inputData.text);
                inputData.clear();
                loading.start_loading()
            }

            // Keys.onReturnPressed: {
            //     console.log("Return key pressed")
            // }

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
    Loading{
        id:loading
        z:1
        anchors.centerIn: parent
        width: 50
        height: 50
    }
}

