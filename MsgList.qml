import QtQuick
import QtQuick.Controls
Item{

}
//Item{
//    id: msg_list
//    Rectangle {
//        id: listViewRect
//        anchors.fill:parent
////        anchors.left: msg_list.left
////        anchors.leftMargin: 10
////        anchors.top: msg_list.top
////        anchors.topMargin: 10
////        anchors.bottomMargin :15
////        anchors.bottom :rectMessageEdit.top
//        color: "transparent"
//        width: mainWin.width - 20
//    }

//    ListView {
//        id: listViewMesg
//        anchors.fill: listViewRect
//        clip: true
//        interactive: true //元素可拖动
//        model: modelList
//        orientation: ListView.Vertical
//        parent: listViewRect
//        spacing: 5
//        ScrollBar.vertical: ScrollBar {
//            id: scroll_bar
//            minimumSize: 0.1
//            size: 0.5
//            width: 10
//            anchors.top: parent.top
//            anchors.bottom:parent.bottom
//            anchors.right : parent.right
//            onActiveChanged: {
//                console.log("onActiveChanged========================");
//                active = true;
//            }

//            background: Rectangle {
//                color: "#21282d"
//            }
//            contentItem: Rectangle {
//                color: scroll_bar.pressed ? "#4a545c" : "#394048"
//                radius: width / 2
//            }
//        }
//        delegate: Rectangle {
//            id: chatMsgRect
//            border.color: "#55e5c5"
//            border.width: 1
//            color: "#45f3bf"
//            height: roleText.height + msgText.height + 10 + 5
//            radius: 4
//            width: listViewMesg.width

//            Text {
//                id: roleText
//                anchors.left: parent.left
//                anchors.leftMargin: 5
//                anchors.top: parent.top
//                anchors.topMargin: 5
//                color: "#21282d"
//                height: 20
//                text: role
//            }
//            TextEdit {
//                id: msgText
//                anchors.left: parent.left
//                anchors.leftMargin: 10 //鏂囧瓧鍏у宸﹁竟璺�
//                anchors.top: roleText.bottom
//                anchors.topMargin: 5
//                color: "#f0f8fe"
//                leftPadding: 4
//                readOnly: true
//                selectByMouse: true
//                text: msg
//                textFormat: TextEdit.MarkdownText
//                width: parent.width - 25
//                wrapMode: TextInput.WrapAnywhere
//                z: 1
//            }
//            Rectangle {
//                //msg文字背景
//                anchors.fill: msgText
//                border.color: "#55e5c5"
//                border.width: 1
//                color: "#111416"
//                radius: 3
//                z: 0
//            }
//        }
//    }
//}