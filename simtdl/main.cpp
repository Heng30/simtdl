#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "qglobalshortcut.h"
#include "globalshortcutforward.h"
#include "tdlbackup.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    GlobalShortcutForward gsf;
    QGlobalShortcut gs_T;
    gs_T.setKey(QKeySequence("Ctrl+Alt+T")); // show
    QObject::connect(&gs_T, SIGNAL(activated()), &gsf, SLOT(onCtrlAlt2T()));

    QQmlApplicationEngine engine;
    engine.setOfflineStoragePath(app.applicationDirPath());

    QQmlContext *context = engine.rootContext();
    context->setContextProperty("gsf", &gsf);
    context->setContextProperty("tdlbackup", new tdlBackup());

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
