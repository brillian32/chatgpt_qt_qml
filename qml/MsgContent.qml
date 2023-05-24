import QtQuick
import QtQuick.Controls

Item{
    objectName: "msg_content"
    Loading{
        id:loading
        z:1
        anchors.centerIn: parent
        width: 45
        height: 45
    }

    function addChatMessage(arg1, arg2) {
        console.log("qml slot runing", arg1, arg2);
        var data = {
            "role": qsTr(arg1),
            "msg": arg2,
            "back_color": loder_skin.item.reply_color
        };
        if(data.role === qsTr("user"))
        {
            data.back_color =  loder_skin.item.user_color
        }
        modelList.append(data);
        loading.end_loading();
        scroll_bar.position = 1; //跳转到listview最底下
    }
    function replyError(arg1) {
        console.log("qml slot runing", arg1);
        var data = {
            "role": qstr("Error"),
            "msg": arg1,
            "back_color": loder_skin.item.error_color
        };
        modelList.append(data);
        loading.end_loading();
        scroll_bar.position = 1; //跳转到listview最底下
    }

    ListModel {
        id: modelList
        Component.onCompleted: {
            modelList.append({   msg: "用中文回答问题",
                                 role: qsTr("system"),
                                 back_color : loder_skin.item.system_color})
            console.log("modelList init");
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
        width: parent.width - 20
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
            id: scroll_bar
            minimumSize: 0.1
            size: 0.5
            width: 10
            anchors.top: parent.top
            anchors.bottom:parent.bottom
            anchors.right : parent.right
            onActiveChanged: {
                console.log("onActiveChanged...");
                active = true;
            }

            background: Rectangle {
                color: "#21282d"
            }
            contentItem: Rectangle {
                color: scroll_bar.pressed ? "#4a545c" : "#394048"
                radius: width / 2
            }
    }
    delegate: Rectangle {
        id: chatMsgRect
        border.color: back_color
        border.width: 1
        color: back_color
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
            width: parent.width - 25
            wrapMode: TextInput.WrapAnywhere
            z: 1
        }
        Rectangle {
            //msg文字背景
            anchors.fill: msgText
            border.color: back_color
            border.width: 1
            color: "#111416"
            radius: 3
            z: 0
        }
    }
   }

    Button {
        property int lastAsk: 0
        //发送按钮
        id: sendBtn
        anchors.left: rectMessageEdit.right
        anchors.leftMargin: 4
        anchors.verticalCenter: rectMessageEdit.verticalCenter
        text: "send"

        ListModel{
            id: sendMsg_list
        }

        onPressed: {
            console.log(inputData.text);
            var data = {
                "role": qsTr("user"),
                "msg": inputData.text,
                "back_color": loder_skin.item.user_color
            };
            var _data = {
                "msg": inputData.text
            };

            modelList.append(data);
            scroll_bar.position = 1; //跳转到listview最底下
            openAIAPI.sendMessage(inputData.text);
            inputData.clear();
            loading.start_loading()

            sendMsg_list.append(_data)
            sendBtn.lastAsk = sendMsg_list.count
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
                    "role": qsTr("user"),
                    "msg": inputData.text,
                    "back_color": loder_skin.item.user_color
                };
                var _data = {
                    "msg": inputData.text
                };
                modelList.append(data);
                scroll_bar.position = 1
                openAIAPI.sendMessage(inputData.text);
                inputData.clear();
                loading.start_loading()

                sendMsg_list.append(_data)
                sendBtn.lastAsk = sendMsg_list.count
            }

            focus:true
            Keys.onPressed: (event)=>{
                if(event.key === Qt.Key_Up)
                {
                    console.log("Key_Up was pressed");
                    event.accepted = true;
                    if(sendBtn.lastAsk > 0) {sendBtn.lastAsk = sendBtn.lastAsk -1;}
                    else   {sendBtn.lastAsk  = 0}
                    console.log("lastAsk",sendBtn.lastAsk)
                    inputData.text = sendMsg_list.get(sendBtn.lastAsk).msg;
                }
                if(event.key === Qt.Key_Down)
                {
                    console.log("Key_Down was pressed");
                    event.accepted = true;
                    if(sendBtn.lastAsk < sendMsg_list.count-1) {sendBtn.lastAsk = sendBtn.lastAsk + 1;}
                    else {sendBtn.lastAsk = sendMsg_list.count-1}
                    console.log("lastAsk",sendBtn.lastAsk)
                    inputData.text = sendMsg_list.get(sendBtn.lastAsk).msg;
                }
            }

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
