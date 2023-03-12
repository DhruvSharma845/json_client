#!/bin/sh

cd /json_client/

/usr/bin/cmake/bin/cmake -S . -B ./buildsystem/debug -DCMAKE_BUILD_TYPE=Debug
/usr/bin/cmake/bin/cmake --build ./buildsystem/debug