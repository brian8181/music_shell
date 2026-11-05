cmake_minimum_required(VERSION 3.16)
project(CustomMPDClient VERSION 1.0.0 LANGUAGES CXX)

# Force the C++17 standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Add rigid warning flags for development quality
if(MSVC)
    add_compile_options(/W4)
else()
    add_compile_options(-Wall -Wextra)
endif()

# Find the wxWidgets package installed on Fedora
# Requesting core, base, and net (useful for networking/sockets)
find_package(wxWidgets REQUIRED COMPONENTS core base net)
include(${wxWidgets_USE_FILE})

# Gather all source files inside the src/ directory
file(GLOB_RECURSE SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")

# Define the final executable target
add_executable(custom-mpd-client ${SOURCES})

# Safely link wxWidgets components and include directories
target_link_libraries(custom-mpd-client PRIVATE ${wxWidgets_LIBRARIES})

