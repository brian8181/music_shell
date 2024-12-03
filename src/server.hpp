#ifndef _server_HPP
#define _server_HPP
#include <string>

using std::string;

class server 
{
public:
    server();
    ~server();

    bool connect();
    bool disconnect();
    bool command(string command);

private:
};

#endif