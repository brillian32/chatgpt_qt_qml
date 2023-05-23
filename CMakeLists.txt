cmake_minimum_required(VERSION 3.16)

project(chatgpt_qml VERSION 0.1 LANGUAGES CXX)

set(CMAKE_PREFIX_PATH "E:\\Qt6\\6.4.3\\msvc2019_64")
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4.3 COMPONENTS Quick Network REQUIRED)

#find_package(Qt6 REQUIRED COMPONENTS Quick Network REQUIRED)


qt_add_executable(appchatgpt_qml WIN32
    main.cpp
    openAIAPI.cpp openAIAPI.h GptResponseParseHelper.h GptResponseParseHelper.cpp
   # markdown2html.js
    PostData.cpp PostData.h
    )

qt_add_resources(appchatgpt_qml "images"
    PREFIX "/img"
    FILES ./logo.png)

qt_add_resources(appchatgpt_qml "translations"
    PREFIX "/lang"
    FILES ./lang_zh.qm)

qt_add_qml_module(appchatgpt_qml
    URI chatgpt_qml
    VERSION 1.0
    QML_FILES main.qml Loading.qml MsgContent.qml SkinColor.qml
)

set_target_properties(appchatgpt_qml PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)


target_link_libraries(appchatgpt_qml
    PRIVATE
    Qt6::Quick
    Qt6::Network)

install(TARGETS appchatgpt_qml
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
