#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

class MPDWorkerThread : public wxThread {
public:
    MPDWorkerThread(wxEvtHandler* handler) : wxThread(wxTHREAD_DETACHED), m_handler(handler) {}

protected:
    virtual ExitCode Entry() override {
        int sock = socket(AF_UNIX, SOCK_STREAM, 0);
        if (sock < 0) return (ExitCode)0;

        struct sockaddr_un addr{};
        addr.sun_family = AF_UNIX;
        
        // Pointing to your local configuration socket path
        std::string socket_path = std::string(std::getenv("HOME")) + "/.config/mpd/socket";
        std::strncpy(addr.sun_path, socket_path.c_str(), sizeof(addr.sun_path) - 1);

        if (connect(sock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
            close(sock);
            return (ExitCode)0;
        }

        // Consume the greeting line: "OK MPD 0.x.x\n"
        char greeting_buf[128] = {0};
        read(sock, greeting_buf, sizeof(greeting_buf) - 1);

        // Loop to continuously process a command or run 'idle' monitoring
        while (!TestDestroy()) {
            // Example: Requesting a status block
            std::string cmd = "status\n";
            write(sock, cmd.c_str(), cmd.length());

            std::string response;
            char read_buf[256];
            
            // Read lines until we hit the "OK" protocol terminator
            while (true) {
                std::memset(read_buf, 0, sizeof(read_buf));
                ssize_t n = read(sock, read_buf, sizeof(read_buf) - 1);
                if (n <= 0) break;
                
                response += read_buf;
                if (response.find("\nOK\n") != std::string::npos || response.find("ACK") != std::string::npos) {
                    break;
                }
            }

            // Fire an event to ship the raw text payload safely to the GUI thread
            wxThreadEvent* event = new wxThreadEvent(wxEVT_MPD_UPDATE);
            event->SetString(wxString::FromUTF8(response.c_str()));
            wxQueueEvent(m_handler, event);

            // Sleep temporarily or handle block listening here
            wxMilliSleep(2000); 
        }

        close(sock);
        return (ExitCode)0;
    }

private:
    wxEvtHandler* m_handler;
};
