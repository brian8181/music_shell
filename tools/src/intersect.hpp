// License:    None
// Author:     Brian K Preston
// File Name:  intersect.cpp
// Build Date: Wed Feb 14 04:03:20 PM CST 2024
// Version:    0.0.1

#ifndef __intersect_HPP
#define __intersect_HPP
using std::string;

void print_help();
void print_match_header(const string& pattern, const string& src, const bool single_flag, const bool pretty_flag);
int parse_options(int argc, char* argv[]);

#endif
