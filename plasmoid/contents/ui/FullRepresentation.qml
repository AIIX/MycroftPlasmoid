import QtQuick 2.0
import QtQml.Models 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Qt.WebSockets 1.0
import QtQuick.Controls.Styles 1.4
import Qt.labs.settings 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.private.projectmycroftplasmoid 1.0 as PlasmaLa
import org.kde.plasma.extras 2.0 as PlasmaExtras

ColumnLayout {
        id: root
        anchors.fill: parent
        Layout.fillWidth: true;
        Layout.minimumHeight: units.gridUnit * 18
        Layout.minimumWidth: units.gridUnit * 27
        Layout.preferredHeight: units.gridUnit * 18
        Layout.preferredWidth: units.gridUnit * 27
    
        WebSocket {
        id: socket
        url: "ws://0.0.0.0:8181/core"
        onTextMessageReceived: {
            welcomewidgetloader.visible = false
            suggestionswidgetloader.visible = false
            rectangleresultbox.visible = true
            var somestring = JSON.parse(message)
            var msgType = somestring.type;
            if (msgType === "speak") {
                var post = somestring.data.utterance;
                console.log(post)
                qboxoutput.text = post;
                var componentweather = Qt.createComponent("Weather.qml")
                var loadwin = componentweather.createObject(weatherloader)
                var componentstock = Qt.createComponent("Stockwidget.qml")
                var loadstock = componentstock.createObject(stockwidgetloader)
                var title = "Mycroft's Reply:"
                var notiftext = " "+ post;
                
                if (!plasmoid.expanded && notificationswitch.checked == true) {
                    PlasmaLa.Notify.mycroftResponse(title, notiftext);
                }
                
                if (qboxoutput.text.indexOf("Register") != -1 && qboxoutput.text.indexOf("your") != -1 || qboxoutput.text.indexOf("Log") != -1 && qboxoutput.text.indexOf("in") != -1){
                    regisbutton.visible=true;
                }
                else {
                    regisbutton.visible=false;
                }
                
                if (qboxoutput.text.indexOf("With") != -1 && qboxoutput.text.indexOf("a") != -1 && qboxoutput.text.indexOf("high") && qboxoutput.text.indexOf("of") != -1 && qboxoutput.text.indexOf("degrees") != -1) {
                                    var totalnumbclimstatementa = qboxoutput.text.match(/\d/g)

                                    var hightempclimstatementa = totalnumbclimstatementa.toString().substring(0, 3)
                                    hightempclimstatementa = hightempclimstatementa.replace(/\,/g,"")
                                    console.log(hightempclimstatementa)

                                    var lowtempclimstatementa = totalnumbclimstatementa.toString().substring(4,7)
                                    lowtempclimstatementa = lowtempclimstatementa.replace(/\,/g,"")
                                    console.log(lowtempclimstatementa)

                                    var currenttempclimstatementa = totalnumbclimstatementa.toString().substring(8,11)
                                    currenttempclimstatementa = currenttempclimstatementa.replace(/\,/g,"")
                                    console.log(currenttempclimstatementa)

                                    loadwin.currentweatherparam = currenttempclimstatementa
                                    loadwin.highweatherparam = hightempclimstatementa
                                    loadwin.lowweatherparam = lowtempclimstatementa
                                    qboxinput.visible = false;
                                    qboxoutput.visible = false;
                                    stockwidgetloader.visible = false;
                                    weatherloader.visible = true;
                                    
                                     if (currenttempclimstatementa <= "60") {
                                        loadwin.weatherbackgroundimage = "../images/snow.gif"
                                    }

                                    else if (currenttempclimstatementa <= "60" && qboxoutput.text.indexOf("mist") != -1 || qboxoutput.text.indexOf("light") != -1 && qboxoutput.text.indexOf("intensity") != -1 || qboxoutput.text.indexOf("rain") != -1 || qboxoutput.text.indexOf("storm") != -1 ) {
                                            loadwin.weatherbackgroundimage = "../images/rain.gif"
                                    }

                                    else if (currenttempclimstatementa >= "61") {
                                        loadwin.weatherbackgroundimage = "../images/clearsky.gif"
                                    }

                                    else if (currenttempclimstatementa >= "61" && qboxoutput.text.indexOf("mist") != -1 || qboxoutput.text.indexOf("light") != -1 && qboxoutput.text.indexOf("intensity") != -1 || qboxoutput.text.indexOf("rain") != -1 || qboxoutput.text.indexOf("storm") != -1) {
                                            loadwin.weatherbackgroundimage = "../images/rain.gif"
                                    }
                                
                                }

                else if (qboxoutput.text.indexOf("It's") != -1 && qboxoutput.text.indexOf("currently") != -1 && qboxoutput.text.indexOf("degrees") != -1 && qboxoutput.text.indexOf("Today's") != -1 && qboxoutput.text.indexOf("forecast") != -1 && qboxoutput.text.indexOf("high") != -1 && qboxoutput.text.indexOf("low") != -1) {

                                    var totalnumbclimstatementb = qboxoutput.text.match(/\d/g)

                                    var hightempclimstatementb = totalnumbclimstatementb.toString().substring(4,7)
                                    hightempclimstatementb = hightempclimstatementb.replace(/\,/g,"")
                                    console.log(hightempclimstatementb) //current

                                    var lowtempclimstatementb = totalnumbclimstatementb.toString().substring(8,11)
                                    lowtempclimstatementb = lowtempclimstatementb.replace(/\,/g,"")
                                    console.log(lowtempclimstatementb) //high

                                    var currenttempclimstatementb = totalnumbclimstatementb.toString().substring(0,3)
                                    currenttempclimstatementb = currenttempclimstatementb.replace(/\,/g,"")
                                    console.log(currenttempclimstatementb) //low

                                    loadwin.currentweatherparam = currenttempclimstatementb
                                    loadwin.highweatherparam = hightempclimstatementb
                                    loadwin.lowweatherparam = lowtempclimstatementb
                                    qboxinput.visible = false;
                                    qboxoutput.visible = false;
                                    stockwidgetloader.visible = false;
                                    weatherloader.visible = true;
                                    
                                     if (currenttempclimstatementb <= "60") {
                                        loadwin.weatherbackgroundimage = "../images/snow.gif"
                                    }

                                    else if (currenttempclimstatementb <= "60" && qboxoutput.text.indexOf("mist") != -1 || qboxoutput.text.indexOf("light") != -1 && qboxoutput.text.indexOf("intensity") != -1 || qboxoutput.text.indexOf("rain") != -1 || qboxoutput.text.indexOf("storm") != -1) {
                                            loadwin.weatherbackgroundimage = "../images/rain.gif"
                                    }

                                    else if (currenttempclimstatementb >= "61") {
                                        loadwin.weatherbackgroundimage = "../images/clearsky.gif"
                                    }

                                    else if (currenttempclimstatementb >= "61" && qboxoutput.text.indexOf("mist") != -1 || qboxoutput.text.indexOf("light") != -1 && qboxoutput.text.indexOf("intensity") != -1 || qboxoutput.text.indexOf("rain") != -1 || qboxoutput.text.indexOf("storm") != -1 ) {
                                            loadwin.weatherbackgroundimage = "../images/rain.gif"
                                    }

                }

                else if (qboxoutput.text.indexOf("Right") != -1 && qboxoutput.text.indexOf("now") != -1 && qboxoutput.text.indexOf("and") != -1 && qboxoutput.text.indexOf("degrees") != -1 && qboxoutput.text.indexOf("for") != -1 && qboxoutput.text.indexOf("a") != -1 && qboxoutput.text.indexOf("high") != -1 && qboxoutput.text.indexOf("low") != -1) {

                                    var totalnumbclimstatementc = qboxoutput.text.match(/\d/g)

                                    var hightempclimstatementc = totalnumbclimstatementc.toString().substring(4,7)
                                    hightempclimstatementc = hightempclimstatementc.replace(/\,/g,"")
                                    console.log(hightempclimstatementc) //low

                                    var lowtempclimstatementc = totalnumbclimstatementc.toString().substring(8,11)
                                    lowtempclimstatementc = lowtempclimstatementc.replace(/\,/g,"")
                                    console.log(lowtempclimstatementc) //current

                                    var currenttempclimstatementc = totalnumbclimstatementc.toString().substring(0,3)
                                    currenttempclimstatementc = currenttempclimstatementc.replace(/\,/g,"")
                                    console.log(currenttempclimstatementc) //high

                                    loadwin.currentweatherparam = currenttempclimstatementc
                                    loadwin.highweatherparam = hightempclimstatementc
                                    loadwin.lowweatherparam = lowtempclimstatementc
                                    qboxinput.visible = false;
                                    qboxoutput.visible = false;
                                    stockwidgetloader.visible = false;
                                    weatherloader.visible = true;
                                    
                                     if (currenttempclimstatementa <= "60") {
                                        loadwin.weatherbackgroundimage = "../images/snow.gif"
                                    }

                                    else if (currenttempclimstatementc <= "60" && qboxoutput.text.indexOf("mist") != -1 || qboxoutput.text.indexOf("light") != -1 && qboxoutput.text.indexOf("intensity") != -1 || qboxoutput.text.indexOf("rain") != -1 || qboxoutput.text.indexOf("storm") != -1) {
                                            loadwin.weatherbackgroundimage = "../images/rain.gif"
                                    }

                                    else if (currenttempclimstatementc >= "61") {
                                        loadwin.weatherbackgroundimage = "../images/clearsky.gif"
                                    }

                                    else if (currenttempclimstatementc >= "61" && qboxoutput.text.indexOf("mist") != -1 || qboxoutput.text.indexOf("light") != -1 && qboxoutput.text.indexOf("intensity") != -1 || qboxoutput.text.indexOf("rain") != -1 || qboxoutput.text.indexOf("storm") != -1) {
                                            loadwin.weatherbackgroundimage = "../images/rain.gif"
                                    }

                }

                else if (qboxoutput.text.indexOf("Tomorrow,") != -1 && qboxoutput.text.indexOf("will") != -1 && qboxoutput.text.indexOf("have") != -1 && qboxoutput.text.indexOf("a") != -1 && qboxoutput.text.indexOf("high") != -1 && qboxoutput.text.indexOf("low") != -1 && qboxoutput.text.indexOf("of") != -1) {

                                    var totalnumbclimstatementd = qboxoutput.text.match(/\d/g)

                                    var hightempclimstatementd = totalnumbclimstatementd.toString().substring(0, 3)
                                    hightempclimstatementd = hightempclimstatementd.replace(/\,/g,"")
                                    console.log(hightempclimstatementd)

                                    var lowtempclimstatementd = totalnumbclimstatementd.toString().substring(4,7)
                                    lowtempclimstatementd = lowtempclimstatementd.replace(/\,/g,"")
                                    console.log(lowtempclimstatementd)

                                    var currenttempclimstatementd = totalnumbclimstatementd.toString().substring(8,11)
                                    currenttempclimstatementd = currenttempclimstatementd.replace(/\,/g,"")
                                    console.log(currenttempclimstatementd)

                                    loadwin.currentweatherparam = currenttempclimstatementd
                                    loadwin.highweatherparam = hightempclimstatementd
                                    loadwin.lowweatherparam = lowtempclimstatementd
                                    loadwin.forcasttext = "Forecast"
                                    loadwin.forcastdegree = " "
                                    qboxinput.visible = false;
                                    qboxoutput.visible = false;
                                    stockwidgetloader.visible = false;
                                    weatherloader.visible = true;
                                    
                }


                else if (qboxoutput.text.indexOf("Tomorrow,") != -1 && qboxoutput.text.indexOf("it") != -1 && qboxoutput.text.indexOf("will") != -1 && qboxoutput.text.indexOf("be") != -1 && qboxoutput.text.indexOf("a") != -1 && qboxoutput.text.indexOf("high") != -1 && qboxoutput.text.indexOf("low") != -1 && qboxoutput.text.indexOf("of") != -1) {

                                    var totalnumbclimstatemente = qboxoutput.text.match(/\d/g)

                                    var hightempclimstatemente = totalnumbclimstatemente.toString().substring(0, 3)
                                    hightempclimstatemente = hightempclimstatemente.replace(/\,/g,"")
                                    console.log(hightempclimstatemente)

                                    var lowtempclimstatemente = totalnumbclimstatemente.toString().substring(4,7)
                                    lowtempclimstatemente = lowtempclimstatemente.replace(/\,/g,"")
                                    console.log(lowtempclimstatemente)

                                    var currenttempclimstatemente = totalnumbclimstatemente.toString().substring(8,11)
                                    currenttempclimstatemente = currenttempclimstatemente.replace(/\,/g,"")
                                    console.log(currenttempclimstatemente)

                                    loadwin.currentweatherparam = currenttempclimstatemente
                                    loadwin.highweatherparam = hightempclimstatemente
                                    loadwin.lowweatherparam = lowtempclimstatemente
                                    loadwin.forcasttext = "Forecast"
                                    loadwin.forcastdegree = " "
                                    qboxinput.visible = false;
                                    qboxoutput.visible = false;
                                    stockwidgetloader.visible = false;
                                    weatherloader.visible = true;
                                     
                }

                                
                else if (qboxoutput.text.indexOf("With") != -1 && qboxoutput.text.indexOf("ticker") != -1 && qboxoutput.text.indexOf("symbol") != -1 && qboxoutput.text.indexOf("dollar") != -1 && qboxoutput.text.indexOf("share") != -1) {

                var totalnumbstockpricestatementa = qboxoutput.text.match(/\d/g)
                    totalnumbstockpricestatementa = totalnumbstockpricestatementa.toString().replace(/\,/g,"")
                    var restrtotalnumbstockpricestatement = totalnumbstockpricestatementa.toString().toString().substring(0,totalnumbstockpricestatementa.length-2)+"."+totalnumbstockpricestatementa.substring(totalnumbstockpricestatementa.length-2);
                    var ressymbolname = qboxoutput.text.match(/symbol ([A-Z]+)/)[1];


                    //console.log(ressymbolname)
                    loadstock.currentstockprice = "$"+restrtotalnumbstockpricestatement
                    loadstock.currentstocksymbol = ressymbolname
                    qboxinput.visible = false;
                    qboxoutput.visible = false;
                    weatherloader.visible = false
                    stockwidgetloader.visible = true
                }

                else if (qboxoutput.text.indexOf("with") != -1 && qboxoutput.text.indexOf("ticker") != -1 && qboxoutput.text.indexOf("symbol") != -1 && qboxoutput.text.indexOf("dollar") != -1 && qboxoutput.text.indexOf("share") != -1 && qboxoutput.text.indexOf("trading") != -1) {

                                    var totalnumbstockpricestatementb = qboxoutput.text.match(/\d/g)
                                    totalnumbstockpricestatementb = totalnumbstockpricestatementb.toString().replace(/\,/g,"")
                                    var restrtotalnumbstockpricestatementb = totalnumbstockpricestatementb.toString().toString().substring(0,totalnumbstockpricestatementb.length-2)+"."+totalnumbstockpricestatementb.substring(totalnumbstockpricestatementb.length-2);
                                    var ressymbolnameb = qboxoutput.text.match(/symbol ([A-Z]+)/)[1];

                                    console.log(ressymbolnameb)
                                    loadstock.currentstockprice = "$"+restrtotalnumbstockpricestatementb
                                    loadstock.currentstocksymbol = ressymbolnameb

                                stockwidgetloader.visible = true
                                weatherloader.visible = false
                                qboxinput.visible = false;
                                qboxoutput.visible = false;
                }
             
                else {
                qboxinput.visible = true    
                qboxoutput.visible = true
                stockwidgetloader.visible = false
                weatherloader.visible = false
                }
                
            }
            //qboxinput.text = intext.slice(1,-1);
            //qboxoutput.text = KDEPlasmoidAdaptor.setTextFunctionSlot
            anim1.running = true
        }

        active: false
    }
    
        Timer {
           id: timer
       }

       function delay(delayTime, cb) {
               timer.interval = delayTime;
               timer.repeat = false;
               timer.triggered.connect(cb);
               timer.start();
           }
        
Rectangle {
        id: rectangletopbar  
        Layout.fillWidth: true
        height: 37
        color: theme.backgroundColor
        z: 2
        
GridLayout {
            id: topbarinnergridLayout
            width: 240
            height: 37
            Layout.fillHeight: true
            Layout.fillWidth: true
            columnSpacing: 2
            rows: 1
            columns: 2

            PlasmaComponents.Button {
                id: mycroftstartservicebutton
                text: qsTr("Start Mycroft")
                Layout.fillHeight: true
                Layout.fillWidth: true
                height: 37
                iconSource: "gtk-connect"

                anchors {
                            horizontalCenter: parent.horizontalLeft
                            verticalCenter: parent.verticalCenter
                                }
                
                onClicked: {
                                    PlasmaLa.LaunchApp.runCommand("bash","/usr/share/plasma/plasmoids/org.kde.plasma.projectmycroftplasmoid/contents/code/startservice.sh");
                                    currentstatus.color = "#4f666a"
                                    welcomewidgetloader.visible = false
                                    rectangleresultbox.visible = false
                                    suggestionswidgetloader.visible = true
                                    delay(12000, function() {
                                        socket.active = true
                                        qboxinput.text = qsTr("Mycroft Service Started, Connected")
                                        currentstatus.color = "#00563f"
                                        //anim1.running = false
                                    })
                }

            }

            PlasmaComponents.Button {
                id: mycroftstopservicebutton
                text: qsTr("Stop Mycroft")
                Layout.fillHeight: true
                Layout.fillWidth: true
                height: 37
                iconSource: "gtk-disconnect"
            

            anchors {
                        horizontalCenter: parent.horizontalRight
                        verticalCenter: parent.verticalCenter
                            }
            
            onClicked: {
                         PlasmaLa.LaunchApp.runCommand("bash", "/usr/share/plasma/plasmoids/org.kde.plasma.projectmycroftplasmoid/contents/code/stopservice.sh");
                         //qboxinput.text = qsTr("Mycroft Services Have Stopped");
                         currentstatus.color = "#92000a"
                         socket.active = false
                         anim1.running = true
                         welcomewidgetloader.visible = true
                         rectangleresultbox.visible = false
                         suggestionswidgetloader.visible = false
                       }
                       
        }
          
        
}

Rectangle {
            id: currentstatus
            width: 5
            height: mycroftstopservicebutton.height / 2
            color: "#92000a"
            border.width: 1
            border.color: "grey"
            
            anchors {
            verticalCenter: topbarinnergridLayout.verticalCenter  
            left: topbarinnergridLayout.right
            leftMargin: 5
            }
        }  

Column {
    id: rightButtons
    spacing: units.gridUnit * 2
    
    anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            }
            
        PlasmaComponents.TabBar {
            id: tabBar
            
         PlasmaComponents.TabButton {
            id: mycroftTab
            Layout.fillHeight: true
            Layout.fillWidth: true
            width: units.gridUnit * 2
            height: units.gridUnit * 2
            iconSource: "mycroft-plasma-appicon"
        }
        
        PlasmaComponents.TabButton {
            id: mycroftSkillsTab
            Layout.fillHeight: true
            Layout.fillWidth: true
            iconSource: "view-list-text"
        }
        
        PlasmaComponents.TabButton {
            id: mycroftSettingsTab
            Layout.fillHeight: true
            Layout.fillWidth: true
            iconSource: "gtk-preferences"
        }
        }
    }
}
     
