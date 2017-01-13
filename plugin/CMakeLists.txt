find_package(PkgConfig)

kde_enable_exceptions()

set(plasmoidplugin_SRCS plasmoidplugin.cpp launchapp.cpp notify.cpp)

add_library(plasmoidplugin SHARED ${plasmoidplugin_SRCS})

target_link_libraries(plasmoidplugin Qt5::Gui Qt5::Core Qt5::Qml KF5::Plasma KF5::I18n KF5::Notifications)

install(TARGETS plasmoidplugin DESTINATION ${QML_INSTALL_DIR}/org/kde/private/projectmycroftplasmoid)

install(FILES qmldir DESTINATION ${QML_INSTALL_DIR}/org/kde/private/projectmycroftplasmoid)

install(FILES mycroftPlasmoid.notifyrc DESTINATION ${KNOTIFYRC_INSTALL_DIR})
