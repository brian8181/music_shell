#include <wx/wx.h>

// 1. Declare a custom event ID for MPD status updates
wxDEFINE_EVENT(wxEVT_MPD_UPDATE, wxThreadEvent);