ColumnLayout {
id: mycroftcolumntab    
visible: tabBar.currentTab == mycroftTab;

Loader {
           id: welcomewidgetloader
            Layout.fillWidth: true
            Layout.fillHeight: true
           Layout.minimumHeight: units.gridUnit * 12
           visible: true;
           active: true;
           focus: true;
           source: "Welcome.qml"

           MouseArea {
               anchors.fill: parent

               onDoubleClicked: {
               welcomewidgetloader.visible = false;
               rectangleresultbox.visible = false;
               suggestionswidgetloader.visible = true;
               }
           }
       }

Loader {
        id: suggestionswidgetloader
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.minimumHeight: units.gridUnit * 12
           visible: false;
           source: "Suggestions.qml"
           active: true;
            focus: true;

            Connections {
               target: suggestionswidgetloader.item
               Component.onCompleted: print ("Connections Component.onCompleted")
               onMessage: {
                 console.log(msg);
                 var socketmessage = {};
                 socketmessage.type = "recognizer_loop:utterance";
                 socketmessage.data = {};
                 socketmessage.data.utterances = [msg];
                 socket.sendTextMessage(JSON.stringify(socketmessage));
                 anim1.running = true
                 suggestionswidgetloader.visible = false;
                 rectangleresultbox.visible = true;
               }
            }

MouseArea {
            anchors.fill: parent

            onDoubleClicked: {
            suggestionswidgetloader.visible = !suggestionswidgetloader.visible;
            rectangleresultbox.visible = true;
            }
        }

       }

Rectangle {
        id: rectangleresultbox
        visible: false
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.minimumHeight: units.gridUnit * 12
        color: "#1d1d1d"
        border.color: "#80000000"
        border.width: 0
//        anchors.top: mycroftcolumntab.top
     
        anchors.topMargin: 5

        Rectangle {
            id: weatherloader
            anchors.fill: parent
            visible: false;
        }
        
        
        Rectangle {
            id: stockwidgetloader
            anchors.fill: parent
            visible: false;
        }
        
              MouseArea {
            anchors.fill: parent

            onDoubleClicked: {                
            suggestionswidgetloader.visible = !suggestionswidgetloader.visible;
            rectangleresultbox.visible = false;
            }
        }

        Image {
            id: image1
            opacity: 0.1
            width: parent.width / 3
            height: parent.height / 2
            verticalAlignment: Image.AlignVCenter
            horizontalAlignment: Image.AlignHCenter
            anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: 50 }
            source: "../images/background.png"

            SequentialAnimation {
                        id: anim1
                        PropertyAnimation {
                            target: image1
                            property: "opacity"
                            to: "0.6"
                            duration: 1
                        }

                        PropertyAnimation {
                             target: image1
                             property: "opacity"
                             to: "0.1"
                             duration: 1000
                                        }

                 }
        }

        Column{
           id: columnqinput

           anchors {
                 left: parent.left
                 right: parent.right
                 top: rectangleresultbox.top
                 leftMargin: 10
                 rightMargin: 10
                 topMargin: 20
                 bottomMargin: 50
                    }
    
        PlasmaExtras.Paragraph {
            id: qboxinput
            color: "#ffffff"
            text: qsTr(" ")
            font.pixelSize: fontsizetextfld.text
            textFormat: Text.AutoText
            wrapMode: Text.WrapAnywhere
            anchors { left: parent.left
                 right: parent.right
                               }
            horizontalAlignment:Text.AlignHCenter
        }
}

Column {
       id: columnqoutput

       anchors {
             left: parent.left
             right: parent.right
             top: columnqinput.bottom
             leftMargin: 10
             rightMargin: 10
             topMargin: 50
             bottomMargin: 10
       }
        
       PlasmaExtras.Paragraph {
           id: qboxoutput
       color: "#ffffff"
       font.pixelSize: fontsizetextfld.text
       textFormat: Text.AutoText
       text: qsTr(" ")
        horizontalAlignment:Text.AlignHCenter
       anchors { left: parent.left
                 right: parent.right
                             }
       wrapMode: Text.WrapAnywhere
        }
    }

PlasmaComponents.Button {
            id: regisbutton
            text:"Visit Mycroft@Home"
            visible: false;
            anchors.top: columnqoutput.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: rectangleresultbox.horizontalCenter
            onClicked: Qt.openUrlExternally("http://home.mycroft.ai")
        }
    
}
     
         Rectangle {
        id: rectanglebottombar
        Layout.fillWidth: true
        height: 36
        color: "#1b1b1b"
        radius: 0
        border.color: "#80000000"
        border.width: 0


        PlasmaComponents.TextField {
            id: qinput
            width: parent.width / 1.35
            anchors.left: qinputbutton.right
            anchors.verticalCenter: rectanglebottombar.verticalCenter
            height: 27
            placeholderText: qsTr("Enter Query or Say 'Hey Mycroft'")
            onAccepted: {
                var socketmessage = {};
                socketmessage.type = "recognizer_loop:utterance";
                socketmessage.data = {};
                socketmessage.data.utterances = [qinput.text];
                socket.sendTextMessage(JSON.stringify(socketmessage));
                qboxinput.text = qinput.text;
                qinput.text = " ";
                anim1.running = true
            }
        }

        PlasmaComponents.Button {
            id: qinputbutton
            anchors.left: rectanglebottombar.left
            width: parent.width / 4
            height: parent.height
            text: qsTr("Send")
            activeFocusOnPress: false
            iconSource: "mycroft-plasma-appicon"

            MouseArea {
                id: mouseArea3
                width: 128
                height: 33
                hoverEnabled: false
                onClicked: {
                    var socketmessage = {};
                    socketmessage.type = "recognizer_loop:utterance";
                    socketmessage.data = {};
                    socketmessage.data.utterances = [qinput.text];
                    socket.sendTextMessage(JSON.stringify(socketmessage));
                    qinput.text = ""
                    anim1.running = true
                    }

                }
            }
        }
 }
 
 ColumnLayout {
        id: skillTiptab
        visible: tabBar.currentTab == mycroftSkillsTab;
        Layout.fillWidth: true;
        height: mycroftcolumntab.height;
        anchors.top: rectangletopbar.bottom
        
    Rectangle {
        id: tiprectbox
        Layout.fillWidth: true
        height: units.gridUnit * 2
        color: theme.backgroundColor
        z: 3
         PlasmaComponents.Label {id:tipurllink; wrapMode: Text.WordWrap; text: 'For More Skills & Skills Activation Visit:  '
             PlasmaComponents.Button {
                 anchors {left: tipurllink.right}
                 text: "Mycroft@Home"
                              onClicked: Qt.openUrlExternally("http://home.mycroft.ai")
            }
             anchors {verticalCenter: tiprectbox.verticalCenter}
        }
    }        
 
Rectangle {
id: skilloutbox
Layout.fillWidth:true;
height: main.height;
anchors.fill: parent;
anchors.top: tiprectbox.bottom
anchors.topMargin: units.gridUnit * 2
color: theme.backgroundColor

    Component {
            id: skillDelegate
            Rectangle {
                id: skillcontent
                Layout.fillWidth: true;
                anchors { left: parent.left; right: parent.right }
                height: 80 
                border.width: 0        
                border.color: "lightsteelblue"
                radius: 2
                color: theme.backgroundColor

                        Column {
                            id: skillcolumn
                            Layout.fillWidth: true;
                            PlasmaComponents.Label { wrapMode: Text.WordWrap; font.bold: true; text: '<b>Skill:</b> ' + Skill }

                            Row {
                                id: skillTopRowLayout
                                height: skillimage.height
                                spacing: 10
                                Image {id: skillimage; source: Pic; width: 32; height: 32;}
                                   
                            Column {
                                id: skillinnercolumn
                            //Text { wrapMode: Text.WordWrap; font.bold: true; text: '<b>Skill:</b> ' + Skill }
                            PlasmaComponents.Label {wrapMode: Text.WordWrap; width: skillTiptab.width; text: '<b>Command:</b> ' + CommandList.get(0).Commands}
                            PlasmaComponents.Label {wrapMode: Text.WordWrap; width: skillTiptab.width; text: '<b>Command:</b> ' + CommandList.get(1).Commands}
                            PlasmaComponents.Label { wrapMode: Text.WordWrap; width: skillTiptab.width; text: '<b>Command:</b> ' + CommandList.get(2).Commands}
                            PlasmaComponents.Label { wrapMode: Text.WordWrap; width: skillTiptab.width; text: '<b>Command:</b> ' + CommandList.get(3).Commands}
                            PlasmaComponents.Label { wrapMode: Text.WordWrap; width: skillTiptab.width; text: '<b>Command:</b> ' + CommandList.get(4).Commands}
                               }
                            }
                        }

            }
    }
    
    ListView {
        id: skillslistmodelview
        anchors.fill: parent
        model: TestModel{}
        delegate: skillDelegate
        spacing: 4
        focus: false
        interactive: true
        ScrollBar.vertical: ScrollBar { }  
            }
    
    }
}

