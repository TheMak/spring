# This file is part of the Spring engine (GPL v2 or later), see LICENSE.html

# - Try to find some win32-only libraries needed to compile Spring
# Once done this will define
#
# WIN32_FOUND - System has the required libraries
# WIN32_LIBRARIES - Link these
#

SET(WIN32_FOUND TRUE)

IF(MINGW)
	SET(WIN32_LIBRARY_SEARCHPATHS
		$ENV{MINGDIR}/lib)
	# no point in searching for these on a proper mingw installation
	SET(IMAGEHLP_LIBRARY -limagehlp)
	SET(WS2_32_LIBRARY -lws2_32)
	SET(WINMM_LIBRARY -lwinmm)

ELSEIF(MINGW)
	SET(WIN32_LIBRARY_SEARCHPATHS
		/
		/usr/lib
		/usr/local/lib
		NO_DEFAULT_PATH)
	IF(NOT IMAGEHLP_LIBRARY)
		FIND_LIBRARY(IMAGEHLP_LIBRARY imagehlp PATHS ${WIN32_LIBRARY_SEARCHPATHS})
		IF(NOT IMAGEHLP_LIBRARY)
			MESSAGE(SEND_ERROR "Could not find win32 IMAGEHLP library.")
			SET(WIN32_FOUND FALSE)
		ENDIF(NOT IMAGEHLP_LIBRARY)
	ENDIF(NOT IMAGEHLP_LIBRARY)

	IF(NOT WS2_32_LIBRARY)
		FIND_LIBRARY(WS2_32_LIBRARY ws2_32 PATHS ${WIN32_LIBRARY_SEARCHPATHS})
		IF(NOT WS2_32_LIBRARY)
			MESSAGE(SEND_ERROR "Could not find win32 WS2_32 library.")
			SET(WIN32_FOUND FALSE)
		ENDIF(NOT WS2_32_LIBRARY)
	ENDIF(NOT WS2_32_LIBRARY)

	IF(NOT WINMM_LIBRARY)
		FIND_LIBRARY(WINMM_LIBRARY winmm PATHS ${WIN32_LIBRARY_SEARCHPATHS})
		IF(NOT WINMM_LIBRARY)
			MESSAGE(SEND_ERROR "Could not find win32 WINMM library.")
			SET(WIN32_FOUND FALSE)
		ENDIF(NOT WINMM_LIBRARY)
	ENDIF(NOT WINMM_LIBRARY)
ENDIF(MINGW)


IF(WIN32_FOUND)
	SET(WIN32_LIBRARIES
		${IMAGEHLP_LIBRARY} # for System/Platform/Win/CrashHandler.cpp
		${WS2_32_LIBRARY}	  # for System/Net/
		${WINMM_LIBRARY}
	)

	MESSAGE(STATUS "Found win32 libraries: ${WIN32_LIBRARIES}")
ENDIF(WIN32_FOUND)

MARK_AS_ADVANCED(
	IMAGEHLP_LIBRARY
	WS2_32_LIBRARY
	WINMM_LIBRARY
) 
