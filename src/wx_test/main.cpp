#include <cstdlib>
#include <string>
#include <wx/wx.h>
#include <wx/grid.h>
#include <sqlite3.h>

class MainFrame : public wxFrame {
public:
    MainFrame() : wxFrame(nullptr, wxID_ANY, "Music DB Search", wxDefaultPosition, wxSize(900, 500)) {
        wxPanel* panel = new wxPanel(this);
        wxBoxSizer* mainSizer = new wxBoxSizer(wxVERTICAL);

        // Top Search Bar
        wxBoxSizer* searchSizer = new wxBoxSizer(wxHORIZONTAL);
        m_searchBox = new wxTextCtrl(panel, wxID_ANY, "", wxDefaultPosition, wxDefaultSize, wxTE_PROCESS_ENTER);
        m_searchBox->SetHint("Search artist, album, or title...");
        wxButton* searchBtn = new wxButton(panel, wxID_ANY, "Search");

        searchSizer->Add(m_searchBox, 1, wxEXPAND | wxRIGHT, 6);
        searchSizer->Add(searchBtn, 0);

        // Results Grid
        m_grid = new wxGrid(panel, wxID_ANY);
        m_grid->CreateGrid(0, 0);
        m_grid->EnableEditing(false);

        mainSizer->Add(searchSizer, 0, wxEXPAND | wxALL, 8);
        mainSizer->Add(m_grid, 1, wxEXPAND | wxLEFT | wxRIGHT | wxBOTTOM, 8);
        panel->SetSizer(mainSizer);

        // Bind both Enter key and Search button
        m_searchBox->Bind(wxEVT_TEXT_ENTER, &MainFrame::OnSearch, this);
        searchBtn->Bind(wxEVT_BUTTON, &MainFrame::OnSearch, this);

        // Open ~/db/music.db once at startup
        const char* home = std::getenv("HOME");
        if (!home) {
            wxMessageBox("HOME environment variable not set.", "Error", wxOK | wxICON_ERROR);
            return;
        }
        std::string dbPath = std::string(home) + "/db/music.db";

        if (sqlite3_open_v2(dbPath.c_str(), &m_db, SQLITE_OPEN_READONLY, nullptr) != SQLITE_OK) {
            wxMessageBox(wxString::Format("Cannot open database:\n%s", sqlite3_errmsg(m_db)),
                         "Database Error", wxOK | wxICON_ERROR);
            m_db = nullptr;
            return;
        }

        // Initial load (first 25 rows)
        RunSearch("");
    }

    ~MainFrame() override {
        if (m_db) {
            sqlite3_close(m_db);
        }
    }

private:
    sqlite3* m_db = nullptr;
    wxTextCtrl* m_searchBox = nullptr;
    wxGrid* m_grid = nullptr;

    void OnSearch(wxCommandEvent&) {
        RunSearch(m_searchBox->GetValue());
    }

    void RunSearch(const wxString& keyword) {
        if (!m_db) return;

        // Clear existing grid data
        if (m_grid->GetNumberRows() > 0) m_grid->DeleteRows(0, m_grid->GetNumberRows());
        if (m_grid->GetNumberCols() > 0) m_grid->DeleteCols(0, m_grid->GetNumberCols());

        // Use parameterized LIKE query (case-insensitive for ASCII in SQLite)
        const char* sql = keyword.IsEmpty()
            ? "SELECT artist, album, title FROM cash LIMIT 25;"
            : "SELECT artist, album, title FROM cash "
              "WHERE artist LIKE ?1 OR album LIKE ?1 OR title LIKE ?1 "
              "LIMIT 500;";

        sqlite3_stmt* stmt = nullptr;
        if (sqlite3_prepare_v2(m_db, sql, -1, &stmt, nullptr) != SQLITE_OK) {
            wxMessageBox(wxString::Format("SQL error:\n%s", sqlite3_errmsg(m_db)),
                         "Query Error", wxOK | wxICON_ERROR);
            return;
        }

        std::string pattern;
        if (!keyword.IsEmpty()) {
            pattern = "%" + std::string(keyword.utf8_string()) + "%";
            sqlite3_bind_text(stmt, 1, pattern.c_str(), -1, SQLITE_STATIC);
        }

        int colCount = sqlite3_column_count(stmt);
        m_grid->AppendCols(colCount);
        for (int c = 0; c < colCount; ++c) {
            const char* colName = sqlite3_column_name(stmt, c);
            m_grid->SetColLabelValue(c, wxString::FromUTF8(colName ? colName : ""));
        }

        int row = 0;
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            m_grid->AppendRows(1);
            for (int c = 0; c < colCount; ++c) {
                const unsigned char* text = sqlite3_column_text(stmt, c);
                m_grid->SetCellValue(row, c, wxString::FromUTF8(text ? reinterpret_cast<const char*>(text) : ""));
            }
            ++row;
        }

        sqlite3_finalize(stmt);
        m_grid->AutoSizeColumns();
        m_grid->ForceRefresh();
    }
};

class MyApp : public wxApp {
public:
    bool OnInit() override {
        MainFrame* frame = new MainFrame();
        frame->Show(true);
        return true;
    }
};

wxIMPLEMENT_APP(MyApp);
