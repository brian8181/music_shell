#ifndef _msql_HPP
#define _msql_HPP
#include <string>

using std::string;

class msql
{
public:
    msql();
    ~msql();

    bool open(string path);
    bool open(string sql_path, string sql_stmt);
    bool close();
    void callback();
    bool query(string query);

private:

};

#endif

