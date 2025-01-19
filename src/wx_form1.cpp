///////////////////////////////////////////////////////////////////////////
// C++ code generated with wxFormBuilder (version 4.2.1-52-g73f12a06-dirty)
// http://www.wxformbuilder.org/
//
// PLEASE DO *NOT* EDIT THIS FILE!
///////////////////////////////////////////////////////////////////////////

#include "MyProjectBase.h"

///////////////////////////////////////////////////////////////////////////

MyFrame::MyFrame( wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos, const wxSize& size, long style ) : wxFrame( parent, id, title, pos, size, style )
{
	this->SetSizeHints( wxDefaultSize, wxDefaultSize );

	wxGridSizer* gSizer1;
	gSizer1 = new wxGridSizer( 2, 2, 0, 0 );

	m_sdbSizer = new wxStdDialogButtonSizer();
	m_sdbSizerOK = new wxButton( this, wxID_OK );
	m_sdbSizer->AddButton( m_sdbSizerOK );
	m_sdbSizerCancel = new wxButton( this, wxID_CANCEL );
	m_sdbSizer->AddButton( m_sdbSizerCancel );
	m_sdbSizer->Realize();

	gSizer1->Add( m_sdbSizer, 1, wxEXPAND, 5 );

	m_button = new wxButton( this, wxID_ANY, _("MyButton"), wxDefaultPosition, wxDefaultSize, 0 );
	gSizer1->Add( m_button, 0, wxALL, 5 );


	this->SetSizer( gSizer1 );
	this->Layout();

	this->Centre( wxBOTH );
}

MyFrame::~MyFrame()
{
}
