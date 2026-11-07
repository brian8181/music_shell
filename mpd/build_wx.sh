#!/bin/bash
g++ --std=c++17 test_client.cpp $(wx-config --cxxflags --libs) -o custom-mpd-client
