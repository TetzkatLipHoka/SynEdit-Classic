unit SynSpellCheckOpDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SynSpellCheck, FileCtrl;

type
  TSpellCheckOpForm = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(SpellCheck : TSynSpellCheck);
  end;

var
  SpellCheckOpForm: TSpellCheckOpForm;

implementation

{$R *.dfm}

procedure TSpellCheckOpForm.Button1Click(Sender: TObject);
var
  s : string;
begin
  S := Edit1.Text;
  if SelectDirectory(s, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) then
    Edit1.Text  := s;
end;

procedure TSpellCheckOpForm.Button2Click(Sender: TObject);
var
  s : string;
begin
  S := Edit2.Text;
  if SelectDirectory(s, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) then
    Edit2.Text  := s;
end;

procedure TSpellCheckOpForm.Execute(SpellCheck: TSynSpellCheck);
var
  S : TStrings;
begin
  Edit1.Text := SpellCheck.DictionaryPath;
  Edit2.Text := SpellCheck.UserDirectory;
  s := TStringList.Create;
  try
    SpellCheck.GetDictionaryList(TStringList(S));
    ComboBox1.Items := s;
    ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(SpellCheck.Dictionary)
  finally
    s.Free;
  end;
  CheckBox1.Checked := sscoAutoSpellCheck in SpellCheck.Options;
  CheckBox2.Checked := sscoIgnoreSingleChars in SpellCheck.Options;
  CheckBox3.Checked := sscoIgnoreWordsWithNumbers in SpellCheck.Options;
  CheckBox4.Checked := sscoSuggestWords in SpellCheck.Options;
  CheckBox5.Checked := sscoMaintainCase in SpellCheck.Options;
  CheckBox6.Checked := sscoStartFromCursor in SpellCheck.Options;
  if ShowModal = mrok then
  begin
    SpellCheck.DictionaryPath := Edit1.Text;
    SpellCheck.UserDirectory := Edit2.Text;
    if SpellCheck.Dictionary <> ComboBox1.Text then
      SpellCheck.LoadDictionary(ComboBox1.Text);
    if CheckBox1.Checked then
      SpellCheck.Options := SpellCheck.Options + [sscoAutoSpellCheck] else
      SpellCheck.Options := SpellCheck.Options - [sscoAutoSpellCheck];
    if CheckBox2.Checked then
      SpellCheck.Options := SpellCheck.Options + [sscoIgnoreSingleChars ] else
      SpellCheck.Options := SpellCheck.Options - [sscoIgnoreSingleChars ];
    if CheckBox3.Checked then
      SpellCheck.Options := SpellCheck.Options + [sscoIgnoreWordsWithNumbers ] else
      SpellCheck.Options := SpellCheck.Options - [sscoIgnoreWordsWithNumbers ];
    if CheckBox4.Checked then
      SpellCheck.Options := SpellCheck.Options + [sscoSuggestWords ] else
      SpellCheck.Options := SpellCheck.Options - [sscoSuggestWords ];
    if CheckBox5.Checked then
      SpellCheck.Options := SpellCheck.Options + [sscoMaintainCase ] else
      SpellCheck.Options := SpellCheck.Options - [sscoMaintainCase ];
    if CheckBox6.Checked then
      SpellCheck.Options := SpellCheck.Options + [sscoStartFromCursor ] else
      SpellCheck.Options := SpellCheck.Options - [sscoStartFromCursor ];
  end;
end;

end.
