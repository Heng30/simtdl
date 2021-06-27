#ifndef TDLBACKUP_H
#define TDLBACKUP_H

#include <QObject>

class tdlBackup : public QObject
{
    Q_OBJECT
public:
    explicit tdlBackup(QObject *parent = nullptr);
    Q_INVOKABLE QString read();
    Q_INVOKABLE void write(const QString &text);

    void setDir(const QString &dir);
    void setFilename(const QString &filename);

private:
    QString m_dir;
    QString m_filename;
};

#endif // TDLBACKUP_H
