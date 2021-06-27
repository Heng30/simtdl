#include "tdlbackup.h"

#include <QDir>
#include <QFile>
#include <QtDebug>

tdlBackup::tdlBackup(QObject *parent)
    : QObject(parent),
      m_dir(QDir::homePath() + "/.simtdl"),
      m_filename("tdl.json")
{
    // do nothing
}

void tdlBackup::setDir(const QString &dir)
{
    m_dir = dir;
}

void tdlBackup::setFilename(const QString &filename)
{
    m_filename = filename;
}

QString tdlBackup::read()
{
    QString path = m_dir + "/" + m_filename;
    QFile file(path);
    if (!file.exists()) return QString();

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << file.errorString();
        return QString();
    }

    return file.readAll();
}

void tdlBackup::write(const QString &text)
{
    QDir dir(m_dir);
    if (!dir.exists()) {
        if (!dir.mkpath(m_dir)) {
            qDebug() << "mkpath " + m_dir + "error";
            return ;
        }
    }

    QString path = m_dir + "/" + m_filename;
    QFile file(path);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qDebug() << file.errorString();
        return ;
    }

    file.write(text.toUtf8());
}
