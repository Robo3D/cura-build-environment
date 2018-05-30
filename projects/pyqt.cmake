set(pyqt_command "")
set(pyqt_command
    # On Linux, PyQt configure fails because it creates an executable that does not respect RPATH
    ${PYTHON_EXECUTABLE} configure.py
    --sysroot ${CMAKE_INSTALL_PREFIX}
    --confirm-license
)

if(BUILD_OS_WINDOWS)
    list(APPEND pyqt_command
         --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake.exe
         --sip ${CMAKE_INSTALL_PREFIX}/sip.exe
         )
else()
    list(APPEND pyqt_command
         --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake
         --sip ${CMAKE_INSTALL_PREFIX}/bin/sip
         )
endif()

ExternalProject_Add(PyQt
    URL https://downloads.sourceforge.net/project/pyqt/PyQt5/PyQt-5.10/PyQt5_gpl-5.10.tar.gz
    URL_MD5 4874c5985246fdeb4c3c7843a3e6ef53
    CONFIGURE_COMMAND ${pyqt_command}
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET PyQt DEPENDS Qt Sip)
