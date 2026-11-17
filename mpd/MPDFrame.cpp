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

#include "wx/rearrangectrl.h"
#include "wx/addremovectrl.h"

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

#include "wx/appprogress.h"

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

#include "wx/spinctrl.h"
#include "wx/propdlg.h"
#include "wx/valgen.h"

#include "dialogs.h"

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

class MPDFrame : public wxFrame {
public:
    MPDFrame() : wxFrame(NULL, wxID_ANY, "Custom MPD Client", wxDefaultPosition, wxSize(400, 200)) {
        // Simple UI Layout
        wxPanel* panel = new wxPanel(this, wxID_ANY);
        m_statusText = new wxTextCtrl(panel, wxID_ANY, "Connecting...", wxDefaultPosition, wxDefaultSize, wxTE_MULTILINE | wxTE_READONLY);
        
        wxBoxSizer* sizer = new wxBoxSizer(wxVERTICAL);
        sizer->Add(m_statusText, 1, wxEXPAND | wxALL, 10);
        panel->SetSizer(sizer);

        // Bind the background socket thread event to our handler
        Bind(wxEVT_MPD_UPDATE, &MPDFrame::OnMPDUpdate, this);

        // Launch our detached worker thread safely
        MPDWorkerThread* thread = new MPDWorkerThread(this);
        if (thread->Run() != wxTHREAD_NO_ERROR) {
            m_statusText->SetValue("Error: Could not spin up protocol thread.");
        }
    }

private:
    void OnMPDUpdate(wxThreadEvent& event) {
        // Raw MPD payload arrives completely thread-safe here
        wxString rawPayload = event.GetString();
        
        // For a full GUI, you'll parse individual lines (e.g., checking "state: play")
        // For now, let's print the direct dump into our text window
        m_statusText->SetValue(rawPayload);
    }

    wxTextCtrl* m_statusText;
};

// Standard application initialization boilerplate
class MPDApp : public wxApp {
public:
    virtual bool OnInit() override {
        MPDFrame* frame = new MPDFrame();
        frame->Show(true);
        return true;
    }
};

wxIMPLEMENT_APP(MPDApp);
