import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

Window {
  id: mainWindow
  x: 10
  y: 30
  width: 500
  height: Screen.desktopAvailableHeight - 45
  visible: true
  flags: Qt.Dialog
  title: qsTr("simtdl")
  color: "lightgray"

  Rectangle {
    id: topLayout
    anchors.fill: parent
    anchors.margins: 5
    color: "transparent"

    Rectangle {
      property string iconBG: "transparent"
      property string iconEnterBG: "white"

      id: toolbar
      anchors.top: mainWindow.top
      anchors.left: mainWindow.left
      anchors.right: mainWindow.right
      anchors.topMargin: 10
      width: parent.width
      height: 50
      radius: 10
      color: "lightyellow"

      Row {
        id: icons
        anchors.fill: parent
        opacity: 0.8

        Rectangle {
          width: toolbar.width / 4
          height: parent.height
          color: toolbar.iconBG
          radius: parent.height

          Image {
            id: addIcon
            anchors.centerIn: parent
            sourceSize: Qt.size(32, 32)
            source: "qrc:/image/add.png"
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.color = toolbar.iconEnterBG
            onExited: parent.color = toolbar.iconBG
            onClicked: add()
          }
        }

        Rectangle {
          width: toolbar.width / 4
          height: parent.height
          color: toolbar.iconBG
          radius: parent.height

          Image {
            id: finishIcon
            anchors.centerIn: parent
            sourceSize: Qt.size(32, 32)
            source: "qrc:/image/finish.png"
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.color = toolbar.iconEnterBG
            onExited: parent.color = toolbar.iconBG
            onClicked: finish()
          }
        }

        Rectangle {
          width: toolbar.width / 4
          height: parent.height
          color: toolbar.iconBG
          radius: parent.height

          Image {
            id: deleteIcon
            anchors.centerIn: parent
            sourceSize: Qt.size(32, 32)
            source: "qrc:/image/delete.png"
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.color = toolbar.iconEnterBG
            onExited: parent.color = toolbar.iconBG
            onClicked: del()
          }
        }

        Rectangle {
          width: toolbar.width / 4
          height: parent.height
          color: toolbar.iconBG
          radius: parent.height

          Image {
            id: aboutIcon
            anchors.centerIn: parent
            sourceSize: Qt.size(32, 32)
            source: "qrc:/image/about.png"
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.color = toolbar.iconEnterBG
            onExited: parent.color = toolbar.iconBG
            onClicked: about()
          }
        }
      }
    }

    Rectangle {
      id: inputLayout
      anchors.top: toolbar.bottom
      anchors.topMargin: 10
      width: parent.width
      height: 0
      radius: 10
      visible: true
      color: "white"

      Behavior on height {
        id: inputLayoutBeHeight
        enabled: true
        NumberAnimation {
          duration: 1000
          easing.type: Easing.OutQuad
        }
      }

      ScrollView {
        id: textareaView
        anchors.fill: parent
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        TextArea {
          id: textarea
          padding: 5
          focus: true
          font.pixelSize: 24
          selectionColor: "gray"
          selectByMouse: true
          wrapMode: TextEdit.Wrap
          background: null
          placeholderText: qsTr("Enter todo description")
          KeyNavigation.priority: KeyNavigation.BeforeItem
          KeyNavigation.tab: textarea
        }
      }
    }

    Rectangle {
      id: itemLayout
      anchors.top: inputLayout.visible ? inputLayout.bottom : toolbar.bottom
      anchors.bottom: topLayout.bottom
      anchors.topMargin: 10
      width: parent.width
      height: topLayout.height - toolbar.height - toolbar.anchors.topMargin
              - (inputLayout.visible ? inputLayout.height + inputLayout.anchors.topMargin : 0)
              - anchors.topMargin
      radius: 10
      color: "lightblue"

      ScrollView {
        id: tdlItems
        anchors.fill: parent
        clip: true
        visible: !aboutInfoLayout.visible
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        ListView {
          id: listView
          width: parent.width
          spacing: 10
          model: listmodel
          delegate: Rectangle {
            property alias borderColor : rec.border.color
            anchors.left: ListView.left
            anchors.right: ListView.right
            width: listView.width
            height: isVisiable ? 100 : 0
            radius: 10
            color: BGcolor
            visible: isVisiable

            Image {
              id: doneIcon
              visible: isFinish
              anchors.centerIn: parent
              source: "qrc:/image/done.png"
            }

            Text {
              id: displayText
              anchors.fill: parent
              padding: 10
              font.pixelSize: 22
              font.bold: true
              wrapMode: Text.Wrap
              text: tdItem

              Rectangle {
                id: rec
                anchors.fill: parent
                color: "transparent"
                border.width: 3
                border.color: "transparent"
                opacity: 0.5
              }
            }

            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              onEntered: rec.color = "lightgray"
              onExited: rec.color = "transparent"
              onClicked: {
                if (listView.currentIndex !== index) {
                  listView.itemAtIndex(listView.currentIndex).borderColor = "transparent"
                  listView.currentIndex = index
                } else {
                  listView.currentIndex = 0
                }

                rec.border.color = Qt.colorEqual(
                      rec.border.color, "transparent") ? "blue" : "transparent"
              }
            }
          }

          populate: Transition {
            NumberAnimation {
              property: "opacity"
              from: 0
              to: 1
              duration: 1000
            }
          }

          remove: Transition {
            NumberAnimation {
              property: "opacity"
              from: 1
              to: 0
              duration: 1000
            }
          }
        }

        ListModel {
          id: listmodel

          ListElement {
            tdItem: "padding item"
            BGcolor: "transparent"
            isVisiable: false
            isFinish: false
          }
        }
      }

      Rectangle {
        id: aboutInfoLayout
        anchors.fill: parent
        radius: parent.radius
        visible: false
        color: "transparent"
        opacity: 0

        Text {
          id: aboutInfo
          anchors.fill: parent
          padding: 10
          font.pixelSize: 22
          font.bold: true
          wrapMode: Text.Wrap
        }

        Behavior on opacity {
          id: aboutInfoBeOpacity
          enabled: false
          NumberAnimation {
            duration: 8000
            easing.type: Easing.OutQuad
          }
        }
      }
    }
  }

  Connections {
    target: gsf
    function onCtrlAlt4T() {
      mainWindow.show()
    }
  }

  Shortcut {
    sequence: "Esc"
    context: Qt.ApplicationShortcut
    onActivated: {
      mainWindow.hide()
      mainWindow.requestActivate()
    }
  }

  Shortcut {
    sequence: "Ctrl+Q"
    context: Qt.ApplicationShortcut
    onActivated: Qt.quit()
  }

  Shortcut {
    sequence: "Ctrl+O"
    context: Qt.ApplicationShortcut
    onActivated: add()
  }

  Shortcut {
    sequence: "Ctrl+S"
    context: Qt.ApplicationShortcut
    onActivated: add()
  }

  Component.onCompleted: restoretdl()

  function add() {
    if (textarea.text.length === 0) {
      if (inputLayout.height <= 0) {
        inputLayout.height = 120
      } else {
        inputLayout.height = 0
      }
    } else {
      listmodel.append({
                         "tdItem": textarea.text,
                         "BGcolor": Qt.rgba(Math.random(), Math.random(),
                                            Math.random(), 0.7).toString(),
                         "isVisiable": true,
                         "isFinish": false
                       })

      backuptdl()
    }

    textarea.clear()
  }

  function del() {
    var oldIndex = listView.currentIndex
    if (oldIndex <= 0)
      return

    // padding item can't be deleted
    if (oldIndex <= 1 && listView.count > 2)
      listView.incrementCurrentIndex()
    else
      listView.decrementCurrentIndex()

    listmodel.remove(oldIndex)
    backuptdl()
  }

  function finish() {
    var index = listView.currentIndex
    if (index <= 0)
      return
    // padding item can't be deleted
    var item = listmodel.get(index)
    listmodel.set(index, {
                    "isFinish": !item.isFinish
                  })
    backuptdl()
  }

  function about() {
    aboutInfoLayout.visible = !aboutInfoLayout.visible
    if (aboutInfoLayout.visible) {
      aboutInfoBeOpacity.enabled = true
      aboutInfoLayout.opacity = 1
    } else {
      aboutInfoBeOpacity.enabled = false
      aboutInfoLayout.opacity = 0
    }

    var text = '<h1>simtdl v1.0.0</h1>'
    text += '<br>'
    text += '<br>'
    text += '<b>'
    text += '<p>Author: Heng</p>'
    text += '<br>'
    text += '<p>Blog: heng30.space</p>'
    text += '<br>'
    text += '<p>Email: 2238288979@qq.com</P>'
    text += '<br>'
    text += '<p>Github: github.com/Heng30/simtdl</p>'
    text += '<br>'
    text += '<p>Dogecoin: D8Ng7dd7uT3fQ3eD33biyRfiULntb6CTu3</p>'
    text += '<br>'
    text += '<p>Dogecoin(BEP20): 0x0299D3B3479cdBd7Ced235dBAB58D3a72De81169</p>'
    text += '</b>'
    aboutInfo.text = text
  }

  function backuptdl() {
    var list = []

    // skip the padding item
    for (var i = 1; i < listmodel.count; i++) {
      var item = listmodel.get(i)
      list.push({
                  "tdItem": item.tdItem,
                  "BGcolor": item.BGcolor,
                  "isVisiable": item.isVisiable,
                  "isFinish": item.isFinish
                })
    }

    var json = JSON.stringify(list)
    if (json.length <= 0)
      return
    tdlbackup.write(json)
  }

  function restoretdl() {
    var json = tdlbackup.read()
    if (json.length <= 0)
      return
    var list = JSON.parse(json)
    for (var i = 0; i < list.length; i++) {
      listmodel.append(list[i])
    }
  }
}
