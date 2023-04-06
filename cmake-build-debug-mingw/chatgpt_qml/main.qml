import QtQuick
import QtQuick.Controls

Window {
    id: mainWin
    height: 480
    title: qsTr("chatgpt 3.5 turbo")
    visible: true
    width: 640

    Button {
        id: sendBtn
        anchors.left: rectMessageEdit.right
        anchors.leftMargin: 4
        anchors.verticalCenter: rectMessageEdit.verticalCenter
        text: "send"
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
            id: equipNameData
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

            onTextChanged: console.log(equipNameData.text)

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color: "#999999"
                font.family: "Microsoft YaHei"
                font.pixelSize: 14
                text: qsTr("edit message here")
                visible: (equipNameData.text === "" & !equipNameData.focus) ? true : false
            }
        }
    }

}
