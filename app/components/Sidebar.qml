import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1
import "../ubuntu-ui-extras" as Extra

Extra.Sidebar {
    color: "transparent"

    property bool searching
    autoFlick: false

    function search(text) {
        searching = true
    }

    Empty {
        id: searchItem
        TextField {
            id: searchField

            primaryItem: Image {
                source: getIcon("search")
                height: parent.height - units.gu(1.5)
                width: height
                anchors.centerIn: parent
            }

            placeholderText: i18n.tr("Search...")


            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                margins: units.gu(1)
            }

            onTextChanged: {
                if (text == "")
                    searching = false
            }

            onAccepted: search(searchField.text)
        }

        onClicked: search(searchField.text)
    }

    Item {
        anchors {
            top: searchItem.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        SearchView {
            anchors.fill: parent
            visible: searching
        }

        Column {
            visible: !searching
            anchors.fill: parent

            Header {
                text: i18n.tr("Verse of the Day")
                visible: showVerseOption.value
            }

            BibleVerse {
                visible: showVerseOption.value
                verse: "Proverbs 3:5-6"
                //contents: "Trust in the Lord with all thine heart; and lean not unto thine own understanding. In all thy ways acknowledge him, and he shall direct thy paths."
            }

            Header {
                text: "Reading Plan"
                visible: showReadingPlanOption.value
            }

            BibleVerse {
                visible: showReadingPlanOption.value
                verse: "Matthew 6"
                //contents: "Take heed that ye do not your alms before men, to be seen of them: otherwise ye have no reward of your Father which is in heaven. "
            }

            Header {
                text: i18n.tr("Recent")
                visible: recentReadingsOption.value.length > 0
            }

            Repeater {
                model: recentReadingsOption.value

                delegate: BibleVerse {
                    verse: modelData
                    removable: true
                }
            }
        }
    }
}
