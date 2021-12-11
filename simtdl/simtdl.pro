QT += quick core

TARGET = simtdl
CONFIG += c++17
RC_ICONS = favicon.ico

window {
    DEFINES += Q_O_WINDOW
}

linux {
    QT += x11extras
    LIBS += -lX11 -lxcb
    DEFINES += Q_O_LINUX
}

RESOURCES += qml.qrc

INCLUDEPATH += qglobalshortcut

SOURCES += \
        globalshortcutforward.cpp \
        main.cpp \
        qglobalshortcut/qglobalshortcut.cc \
        tdlbackup.cpp

win32:SOURCES += qglobalshortcut/qglobalshortcut_win.cc
linux:SOURCES += qglobalshortcut/qglobalshortcut_x11.cc
macx:SOURCES  += qglobalshortcut/sqglobalshortcut_macx.cc

HEADERS += \
    globalshortcutforward.h \
    qglobalshortcut/qglobalshortcut.h \
    tdlbackup.h

isEmpty(BINDIR):BINDIR=/usr/bin
isEmpty(APPDIR):APPDIR=/usr/share/applications
isEmpty(DSRDIR):DSRDIR=/usr/share/simtdl

target.path = $$INSTROOT$$BINDIR
icon_files.path = $$PREFIX/share/icons/hicolor/scalable/apps/
icon_files.files = $$PWD/favicon.ico

desktop.path = $$INSTROOT$$APPDIR
desktop.files = simtdl.desktop

INSTALLS += target desktop icon_files

