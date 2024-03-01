// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// License:    GPL
// Author:     Brian K Preston
// File Name:  no file name
// Build Date: Wed Feb 14 11:29:22 AM CST 2024
// Version:    3.6.7

#include <iostream>
#include <string>
#include <getopt.h>
#include "bash_color.h"
#include "tools.hpp"
#include <set>

using namespace std;

int parse_options(int argc, char* argv[])
{
	std::set<char> a;
    a.insert('G');
    a.insert('F');
    a.insert('G');
    for (auto& str : a)
	{
        std::cout << str << ' ';
    }
    std::cout << '\n';
    return 0;
}
