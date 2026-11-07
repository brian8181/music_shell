#!/bin/bash

# 1. Create and enter your clean build workflow folder
mkdir -p cbuild
cd cbuild

# 2. Configure the project and generate the underlying build system
cmake ..

# 3. Compile your native client binary
cmake --build .
