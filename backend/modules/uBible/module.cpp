/*
 * Whatsoever ye do in word or deed, do all in the name of the
 * Lord Jesus, giving thanks to God and the Father by him.
 * - Colossians 3:17
 *
 * uBible - Bible application for Ubuntu Touch
 * Copyright (C) 2013 The uBible Developers.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include "module.h"

#include <QDebug>
#include <QStandardPaths>
#include <QDir>

#include <sword/swmgr.h>

Module::Module(const QString &name, QObject *parent) :
    QObject(parent)
{
    setName(name);
}

void Module::setName(const QString &name) {
    if (m_name == name) return;

    m_name = name;

    QString dataPath(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
    QString configPath = dataPath + "/library/";

    qDebug() << configPath << QDir(configPath).mkpath("modules");
    qDebug() << QDir(configPath).mkpath("mods.d");

    qDebug() << "Creating a new module:" << name;
    sword::SWMgr *library = new sword::SWMgr(qPrintable(configPath));

    if (library->config == nullptr) {
        qFatal("SWORD configuration file not found!");
    }

    m_module = library->getModule(qPrintable(name));
    if (m_module == 0) {
        m_exists = false;
        qDebug() << "Module does not exist:" << name;
    } else {
        m_exists = true;

        qDebug() << "Module" << name << m_module->Name();
    }

    nameChanged(m_name);

    existsChanged(m_exists);
}
