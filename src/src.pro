TEMPLATE = lib
TARGET = systemsettings

CONFIG += qt create_pc create_prl no_install_prl c++11
QT += qml dbus systeminfo
QT -= gui

CONFIG += c++11 hide_symbols link_pkgconfig
PKGCONFIG += profile mlite5 mce timed-qt5 libshadowutils blkid libcrypto nemomodels-qt5 libsailfishkeyprovider connman-qt5
PKGCONFIG += ssu-sysinfo nemodbus

system(qdbusxml2cpp -p mceiface.h:mceiface.cpp mce.xml)
system(qdbusxml2cpp -c ConnmanVpnProxy -p connmanvpnproxy ../dbus/net.connman.vpn.xml -i qdbusxml2cpp_dbus_types.h)
system(qdbusxml2cpp -c ConnmanVpnConnectionProxy -p connmanvpnconnectionproxy ../dbus/net.connman.vpn.Connection.xml -i qdbusxml2cpp_dbus_types.h)
system(qdbusxml2cpp -c ConnmanServiceProxy -p connmanserviceproxy ../dbus/net.connman.service.xml -i qdbusxml2cpp_dbus_types.h)

SOURCES += \
    languagemodel.cpp \
    logging.cpp \
    datetimesettings.cpp \
    profilecontrol.cpp \
    alarmtonemodel.cpp \
    mceiface.cpp \
    displaysettings.cpp \
    aboutsettings.cpp \
    certificatemodel.cpp \
    vpnmodel.cpp \
    connmanserviceproxy.cpp \
    connmanvpnproxy.cpp \
    connmanvpnconnectionproxy.cpp \
    developermodesettings.cpp \
    batterystatus.cpp \
    diskusage.cpp \
    diskusage_impl.cpp \
    partition.cpp \
    partitionmanager.cpp \
    partitionmodel.cpp \
    deviceinfo.cpp \
    locationsettings.cpp \
    timezoneinfo.cpp \
    udisks2job.cpp \
    udisks2monitor.cpp

PUBLIC_HEADERS = \
    languagemodel.h \
    datetimesettings.h \
    profilecontrol.h \
    alarmtonemodel.h \
    mceiface.h \
    displaysettings.h \
    aboutsettings.h \
    certificatemodel.h \
    vpnmodel.h \
    connmanserviceproxy.h \
    connmanvpnproxy.h \
    connmanvpnconnectionproxy.h \
    developermodesettings.h \
    batterystatus.h \
    diskusage.h \
    partition.h \
    partitionmanager.h \
    partitionmodel.h \
    systemsettingsglobal.h \
    deviceinfo.h \
    locationsettings.h \
    timezoneinfo.h

HEADERS += \
    $$PUBLIC_HEADERS \
    qdbusxml2cpp_dbus_types.h \
    batterystatus_p.h \
    diskusage_p.h \
    locationsettings_p.h \
    logging_p.h \
    partition_p.h \
    partitionmanager_p.h \
    udisks2defines.h \
    udisks2job_p.h \
    udisks2monitor_p.h

DEFINES += \
    SYSTEMSETTINGS_BUILD_LIBRARY

develheaders.path = /usr/include/systemsettings
develheaders.files = $$PUBLIC_HEADERS

target.path = $$[QT_INSTALL_LIBS]
pkgconfig.files = $$PWD/pkgconfig/systemsettings.pc
pkgconfig.path = $$target.path/pkgconfig

locationconfig.files = $$PWD/location.conf
locationconfig.path = /etc/location

QMAKE_PKGCONFIG_NAME = lib$$TARGET
QMAKE_PKGCONFIG_VERSION = $$VERSION
QMAKE_PKGCONFIG_DESCRIPTION = System settings application development files
QMAKE_PKGCONFIG_LIBDIR = $$target.path
QMAKE_PKGCONFIG_INCDIR = $$develheaders.path
QMAKE_PKGCONFIG_DESTDIR = pkgconfig
QMAKE_PKGCONFIG_REQUIRES = Qt5Core Qt5DBus profile nemomodels-qt5 libsailfishkeyprovider connman-qt5

INSTALLS += target develheaders pkgconfig locationconfig
