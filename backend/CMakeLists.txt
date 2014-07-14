include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
    /usr/include/sword/
)


set(
    uBiblebackend_SRCS
    modules/uBible/backend.cpp
    modules/uBible/bible.cpp
    modules/uBible/bibleapp.cpp
    modules/uBible/biblechapter.cpp
    modules/uBible/module.cpp
)

add_library(uBiblebackend MODULE
    ${uBiblebackend_SRCS}
)

target_link_libraries(uBiblebackend sword)

set_target_properties(uBiblebackend PROPERTIES
         LIBRARY_OUTPUT_DIRECTORY uBible)

qt5_use_modules(uBiblebackend Core Gui Qml Quick)

# Copy qmldir file to build dir for running in QtCreator
add_custom_target(uBiblebackend-qmldir ALL
    COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/modules/uBible/qmldir ${CMAKE_CURRENT_BINARY_DIR}/uBible
    DEPENDS ${QMLFILES}
)

# Install plugin file
install(TARGETS uBiblebackend DESTINATION ${QT_IMPORTS_DIR}/uBible/)
install(FILES   modules/uBible/qmldir DESTINATION ${QT_IMPORTS_DIR}/uBible/)