#include <iostream>
#include <string>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <cstdlib>
#include <cstring>

void check_mpd() {
    // 1. Create a standard Unix domain stream socket
    int sock = socket(AF_UNIX, SOCK_STREAM, 0);
    if (sock < 0) {
        std::cerr << "Failed to create socket\n";
        return;
    }

    // 2. Set up the target address struct pointing to the socket file
    struct sockaddr_un addr{};
    addr.sun_family = AF_UNIX;
    
    std::string socket_path = std::string(std::getenv("HOME")) + "/.config/mpd/socket";
    strncpy(addr.sun_path, socket_path.c_str(), sizeof(addr.sun_path) - 1);

    // 3. Connect to the daemon
    if (connect(sock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
        std::cerr << "Connection failed. Is MPD running?\n";
        close(sock);
        return;
    }

    // 4. Read greeting protocol line
    char buffer[1024] = {0};
    ssize_t bytes_received = read(sock, buffer, sizeof(buffer) - 1);
    if (bytes_received > 0) {
        std::cout << "MPD Greeting: " << buffer; // Will print "OK MPD 0.x.x\n"
    }

    // 5. Send a command string (must terminate with \n)
    std::string cmd = "status\n";
    write(sock, cmd.c_str(), cmd.length());

    // 6. Read response buffer
    memset(buffer, 0, sizeof(buffer));
    bytes_received = read(sock, buffer, sizeof(buffer) - 1);
    if (bytes_received > 0) {
        std::cout << "\n--- MPD Response ---\n" << buffer;
    }

    // 7. Clean up connection context
    close(sock);
}

int main() {
    check_mpd();
    return 0;
}
