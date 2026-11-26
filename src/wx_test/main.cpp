#include <wx/wx.h>

class MyApp : public wxApp {
public:
    bool OnInit() override {
        wxFrame* frame = new wxFrame(nullptr, wxID_ANY, "Hello World", wxDefaultPosition, wxSize(400, 300));
        new wxStaticText(frame, wxID_ANY, "Hello from wxWidgets on Fedora!", wxPoint(20, 20));
        frame->Show(true);
        return true;
    }
};

wxIMPLEMENT_APP(MyApp);

