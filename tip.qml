import QtQuick 2.4
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 1.0
import U1db 1.0 as U1db
import "components"


MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.kevinfeyder.tipster"
    width: units.gu(45)
    height: units.gu(75)
    backgroundColor: "#f1f1f1"//"#2ECC71"


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
        function startup(){
            stuff.tip = tipUp.contents.up;
            column1.opacity = 1;
        }
        Component.onCompleted: startup()
    }

    Page {
        id:page0
        //width: units.gu(100)
        title: i18n.tr("tipster")
        head.actions: Action {
            id:settingCog
            iconName: "settings"
            onTriggered: PopupUtils.open((setting));
        }

        Column {
            id: column1
            spacing: units.gu(1)
            opacity:0;
            width:parent.width-units.gu(4)
            anchors {
                margins: units.gu(2)
                centerIn: parent

            }
            Behavior on opacity { NumberAnimation { easing.type: Easing.InOutCirc; duration: 1500} }


            Item {
                id:firstInput
                height:units.gu(9)
                width:parent.width
                //showDivider: false
                Item{
                    id:billContainer
                    width:parent.width
                    height:billText.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    Label {
                        id:billText
                        text: billInput.focus === true ? "Dismiss Keyboard":"Bill Amount";
                        fontSize: billInput.focus === true ? "large":"medium";
                        anchors.horizontalCenter: parent.horizontalCenter;
                    }
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                            billInput.focus === true ? Qt.inputMethod.hide(): Qt.inputMethod.hide();
                            billInput.focus = false;
                        }
                    }
                }
                TextField {
                    id:billInput
                    anchors{top: billContainer.bottom; topMargin:units.gu(2);horizontalCenter: parent.horizontalCenter}
                    inputMethodHints: Qt.ImhDigitsOnly
                    width:parent.width
                    color:"#29b866"
                    placeholderText: stuff.text
                    text: ""
                    onTextChanged: stuff.text = billInput.text
                }
                //onClicked:Qt.inputMethod.hide();
            }
            Item{
                id:tip
                height:units.gu(10)
                width:parent.width
                //showDivider: false
                Label {
                    id:tipText
                    text: "Tip Percentage"
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
                                onClicked: if(stuff.tip === 0){}else {stuff.tip = stuff.tip - 1}
                            }
                        }

                        Label
                        {
                            text:" | ";
                            color:"white"
                            font.weight: Font.Light;
                        }

                        Label{
                            id:percentLabel
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
                height:units.gu(10)
                width:parent.width
                Label {
                    id:peopleText
                    text: "Number Of People"
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
