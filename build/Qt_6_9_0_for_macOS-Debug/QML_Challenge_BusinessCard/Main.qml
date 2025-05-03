import QtQuick

Window {
    width: 640
    height: width/1.596

    visible: true
    title: qsTr("Business Card")

    color: "white"

    component ContactInformation: QtObject{

        property string name
        property url photo

        property string occupation
        property string company
        property string address

        property string country
        property string phone
        property string email
        property url website
    }

    ContactInformation {

        id:myContactInfo

        name:"Naga Gopi Mallolu"
        photo:Qt.resolvedUrl("profile-pic.png")
        occupation: "Sofware Engineer"
        company:"Siemens Digital Industries"
        address:"New Jersey"
        country:"United States of America"
        phone:"+1(201)-***-***"
        email:"myemail@gmail.com"
        website:"https://github.com/gopityro"
    }

    QtObject {
            id: theme
            property color primaryColor: "#000000"
            property color textColor: "white"
            property color backgroundColor: "white"
        }

    Rectangle{
        id:borderRectangle

        anchors{
            fill:parent
            margins:10
        }

        color:"transparent"
        border{
            color:theme.primaryColor
            width:2
        }
        radius: 10

        Item {
            id: borderItem
            anchors{
                fill:parent
                margins: borderRectangle.radius
            }

            Rectangle{
                id:photoFrame

                anchors{
                    top:parent.top
                    right:parent.right
                }
                width:200
                height:width

                color:"transparent"
                border{
                    color:theme.primaryColor
                    width:2
                }
                radius:5

                Image{
                    id:idPhoto

                    anchors{
                        fill:parent
                        margins:photoFrame.radius
                    }


                    source:Qt.resolvedUrl(myContactInfo.photo)
                }

            }
            Text{
                id:nameText
                color: theme.primaryColor

                text: myContactInfo.name

                font{
                    pixelSize: 40
                    weight:Font.Bold
                    capitalization: Font.Capitalize
                }
            }

            Rectangle{
                id:detailsButton

                property bool checked:false
                property bool checkable:true

                signal clicked

                anchors{
                    left:parent.left
                    bottom:parent.bottom
                }

                width:120
                height:40

                radius: height/2
                color:detailsButton.checked || tapHandler.pressed ?"white":theme.primaryColor
                border.color: detailsButton.checked|| tapHandler.pressed ? theme.primaryColor:"white"

                Text{
                    id:buttonText

                    anchors.centerIn: parent
                    text: qsTr("Details")
                    font.weight: Font.Bold

                    color:detailsButton.checked || tapHandler.pressed ?theme.primaryColor:"white"
                }

                TapHandler{
                    id:tapHandler

                    onTapped: {

                        if(detailsButton.checkable){
                            detailsButton.checked = !detailsButton.checked
                        }

                        detailsButton.clicked()

                    }
                }
            }


            Rectangle {
                id: themeBox
                width: 120
                height: 40
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                property string selectedTheme:"Black"

                Text{
                    text:themeBox.selectedTheme+" Theme"
                    font.pixelSize: 18
                    anchors.top: parent.top
                    font.italic: true
                    font.weight: Font.Bold
                    anchors.horizontalCenter: parent.horizontalCenter

                }

                Rectangle {
                    id: blackTheme
                    width: 60
                    height: 20
                    color: "#000000"
                    border.color: "black"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            themeBox.selectedTheme = "Black"
                            theme.primaryColor = "black"
                            theme.backgroundColor = "white"
                            theme.textColor = "white"
                        }
                    }
                }

                Rectangle {
                    id: blueTheme
                    width: 60
                    height: 20
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    color: "#0077cc"
                    border.color: "blue"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            themeBox.selectedTheme="Blue"
                            theme.primaryColor = "#0077cc"
                            theme.backgroundColor = "white"
                            theme.textColor = "white"
                        }
                    }
                }
            }

            Item{
                id:basicInfo

                visible:!detailsButton.checked

                anchors{
                    top:nameText.bottom
                    topMargin: 10
                    left:parent.left
                    right:parent.right
                    bottom:parent.bottom
                }

                Text{
                    id:occupationText
                    color: theme.primaryColor

                    text:myContactInfo.occupation
                    font.pixelSize: 30

                }

                Text{
                    id:companyText
                    color: theme.primaryColor

                    text:myContactInfo.company
                    font.pixelSize: 30

                    anchors{
                        top:occupationText.bottom
                        topMargin: 10
                    }

                }

            }
            Item{
                id:detailsInfo
                visible:detailsButton.checked

                anchors{
                    top:nameText.bottom
                    topMargin: 10
                    left:parent.left
                    right:parent.right
                    bottom:parent.bottom
                }

                Text{
                    id:addressText
                    color: theme.primaryColor

                    text: myContactInfo.address
                    font.pixelSize: 30
                }

                Text{
                    id:countryText
                    color: theme.primaryColor
                    text:myContactInfo.country
                    font.pixelSize: 30
                    anchors{
                        top:addressText.bottom
                        topMargin:10
                    }
                }

                Text{
                    id:phoneText
                    color: theme.primaryColor

                    text:myContactInfo.phone
                    font.pixelSize: 20
                    anchors{
                        top:countryText.bottom
                        topMargin: 10
                    }

                }

                Text{
                    id:emailText
                    color: theme.primaryColor
                    text:myContactInfo.email
                    font.pixelSize: 20
                    anchors{
                        top:phoneText.bottom
                        topMargin: 10
                    }
                }
                Text{
                    id:websiteText
                    color: theme.primaryColor
                    text:"<a href='" + myContactInfo.website + "'>" + myContactInfo.website + "</a>"

                    font.pixelSize: 20

                    anchors{
                        top:emailText.bottom
                        topMargin: 10
                    }

                    onLinkActivated: Qt.openUrlExternally(link)
                    MouseArea {
                        anchors.fill: websiteText
                        cursorShape: Qt.PointingHandCursor
                        acceptedButtons: Qt.NoButton
                    }
                }
            }
        }
    }
}
