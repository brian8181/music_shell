cmake_minimum_required(VERSION 3.16)
project(wxHello CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Finds wxWidgets installed in /usr/local
find_package(wxWidgets REQUIRED COMPONENTS net core base)
include(${wxWidgets_USE_FILE})

add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE ${wxWidgets_LIBRARIES})

link_directories(/usr/local/lib)

target_link_libraries(wxHello PRIVATE
    ${wxWidgets_LIBRARIES}
    sqlite3
)