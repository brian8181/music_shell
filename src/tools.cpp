#include <iostream>
#include "tools.hpp"
#include "regex.hpp"
#include "bash_color.hpp"

using namespace bkp;
using std::cout;
using std::endl;

unsigned char DEFAULTS = 0;
unsigned char option_flags = 0; 

void print_help()
{

}

int parse_options(int argc, char* argv[])
{
	cout << FMT_FG_BLUE << FMT_ITALIC << "Hello Template!" << FMT_RESET << endl;

	cout << "date_time = " << "\"" + date_time + "\"" << endl;
	cout << "precise_time = " << "\"" + precise_time + "\"" << endl;

	return 0;
}


