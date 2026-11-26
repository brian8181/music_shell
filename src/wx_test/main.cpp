#include <cstdlib>
#include <string>
#include <vector>
#include <wx/wx.h>
#include <wx/grid.h>
#include <sqlite3.h>

class MainFrame : public wxFrame {
public:
    MainFrame() : wxFrame(nullptr, wxID_ANY, "Music DB Grid", wxDefaultPosition, wxSize(800, 400)) {
        wxGrid* grid = new wxGrid(this, wxID_ANY);
        grid->CreateGrid(0, 0);
        grid->EnableEditing(false); // Read-only view

        // Resolve ~/db/music.db
        const char* home = std::getenv("HOME");
        if (!home) {
            wxMessageBox("HOME environment variable not set.", "Error", wxOK | wxICON_ERROR);
            return;
        }
        std::string dbPath = std::string(home) + "/db/music.db";

        sqlite3* db = nullptr;
        if (sqlite3_open_v2(dbPath.c_str(), &db, SQLITE_OPEN_READONLY, nullptr) != SQLITE_OK) {
            wxMessageBox(wxString::Format("Cannot open database:\n%s", sqlite3_errmsg(db)),
                         "Database Error", wxOK | wxICON_ERROR);
            return;
        }

        // Prepare query (adjust LIMIT or table/columns as needed)
        const char* sql = "SELECT * FROM cash LIMIT 5;";
        sqlite3_stmt* stmt = nullptr;

        if (sqlite3_prepare_v2(db, sql, -1, &stmt, nullptr) != SQLITE_OK) {
            wxMessageBox(wxString::Format("SQL error:\n%s", sqlite3_errmsg(db)),
                         "Query Error", wxOK | wxICON_ERROR);
            sqlite3_close(db);
            return;
        }

        // Dynamically create grid columns based on SQLite result columns
        int colCount = sqlite3_column_count(stmt);
        grid->AppendCols(colCount);
        for (int c = 0; c < colCount; ++c) {
            const char* colName = sqlite3_column_name(stmt, c);
            grid->SetColLabelValue(c, wxString::FromUTF8(colName ? colName : ""));
        }

        // Populate rows
        int row = 0;
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            grid->AppendRows(1);
            for (int c = 0; c < colCount; ++c) {
                const unsigned char* text = sqlite3_column_text(stmt, c);
                grid->SetCellValue(row, c, wxString::FromUTF8(text ? reinterpret_cast<const char*>(text) : ""));
            }
            ++row;
        }

        sqlite3_finalize(stmt);
        sqlite3_close(db);

        // Auto-fit column widths to content
        grid->AutoSizeColumns();
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
