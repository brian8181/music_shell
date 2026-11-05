#!/bin/bash
g++ main.cpp $(wx-config --cxxflags --libs) -o custom-mpd-client
