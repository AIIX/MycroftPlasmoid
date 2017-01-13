import QtQuick 2.2
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

MouseArea {
    onClicked: plasmoid.expanded = !plasmoid.expanded
    
     PlasmaCore.IconItem {
        id: mycroftPlasmoidIcon
        anchors.fill: parent
        source:  "mycroft-plasma-appicon"
        }
}
        
