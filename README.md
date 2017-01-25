# Mycroft Plasmoid // ALPHA RELEASE
#### Mycroft Ai Plasmoid / Widget for KDE Plasma 5 Desktop

1. Installation Requirements

  + This plasmoid requires Mycroft Core Installed from http://github.com/MycroftAi/
  + This plasmoid requires Mycroft Core to be located in your Home Folder. Example "/home/$USER/mycroft-core"
  + Download / Clone Mycroft Plasmoid from this REPO.
  + Unzip to folder if Downloaded


  + For KDE NEON / Ubuntu based Distributions: sudo apt-get install libkf5notifications-data libkf5notifications-dev qml-module-qtquick2 qml-module-qtquick-controls2 qml-module-qtquick-controls qml-module-qtwebsockets qml-module-qt-websockets qtdeclarative5-qtquick2-plugin qtdeclarative5-models-plugin cmake cmake-extras cmake-data qml-module-qtquick-layouts libkf5plasma-dev extra-cmake-modules qtdeclarative5-dev

  + For Fedora 25: sudo dnf install kf5-knotifications-devel qt5-qtbase-devel qt5-qtdeclarative-devel qt5-qtquick1-devel qt5-qtquickcontrols qt5-qtquickcontrols2 qt5-qtwebsockets cmake extra-cmake-modules kf5-plasma-devel

2. Installation Instructions [Go To Downloaded Plasmoid Folder and run the following commands]

  + mkdir build
  + cd build
  + cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release   -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
  + make
  + sudo make install
  + sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.projectmycroftplasmoid/contents/code/startservice.sh
  + sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.projectmycroftplasmoid/contents/code/stopservice.sh
  + Logout / Login or Restart Plasma Shell

3. Support 
  + Currently Tested on Fedora 25 / KDE Neon Plasma 5.8
  + Untested on < Plasma 5.8
  + It is an alpha release expect bugs.. Post bugs in this GIT Repo.
  + Works only with default Plasma Themes ( Breeze & Breeze Dark ). 
