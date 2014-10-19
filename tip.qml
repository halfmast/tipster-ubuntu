import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0
import Ubuntu.Components.ListItems 0.1 as ListItem
import U1db 1.0 as U1db
import "components"


MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.kevinfeyder.tipster"
    width: units.gu(40)
    height: units.gu(75)
    backgroundColor: "#f1f1f1"//"#2ECC71"
    useDeprecatedToolbar: false

    U1db.Database {
      id: db
      path: "tipster.u1db"
    }

    U1db.Document {//replaces stuff.tip
      id: tipUp
      database: db
      docId: "save_up"
      create: true
      defaults: { "up": 15 }
      Component.onCompleted: { tipUp.contents.up }
                    }

    Item {
        id:stuff
        property int text: 0;
        property int tip: 15;
        property int number: 1;

    }
    Item {
        id:auto
        function startup()
        {stuff.tip = tipUp.contents.up}
        Component.onCompleted: startup()
    }

    Page {
        id:page0
        width: units.gu(100)
        title: i18n.tr("tipster")
        tools: ToolbarItems {
            // define the action:
            ToolbarButton {
                action: Action {
                    text: "User Settings"
                    iconSource: Qt.resolvedUrl("settings.svg")
                    iconName: "settings"
                    onTriggered: PopupUtils.open((setting))
                }

            }}

        Column {
            id: column1
            spacing: units.gu(1)
            anchors {
                margins: units.gu(1)
                fill: parent
            }

            Item {
                id:firstInput
                height:units.gu(10)
                width:parent.width
                //showDivider: false
                Label {
                    id:billText
                    text: "Bill Amount"
                    anchors.horizontalCenter: parent.horizontalCenter;
                }
                TextField {
                    id:billInput
                    anchors{top: billText.bottom; topMargin:units.gu(2);horizontalCenter: parent.horizontalCenter}
                    inputMethodHints: Qt.ImhDigitsOnly
                    width:parent.width
                    color:"#29b866"
                    placeholderText: stuff.text
                    text: ""
                    onTextChanged: stuff.text = billInput.text
                }
            }
            Item{
                id:tip
                height:units.gu(11)
                width:parent.width
                //showDivider: false
                Label {
                    id:tipText
                    text: "Tip percentage"
                    anchors.horizontalCenter: parent.horizontalCenter;
                }
                UbuntuShape {
                    id:tipInput
                    height:billInput.height * 1.1
                    width:billInput.width
                    radius:"medium"
                    anchors{top: tipText.bottom; topMargin:units.gu(2);horizontalCenter: parent.horizontalCenter}
                    color:"#29b866"
                    clip:true
                    Row {
                        height:parent.height /2
                        anchors.centerIn: tipInput
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: parent.width / 8
                    Image {source:"subtract.svg"
                           height: parent.height /1.3
                           width: height
                           anchors.verticalCenter: parent.verticalCenter
                           MouseArea {
                                height:tipInput.height
                                width: tipInput.width /3.5
                                anchors {verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter}
                                onClicked: if(stuff.tip === 0){/*do nothing*/}else {stuff.tip = stuff.tip - 1}
                            }
                    }

                    Label
                    {
                        text:" | ";
                        color:"white"
                        font.weight: Font.Light;
                    }

                    Label{
                        text: stuff.tip + "%"
                        color:"white";
                        MouseArea {
                            height:tipInput.height
                            width: tipInput.width /3
                            anchors {verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter}
                            onClicked: PopupUtils.open((percentComponent))}
                    }
                    Label
                    {
                        text:" | ";
                        color:"white"
                        font.weight: Font.Light;
                    }
                    Image {source:"add.svg"
                           height: parent.height /1.3
                           width: height
                           anchors.verticalCenter: parent.verticalCenter
                            MouseArea {
                                height:tipInput.height
                                width: tipInput.width /3.5
                                anchors {verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter}
                                onClicked: stuff.tip = stuff.tip + 1//tipUp.contents = { up: tipUp.contents.up + 1}
                            }
                    }
                    }

                }
            }

            Item {
                id:people
                height:units.gu(11)
                width:parent.width
                //showDivider: false
                Label {
                    id:peopleText
                    text: "Number of people"
                    anchors.horizontalCenter: parent.horizontalCenter;
                }
                UbuntuShape {
                    id:peopleInput
                    height:billInput.height * 1.1
                    width:billInput.width
                    radius:"medium"
                    anchors{top: peopleText.bottom; topMargin:units.gu(2);horizontalCenter: parent.horizontalCenter}
                    color:"#29b866"
                    clip:true
                    Row {
                        height:parent.height /2
                        anchors.centerIn: peopleInput
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: parent.width / 8
                        Image {source:"subtract.svg"
                           height: parent.height /1.3
                           width: height
                           anchors.verticalCenter: parent.verticalCenter
                            MouseArea {
                                height:peopleInput.height
                                width: peopleInput.width /3.5
                                anchors {verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter}
                                onClicked: if(stuff.number === 1){/*nothing happens*/}else {stuff.number = stuff.number - 1}}
                    }
                        Label
                        {
                            text:" | ";
                            color:"white"
                            font.weight: Font.Light;
                        }
                    Label{
                        text:stuff.number
                        color:"white"
                        MouseArea {
                            height:peopleInput.height
                            width: peopleInput.width /3.5
                            anchors {verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter}
                            onClicked: PopupUtils.open((dialogComponent))}
                    }
                    Label
                    {
                        text:" | ";
                        color:"white"
                        font.weight: Font.Light;
                    }
                    Image {source:"add.svg"
                           height: parent.height /1.3
                           width: height
                           anchors.verticalCenter: parent.verticalCenter
                            MouseArea {
                                height:peopleInput.height
                                width: peopleInput.width /3.5
                                anchors {verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter}
                                onClicked: stuff.number = stuff.number + 1;}
                    }
                    }
                }
            }
            DialogComponent {
                id: dialogComponent
                        }
            PercentComponent {
                id:percentComponent
            }
            SettingComponent {
                id:setting
            }

            Item {
                id:firsttotal
                height:units.gu(11)
                width:parent.width
                //showDivider: false
                Label {
                    id:tipTotal
                    text: if (stuff.number === 1){"Tip"} else{"Tip per person"}
                    anchors.horizontalCenter: parent.horizontalCenter;
                }
                Label {id:tipPerson
                        font.pixelSize: parent.height*0.5
                        font.weight: Font.Light; //focus: true;
                        color:"#29b866"
                        text: if(stuff.number === 1){Number(stuff.text * (stuff.tip / 100)).toLocaleCurrencyString(Qt.locale())}
                                else{Number((stuff.text * (stuff.tip / 100))/stuff.number).toLocaleCurrencyString(Qt.locale())}
                        anchors{top: tipTotal.bottom; topMargin:units.gu(1);horizontalCenter: parent.horizontalCenter}
                }
            }
            Item {
                id:secondTotal
                height:units.gu(11)
                width:parent.width
                //showDivider: false
                Label {
                    id:totalText
                    states: State{
                        name:"Switch"
                        when: stuff.number === 1
                        PropertyChanges {target:totalText;
                            text: "Total" }
                        }
                    text: "Total per person"
                    anchors.horizontalCenter: parent.horizontalCenter;
                }
                Label {
                    id:totalTotal
                    font.pixelSize: parent.height*0.5
                    font.weight: Font.Light;
                    color:"#29b866"
                    states: State{
                        name:"Switch"
                        when: stuff.number === 1
                        PropertyChanges {target:totalTotal;
                            text:Number(stuff.text + (stuff.text * (stuff.tip / 100))).toLocaleCurrencyString(Qt.locale())
                                        }
                        }
                    text: Number((stuff.text + (stuff.text * (stuff.tip / 100))) / stuff.number).toLocaleCurrencyString(Qt.locale())
                    anchors{top: totalText.bottom; topMargin:units.gu(1);horizontalCenter: parent.horizontalCenter}
                }
            }
        }
    }
}