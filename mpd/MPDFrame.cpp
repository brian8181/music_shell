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
