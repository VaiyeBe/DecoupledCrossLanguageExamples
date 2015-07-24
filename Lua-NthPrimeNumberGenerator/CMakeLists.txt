cmake_minimum_required( VERSION 2.7 )
project( SafeLists CXX )

find_package(PkgConfig REQUIRED)

pkg_check_modules(GTKMM gtkmm-3.0)

#SET( PLUMBING_DIR submodules/LibLuaPlumbing/LuaPlumbing )
SET( PLUMBING_DIR ../LibLuaPlumbing )
SET( TEMPLATIOUS_DIR ../TemplatiousLib )
SET( SRC_DIR src )

ADD_DEFINITIONS(
    -x c++
    -std=c++11
    -g
)

SET( LIBINCLUDE_DIRS
    ${GTKMM_INCLUDE_DIRS}
    ${TEMPLATIOUS_DIR}
    ${PLUMBING_DIR} )

include_directories(
    ${LIBINCLUDE_DIRS}
)

link_directories( ${GTKMM_LIBRARY_DIRS} )

add_subdirectory( ${PLUMBING_DIR}/LuaPlumbing ${CMAKE_BINARY_DIR}/LibPlumbing )

SET( CMAKE_EXPORT_COMPILE_COMMANDS yes )

add_executable( generator tests/model-tests.cpp )
target_link_libraries( generator domain pthread )

