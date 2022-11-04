#include <iostream>
#include <string>
#include <iomanip>
#include <stdio.h>

#include <taglib/fileref.h>
#include <taglib/tag.h>

#include <getopt.h>
#include "bash_color.hpp"

using namespace std;

const int DEFAULT_ARGC = 1;

static struct option long_options[] =
{
    {"verbose", no_argument, 0, 'v'},
    {"help", no_argument, 0, 'h'},
    {"album", no_argument, 0, 'a'},
    {"artist", no_argument, 0, 'r'},
    {"track", no_argument, 0, 't'},
    {"disc", no_argument, 0, 'd'},
    {"title", no_argument, 0, 'n'},
    {"year", no_argument, 0, 'y'},
    {"genre", no_argument, 0, 'g'}
};

/*
 tag [opts] [INPUT] ... ]
*/

void print_tags(int argc, char *argv[], bool verbose);
void print_help();

int main(int argc, char *argv[])
{
    int opt = 0;
    int option_index = 0;
    bool verbose_flag = false;
    
    optind = 0;
    while((opt = getopt_long(argc, argv, "hvartdnyg", long_options, &option_index)) != -1)
    {
        switch (opt)
        {
        case 'h':
            print_help();
            return 0;
        case 'v':
            verbose_flag = true;
            break;
        default: // unknown option before args
            fprintf(stderr, "Unexpected option, -h for help\n");
            return EXIT_FAILURE;
        }
    }
 
    if (optind != (argc - DEFAULT_ARGC)) // not correct number of args
    {
        fprintf(stderr, "Expected argument after options, -h for help\n");
        exit(EXIT_FAILURE);
    }
          
    if (verbose_flag)
    {
        print_help();
    }

    print_tags(argc, argv, verbose_flag);
}

void print_tags(int argc, char *argv[], bool verbose)
{
    for(int i = 1; i < argc; i++)
    {
        TagLib::FileRef f(argv[i]);
        if(!f.isNull() && f.tag())
        {
            TagLib::Tag *tag = f.tag();

            if(verbose)
            {
                cout << "******************** \"" << argv[i] << "\" ********************" << endl;
                cout << "-- TAG (basic) --" << endl;
                cout << "title   - \"" << tag->title()   << "\"" << endl;
                cout << "artist  - \"" << tag->artist()  << "\"" << endl;
                cout << "album   - \"" << tag->album()   << "\"" << endl;
                cout << "year    - \"" << tag->year()    << "\"" << endl;
                cout << "comment - \"" << tag->comment() << "\"" << endl;
                cout << "track   - \"" << tag->track()   << "\"" << endl;
                cout << "genre   - \"" << tag->genre()   << "\"" << endl;
            }
            else
            {
                cout <<  tag->track() << "," << tag->artist() << ',' << tag->album() << ',' << tag->year() << ',' << tag->title() << ',' << tag->genre() << endl << "COMMENT";
            }
        }
    }
}

void print_help()
{
    cout << "\n"
         << FMT_BOLD << "tag" << FMT_RESET << " "
         << "[OPTIONS] "
         << FMT_UNDERLINE << "[INPUT ...]" << FMT_RESET << "\n\n";
}
