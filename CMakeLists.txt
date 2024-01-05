cmake_minimum_required(VERSION 3.16)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_TOOLCHAIN_FILE C:/Users/athar/AppData/Local/Android/Sdk/ndk/25.1.8937393/build/cmake/android.toolchain.cmake)
set(CMAKE_TOOLCHAIN_FILE C:/Qt/6.5.3/android_arm64_v8a/lib/cmake/Qt6/qt.toolchain.cmake)
set(ANDROID_SDK_ROOT C:/Users/athar/AppData/Local/Android/Sdk)
set(ANDROID_NDK_ROOT C:/Users/athar/AppData/Local/Android/Sdk/ndk/25.1.8937393)

project(EventTracker VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(EventTracker
    src/main.cpp
    src/firebase_auth.cpp
    include/firebase_auth.hpp
)

set_property(TARGET EventTracker APPEND PROPERTY
    QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
)

set_source_files_properties(src/Main.qml PROPERTIES QT_RESOURCE_ALIAS Main.qml)
set_source_files_properties(src/pages/SignupScreen.qml PROPERTIES QT_RESOURCE_ALIAS pages/SignupScreen.qml)
set_source_files_properties(src/pages/LoginScreen.qml PROPERTIES QT_RESOURCE_ALIAS pages/LoginScreen.qml)

qt_add_qml_module(EventTracker
    URI EventTracker
    VERSION 1.0
    QML_FILES 
        src/Main.qml
        src/pages/LoginScreen.qml
        src/pages/SignupScreen.qml

)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(EventTracker PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appEventTracker
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(EventTracker
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS EventTracker
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

add_subdirectory(C:/Users/athar/firebase_cpp_sdk/ bin/ EXCLUDE_FROM_ALL)

set(firebase_libs
    firebase_firestore
    firebase_auth
    firebase_database
    firebase_app
)
target_link_libraries(EventTracker PRIVATE "${firebase_libs}")
target_include_directories(EventTracker PRIVATE include)
