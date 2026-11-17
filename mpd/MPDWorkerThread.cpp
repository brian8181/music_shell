#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

// For compilers that support precompilation, includes "wx/wx.h".
#include "wx/wxprec.h"


#ifndef WX_PRECOMP
#include "wx/wx.h"
#endif

#include "../sample.xpm"

#include "wx/apptrait.h"
#include "wx/datetime.h"
#include "wx/filename.h"
#include "wx/image.h"
#include "wx/bookctrl.h"
#include "wx/artprov.h"
#include "wx/imaglist.h"
#include "wx/minifram.h"
#include "wx/sysopt.h"
#include "wx/notifmsg.h"
#include "wx/generic/notifmsg.h"
#include "wx/modalhook.h"

#if defined(__WXMSW__) && wxUSE_TASKBARICON
#include "wx/taskbar.h"
#endif

#if wxUSE_RICHMSGDLG
    #include "wx/richmsgdlg.h"
#endif // wxUSE_RICHMSGDLG

#if wxUSE_COLOURDLG
    #include "wx/colordlg.h"
#endif // wxUSE_COLOURDLG

#if wxUSE_CHOICEDLG
    #include "wx/choicdlg.h"
#endif // wxUSE_CHOICEDLG

// #include "wx/rearrangectrl.h"
// #include "wx/addremovectrl.h"

#if wxUSE_STARTUP_TIPS
    #include "wx/tipdlg.h"
#endif // wxUSE_STARTUP_TIPS

#if wxUSE_TIPWINDOW
    #include "wx/tipwin.h"
#endif // wxUSE_TIPWINDOW

#if wxUSE_PROGRESSDLG
#if wxUSE_STOPWATCH
    #include "wx/datetime.h"      // wxDateTime
#endif

    #include "wx/progdlg.h"
#endif // wxUSE_PROGRESSDLG

//#include "wx/appprogress.h"

#if wxUSE_ABOUTDLG
    #include "wx/aboutdlg.h"

    // these headers are only needed for custom about dialog
    #include "wx/statline.h"
    #include "wx/generic/aboutdlgg.h"
#endif // wxUSE_ABOUTDLG

#if wxUSE_BUSYINFO
    #include "wx/busyinfo.h"
#endif // wxUSE_BUSYINFO

#if wxUSE_NUMBERDLG
    #include "wx/numdlg.h"
#endif // wxUSE_NUMBERDLG

#if wxUSE_FILEDLG
    #include "wx/filedlg.h"
    #include "wx/filedlgcustomize.h"
#endif // wxUSE_FILEDLG

#if wxUSE_DIRDLG
    #include "wx/dirdlg.h"
#endif // wxUSE_DIRDLG

#if wxUSE_FONTDLG
    #include "wx/fontdlg.h"
#endif // wxUSE_FONTDLG

#if wxUSE_FINDREPLDLG
    #include "wx/fdrepdlg.h"
#endif // wxUSE_FINDREPLDLG

#if wxUSE_INFOBAR
    #include "wx/infobar.h"
#endif // wxUSE_INFOBAR

// #include "wx/spinctrl.h"
// #include "wx/propdlg.h"
// #include "wx/valgen.h"

//#include "dialogs.h"

#if wxUSE_CREDENTIALDLG
    #include "wx/creddlg.h"
#endif

#if USE_COLOURDLG_GENERIC
    #include "wx/generic/colrdlgg.h"
#endif // USE_COLOURDLG_GENERIC

#if USE_DIRDLG_GENERIC
    #include "wx/generic/dirdlgg.h"
#endif // USE_DIRDLG_GENERIC

#if USE_FILEDLG_GENERIC
    #include "wx/generic/filedlgg.h"
#endif // USE_FILEDLG_GENERIC

#if USE_FONTDLG_GENERIC
    #include "wx/generic/fontdlgg.h"
#endif // USE_FONTDLG_GENERIC


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
