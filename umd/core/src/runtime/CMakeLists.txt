set(ROOT ${PROJECT_SOURCE_DIR})

set(MODULE_NAME libnvdla_runtime)

if (NOT DEFINED TOOLCHAIN_PREFIX)
    message(FATAL_ERROR "Toolchain prefix missing")
endif ()

set(MODULE_OPTFLAGS "-0s")
set(MODULE_COMPILEFLAGS "-g -fPIC -finline -W -Wall -Wno-multichar -Wno-unused-parameter -Wno-unused-function -Werror-implicit-function-declaration")
set(MODULE_CFLAGS "--std=c99")
set(MODULE_CPPFLAGS "--std=c++11 -fexceptions -fno-rtti")

set(CMAKE_CXX_FLAGS "${MODULE_OPTFLAGS} ${MODULE_COMPILEFLAGS} ${MODULE_CFLAGS} ${MODULE_CPPFLAGS}")

set()

add_library(${MODULE_NAME} SHARED )