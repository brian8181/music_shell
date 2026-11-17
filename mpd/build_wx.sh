#!/bin/bash
g++ --std=c++17 main.cpp $(wx-config --cxxflags --libs) -o custom-mpd-client
