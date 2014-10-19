import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0
import "../components"

//dialog for add water

Component {
        id: dialogComponent

        Dialog {
            id: dialog
            title: "Number of people"
            //text: i18n.tr("Percentage of Tip")

            TextField {
                id:peepsField
                placeholderText: stuff.number + " people"
                inputMethodHints: Qt.ImhDigitsOnly
                      }
            Button {
                text: "Comfirm"
                color:"#2ECC71"
                onClicked: {stuff.number = peepsField.text; PopupUtils.close(dialog);}
            }
            Button {
                text: "Close"
                color:"#95A5A6"
                onClicked:{ PopupUtils.close(dialog) }
            }

}
}



