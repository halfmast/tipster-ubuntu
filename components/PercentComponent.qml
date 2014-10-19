import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import "../components"

//dialog for add water

Component {
        id: dialogComponent

        Dialog {
            id: dialog
            title: "Tip Percentage"
            //text: i18n.tr("Percentage of Tip")

            TextField {
                id:tipField
                placeholderText: stuff.tip + "%"
                inputMethodHints: Qt.ImhDigitsOnly
                      }
            Button {
                text:"Comfirm"
                color:"#2ECC71"
                onClicked: {/*tipUp.contents = {up: tipField.text}*/stuff.tip = tipField.text; PopupUtils.close(dialog);}
            }
            Button {
                text: "Close"
                color:"#95A5A6"
                onClicked:{ PopupUtils.close(dialog) }
            }

}
}



