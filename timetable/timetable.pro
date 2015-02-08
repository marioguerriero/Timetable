TEMPLATE = aux
TARGET = timetable

RESOURCES += timetable.qrc

QML_FILES += $$files(*.qml,true) \
					   $$files(*.js,true)

CONF_FILES +=  timetable.apparmor \
               timetable.desktop \
               timetable.png

OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES}

#specify where the qml/js files are installed to
qml_files.path = /timetable
qml_files.files += $${QML_FILES}

#specify where the config files are installed to
config_files.path = /timetable
config_files.files += $${CONF_FILES}

INSTALLS+=config_files qml_files

