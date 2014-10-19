import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import "../components"


Component {
        id: setting

        Dialog {
            id: dialog
            title: "Default tip percentage"
            //text: i18n.tr("Percentage of Tip")

            TextField {
                id:normalInput
                placeholderText: tipUp.contents.up
                text: ""
                onTextChanged: tipUp.contents = {up: normalInput.text}
                inputMethodHints: Qt.ImhDigitsOnly
                      }
            Button {
                text: "Comfirm"
                color:"#2ECC71"
                onClicked: {
                    tipUp.contents = {up: normalInput.text}
                    auto.startup()
                    PopupUtils.close(dialog)}
            }
            Button {
                text: "Close"
                color:"#95A5A6"
                onClicked:{
                    PopupUtils.close(dialog) }
            }

}
}

