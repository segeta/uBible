/*
 * uBible - Bible application for Ubuntu Touch
 * Copyright (C) 2013 The uBible Project Developers. See the
 * COPYRIGHT file at the top-level directory of this distribution.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
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
import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components.ListItems 0.1

Page {
    id: root

    title: i18n.tr("Search")

    property alias searchText: searchField.text

    function search(text) {
        root.searchText = (text || "")
        // TODO: Better way to do this???
        tabs.selectedTabIndex = 2
        doSearch()
    }

    function doSearch() {

    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentWidth: content.width
        contentHeight: content.height

        Column {
            id: content
            width: root.width


            Empty {
                TextField {
                    id: searchField

                    placeholderText: "Search..."

                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        right: searchButton.left
                        margins: units.gu(1)
                    }
                }

                Button {
                    id: searchButton

                    anchors {
                        top: searchField.top
                        bottom: searchField.bottom
                        right: parent.right
                        rightMargin: units.gu(1)
                    }

                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "green"
                        }

                        GradientStop {
                            position: 1
                            color: Qt.rgba(0.3,0.7,0.3,1)
                        }
                    }

                    text: "Search"

                    onClicked: root.doSearch()
                }
            }

            Header {
                text: "Search Results"
            }
        }
    }

    Scrollbar {
        flickableItem: flickable
    }
}