#include "globalshortcutforward.h"
#include <QtDebug>

GlobalShortcutForward::GlobalShortcutForward(QObject *parent)
    : QObject(parent)
{
    // do nothing
}

// show the application
void GlobalShortcutForward::onCtrlAlt2T()
{
    emit this->ctrlAlt4T();
}

