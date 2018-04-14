cmake_minimum_required(VERSION 2.8)
project(ctp)

set(BUILD_SHARED_LIBS true)
set(CMAKE_BUILD_TYPE Release)
set(CMAKE_VERBOSE_MAKEFILE true)

set(CTP_INC_DIR ${PROJECT_SOURCE_DIR}/ctp)
set(CTP_LIB_DIR ${PROJECT_SOURCE_DIR}/ctp)
include_directories(${CTP_INC_DIR})

find_library(CTP_MD_LIB thostmduserapi PATHS ${CTP_LIB_DIR})
find_library(CTP_TD_LIB thosttraderapi PATHS ${CTP_LIB_DIR})
set(CTP_LIBS ${CTP_MD_LIB} ${CTP_TD_LIB})

find_package(Java REQUIRED)
find_package(JNI REQUIRED)
include_directories(${JAVA_INCLUDE_PATH} ${JAVA_INCLUDE_PATH2})

find_package(SWIG REQUIRED)
include(${SWIG_USE_FILE})

set(CMAKE_SWIG_OUTDIR ${CMAKE_CURRENT_BINARY_DIR}/com/scalats/ctp)
set(CMAKE_SWIG_FLAGS "-package" "com.scalats.ctp")
set_property(SOURCE ctp.i PROPERTY CPLUSPLUS ON)
swig_add_module(ctp java ctp.i)
swig_link_libraries(ctp ${CTP_LIBS})
set_property(TARGET ctp PROPERTY LINK_FLAGS "-Wl,-rpath,/tmp/com.scalats/ctp/lib")

set(JAVA_JAR_FILE "com.scalats.ctp.jar")
set(JAVA_CLS_DIR ${CMAKE_CURRENT_BINARY_DIR}/cls)
file(MAKE_DIRECTORY ${JAVA_CLS_DIR})
file(GLOB JAVA_SRC_FILES "src/*.java")
file(COPY ${JAVA_SRC_FILES} DESTINATION ${CMAKE_SWIG_OUTDIR})
file(COPY ${CTP_LIBS} DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

add_custom_command(OUTPUT BUILD_JAR
    COMMENT "Creating jar file..."
    COMMAND ${Java_JAVAC_EXECUTABLE} -d ${JAVA_CLS_DIR} ${CMAKE_SWIG_OUTDIR}/*.java
    COMMAND ${Java_JAR_EXECUTABLE} cf ${CMAKE_CURRENT_BINARY_DIR}/${JAVA_JAR_FILE} -C ${JAVA_CLS_DIR} "com"
    COMMAND ${Java_JAR_EXECUTABLE} uf ${CMAKE_CURRENT_BINARY_DIR}/${JAVA_JAR_FILE} *.so
    DEPENDS ctp
)

add_custom_target(run_build_jar ALL DEPENDS BUILD_JAR)