ColumnLayout {
    visible: tabBar.currentTab == mycroftSettingsTab;

Rectangle {
anchors.fill: parent
color: theme.backgroundColor
//anchors.top: rectangletopbar.bottom

Row {
    id: settingstabcolumntop
    
    PlasmaComponents.Switch {
        id: notificationswitch
        checked: true
        text: qsTr("Enable Notifications When Minimized")
        }
        
}

Row {
    id: settingstabcolumntop2
    anchors.top: settingstabcolumntop.top
    anchors.topMargin: 30
    
    PlasmaComponents.Switch {
        id: welcomeswitch
        checked: true
        text: qsTr("Enable Startup Animation")
        onCheckedChanged: {
            welcomewidgetloader.active = !welcomewidgetloader.active
        }
        
        }
        
}

Row {
    id: settingstabcolumntop3
    anchors.top: settingstabcolumntop2.top
    anchors.topMargin: 30
    
    PlasmaComponents.Switch {
        id: quickaccesswitch
        checked: true
        text: qsTr("Enable Quick Access Menu")
        onCheckedChanged: {
            suggestionswidgetloader.active = !suggestionswidgetloader.active
            }
        }
        
}
        
Column {
    id: settingstabcolumnbottom
    anchors.top: settingstabcolumntop3.top
    anchors.topMargin: 30
    
    PlasmaComponents.Label {
        id: fontsizelabelfld
        text: qsTr("Text Input Font Size: ")
        font.bold: true
        }   
    
    PlasmaComponents.TextField {
        id: fontsizetextfld
        text: "12"
        anchors.left: fontsizelabelfld.right
        anchors.verticalCenter: fontsizelabelfld.verticalCenter
        anchors.leftMargin: 10
        }
        }
        
Column {
    id: settingstabcolumnbottom2
    anchors.top: settingstabcolumnbottom.top
    anchors.topMargin: 30
    
    PlasmaComponents.Label {
        id: fontsizelabelfld2
        text: qsTr("Text Output Font Size: ")
        font.bold: true
        }   
    
    PlasmaComponents.TextField {
        id: fontsizetextfld2
        text: "12"
        anchors.left: fontsizelabelfld2.right
        anchors.verticalCenter: fontsizelabelfld2.verticalCenter
        anchors.leftMargin: 10
        }
        }
               
}
}
Settings {
            property alias fontsizeinput: fontsizetextfld.text
            property alias fontsizeoutput: fontsizetextfld2.text
            property alias notifybool: notificationswitch.checked
            property alias welcomebool: welcomeswitch.checked
            property alias quickaccesswitch: welcomeswitch.checked
        }
}
