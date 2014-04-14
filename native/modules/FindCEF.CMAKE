# -*- cmake -*-

find_path(CEF_INCLUDE_DIR 
    NAMES "include/cef_app.h"
    PATHS ../../Includes/cef
  )

find_library(CEF_LIBRARY
  NAMES "Chromium Embedded Framework"
  PATHS ../../Frameworks
  )

find_library(CEF_WRAPPER_LIBRARY
  NAMES "libcef_dll_wrapper.a"
  PATHS ../../Libraries
  )

SET(CEF_INCLUDE_DIRS ${CEF_INCLUDE_DIR})
set(CEF_LIBRARIES ${CEF_LIBRARY} ${CEF_WRAPPER_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(CEF DEFAULT_MSG CEF_LIBRARIES CEF_INCLUDE_DIRS)
mark_as_advanced( CEF_INCLUDE_DIRS CEF_LIBRARIES )

