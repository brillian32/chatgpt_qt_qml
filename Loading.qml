import QtQuick
import QtQuick.Controls
import QtQuick.Shapes 1.2


Item {

    function start_loading() {
        loading_animation.start();
        rect.visible = true;
    }
    function end_loading() {
        loading_animation.stop();
        rect.visible = false;
    }

    Rectangle {
        id: rect
        border.width: width / 6
        color: "red"
        height: width
        radius: width / 2
        visible: false
        width: parent.width
    }
    PropertyAnimation {
        id:loading_animation
        target: rect
        properties: "opacity";
        duration: 1000
        from: 0
        loops: Animation.Infinite
        to: 1
    }

}

