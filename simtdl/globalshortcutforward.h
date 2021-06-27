#ifndef GLOBALSHORTCUTFORWARD_H
#define GLOBALSHORTCUTFORWARD_H

#include <QObject>

class GlobalShortcutForward: public QObject
{
    Q_OBJECT

public:
    GlobalShortcutForward(QObject *parent = nullptr);

signals:
    void ctrlAlt4T();

public slots:
    void onCtrlAlt2T();
};

#endif // GLOBALSHORTCUTFORWARD_H
