cmake_minimum_required(VERSION 3.16)

project(json_client VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_subdirectory(libs/nlohmann_json)

add_executable(json_client main.cpp)
target_link_libraries(json_client PRIVATE nlohmann_json::nlohmann_json)