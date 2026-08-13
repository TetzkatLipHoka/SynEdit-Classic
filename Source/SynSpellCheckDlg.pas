unit SynSpellCheckDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TCheckWordDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Edit1: TEdit;
    ListBox1: TListBox;
    Label4: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Edit3: TEdit;
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CheckWordDlg: TCheckWordDlg;

implementation

{$R *.dfm}

procedure TCheckWordDlg.ListBox1Click(Sender: TObject);
begin
  if ListBox1.Itemindex > 0 then
    Edit3.Text := ListBox1.Items[ListBox1.Itemindex];
end;

end.
