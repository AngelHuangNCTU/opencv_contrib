if(NOT BUILD_LIBPROTOBUF_FROM_SOURCES)
  find_package(Protobuf)
endif()

if(NOT BUILD_LIBPROTOBUF_FROM_SOURCES AND PROTOBUF_FOUND AND EXISTS ${PROTOBUF_PROTOC_EXECUTABLE})
  message(STATUS "The protocol buffer compiler and libprotobuf were found")

  PROTOBUF_GENERATE_CPP(PROTO_HDRS PROTO_SRCS src/caffe/caffe.proto)
  add_definitions(-DHAVE_PROTOBUF=1)
else()
  if(NOT PROTOBUF_FOUND)
    message(STATUS "libprotobuf not found")
  else()
    message(STATUS "The protocol buffer compiler not found")
  endif()

  include(cmake/libprotobuf.cmake)
  set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

  set(PROTOBUF_INCLUDE_DIR ${PROTOBUF_ROOT}/src  ${CMAKE_CURRENT_SOURCE_DIR}/src/caffe/compiled)
  list(APPEND PROTO_SRCS ${CMAKE_CURRENT_SOURCE_DIR}/src/caffe/compiled/caffe.pb.cc)
  set(PROTOBUF_LIBRARIES "")
  set(PROTOBUF_PROTOC_EXECUTABLE "")
  add_definitions(-DHAVE_PROTOBUF=1)
endif()