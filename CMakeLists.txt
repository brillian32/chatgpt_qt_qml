cmake_minimum_required(VERSION 3.16)

project(chatgpt_qml VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


find_package(Qt6 6.2 COMPONENTS Quick Network REQUIRED)

qt_add_executable(appchatgpt_qml
    main.cpp
        openAIAPI.cpp openAIAPI.h)

qt_add_qml_module(appchatgpt_qml
    URI chatgpt_qml
    VERSION 1.0
    QML_FILES main.qml 
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
