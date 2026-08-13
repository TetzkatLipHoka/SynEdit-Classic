{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: SynUniHighlighter.pas, released 2003-01
All Rights Reserved.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

{
@abstract(Desginer for TSynUniSyn)
@authors(Vit [nevzorov@yahoo.com], Fantasist [walking_in_the_sky@yahoo.com],
         Vitalik [vetal-x@mail.ru])
@created(2003)
@lastmod(2006-07-23)
}

(******************************************************************************
Authors: Vit (Vitaly Nevzorov nevzorov@yahoo.com)
         Fantasist (Kirill Burtsev walking_in_the_sky@yahoo.com)
         Vitalik (Vitaly Lyapota vetal-x@mail.ru)
Official Site: www.delphist.com
With all questions, please visit www.delphist.com/forum
******************************************************************************)

unit SynUniDesignerForm;

//{$DEFINE SYNPLUS} //*SCHMaster*//

{$I SynUniHighlighter.inc}

interface

uses
{$IFDEF SYN_CLX}
  Types, kTextDrawer, QGraphics, QControls, QForms, QExtCtrls, QStdCtrls,
  QComCtrls, QImgList, QDialogs, QMenus,
{$ELSE}
  Windows, Messages, Graphics, Registry, Controls, Forms, ExtCtrls, StdCtrls,
  ComCtrls, Dialogs, Menus,
{$ENDIF}
  {$IFDEF SYN_CodeFolding}SynEditCodeFolding, SynEditMiscClasses, {$ENDIF}
  Classes, SysUtils, SynEdit, SynEditHighlighter, SynUniHighlighter,
  SynUniClasses, SynUniRules, Clipbrd, ImgList, Inifiles, Buttons,
  SynUniFormat, SynUniFormatEditPlus, SynUniFormatUltraEdit,
  SynUniColorBoxDataModule, SynUniColorBox;

const
  _Root = 'SyntaxColoring';
  _New = 'New';

type
{$IFDEF SYN_CLX}
  TNodeText = WideString;
{$ELSE}
  TNodeText = string;
{$ENDIF}

  TNodeType = (ntInfo, {$IFDEF CUSTOMDATA}ntCustomData,{$ENDIF}
               ntRangeLink, ntRange, ntRoot, ntKeywords, ntSet,
               {$IFDEF SYN_CodeFolding}ntFoldRoot, ntFoldRegion, ntSkipRegion,{$ENDIF} ntNone);
  TAddKind = (akAdd, akInsert, akReplace);
  TRangeType = (rtRange, rtRoot, rtLink);

  TfmDesigner = class(TForm)
    //==================== P O P U P  M E N U S ==============================
    //=== popStandard ========================================================
    popStandard: TPopupMenu;
    popUndo: TMenuItem;
    N1: TMenuItem;
    popCut: TMenuItem;
    popCopy: TMenuItem;
    popPaste: TMenuItem;
    popDelete: TMenuItem;
    N2: TMenuItem;
    popSelectAll: TMenuItem;
    //=== popSampleMemoMenu ==================================================
    popSampleMemoMenu: TPopupMenu;
    AddselectedtoKeywords1: TMenuItem;
    N7: TMenuItem;
    Undo1: TMenuItem;
    N5: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    N6: TMenuItem;
    SelectAll1: TMenuItem;
    //=== popOpenTagMenu =====================================================
    popOpenTagMenu: TPopupMenu;
    Closemenu1: TMenuItem;
    N3: TMenuItem;
    miOpenTagFirstOnLine: TMenuItem;
    miOpenTagFirstNonSpaceOnLine: TMenuItem;
    N4: TMenuItem;
    miOpenTagPartOfTerm1: TMenuItem;
    miOpenTagPartOfTerm2: TMenuItem;
    miOpenTagPartOfTerm3: TMenuItem;
    miOpenTagPartOfTerm4: TMenuItem;
    //=== popCloseTagMenu ====================================================
    popCloseTagMenu: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    miCloseTagFirstOnLine: TMenuItem;
    miCloseTagFirstNonSpaceOnLine: TMenuItem;
    MenuItem5: TMenuItem;
    miCloseTagPartOfTerm1: TMenuItem;
    miCloseTagPartOfTerm2: TMenuItem;
    miCloseTagPartOfTerm3: TMenuItem;
    miCloseTagPartOfTerm4: TMenuItem;
    //=== popRootMenu ========================================================
    popRootMenu: TPopupMenu;
    rootCut: TMenuItem;
    rootCopy: TMenuItem;
    rootPaste: TMenuItem;
    rootPasteAndReplace: TMenuItem;
    rootBreak1: TMenuItem;
    rootLoadFromFile: TMenuItem;
    rootSaveToFile: TMenuItem;
    rootBreak2: TMenuItem;
    rootAddRange: TMenuItem;
    rootAddKeywords: TMenuItem;
    rootAddSetto: TMenuItem;
    rootBreak3: TMenuItem;
    rootRename: TMenuItem;
    rootDeleteAll: TMenuItem;
    rootBreak4: TMenuItem;
    rootInfo: TMenuItem;    
    //=== popRangeMenu =======================================================
    popRangeMenu: TPopupMenu;
    rangeBack: TMenuItem;
    rangeBreak1: TMenuItem;
    rangeCut: TMenuItem;
    rangeCopy: TMenuItem;
    rangePaste: TMenuItem;
    rangePasteAndReplace: TMenuItem;
    rangePasteNextTo: TMenuItem;
    rangeBreak2: TMenuItem;
    rangeLoadFromFile: TMenuItem;
    rangeSaveToFile: TMenuItem;
    rangeBreak3: TMenuItem;
    rangeAddRange: TMenuItem;
    rangeAddKeywords: TMenuItem;
    rangeAddSet: TMenuItem;
    rangeBreak4: TMenuItem;
    rangeRename: TMenuItem;
    rangeDelete: TMenuItem;
    //=== popKeywordsMenu ====================================================
    popKeywordsMenu: TPopupMenu;
    keywordsBack: TMenuItem;
    keywordsBreak1: TMenuItem;
    keywordsCut: TMenuItem;
    keywordsCopy: TMenuItem;
    keywordsPaste: TMenuItem;
    keywordsPasteAndReplace: TMenuItem;
    keywordsBreak2: TMenuItem;
    keywordsLoadFromFile: TMenuItem;
    keywordsSaveToFile: TMenuItem;
    keywordsBreak3: TMenuItem;
    keywordsRename: TMenuItem;
    keywordsDelete: TMenuItem;
    //=== popSetMenu =========================================================
    popSetMenu: TPopupMenu;
    setBack: TMenuItem;
    setBreak1: TMenuItem;
    setCut: TMenuItem;
    setCopy: TMenuItem;
    setPaste: TMenuItem;    
    setPasteAndReplace: TMenuItem;
    setBreak2: TMenuItem;
    setLoadFromFile: TMenuItem;
    setSaveToFile: TMenuItem;
    setBreak3: TMenuItem;
    setRename: TMenuItem;
    setDelete: TMenuItem;
    //=== popPanels ==========================================================
    popPanels: TPopupMenu;
    miRulesTree: TMenuItem;
    miProperties: TMenuItem;
    miAttributes: TMenuItem;
    miSampleText: TMenuItem;
    miButtons: TMenuItem;
    //===================== C O M P O N E N T S ==============================
    //=== Top panel ==========================================================
    pTop: TPanel;
    SplitterBottom: TSplitter;
    //=== Panel "Rules' Tree" ================================================
    pLeft: TPanel;
    SplitterLeft: TSplitter;
    pLeftParentCapt: TPanel;
    lbRootMenu: TLabel;
    pLeftCapt: TPanel;
    Bevel1: TBevel;
    pTree: TPanel;
    Tree: TTreeView;
    //=== Panel "Attributes" =================================================
    pRight: TPanel;
    SplitterRight: TSplitter;
    pRightCapt: TPanel;
    Bevel2: TBevel;
    pAttri: TPanel;
    //=== Panel "Proprties" ==================================================
    pMiddle: TPanel;
    pMiddleParentCapt: TPanel;
    lbPropBack: TLabel;
    lbRuleMenu: TLabel;
    pMiddleCapt: TPanel;
    Bevel4: TBevel;
    //=== "Root" page ========================================================
    PageControl: TPageControl;
    tabRoot: TTabSheet;
    chCaseRoot: TCheckBox;
    chEnabledRoot: TCheckBox;
    lbDelimitersRoot: TLabel;
    edDelimitersRoot: TEdit;
    pRootButtons: TPanel;
    btAddRangeRoot: TButton;
    btAddKeywordsRoot: TButton;
    btAddSetRoot: TButton;
    //=== "Range" page =======================================================
    tabRange: TTabSheet;
    chCaseRange: TCheckBox;
    chEnabledRange: TCheckBox;
    btMultiTags: TButton;
    lbRangeFrom: TLabel;
    edFrom: TEdit;
    btFromMenu: TButton;
    chFromEOL: TCheckBox;
    lbRangeTo: TLabel;
    edTo: TEdit;
    btToMenu: TButton;
    chToEOL: TCheckBox;
    chCloseOnWord: TCheckBox;
    chCloseOnEOL: TCheckBox;
    chCloseParent: TCheckBox;
    lbDelimitersRange: TLabel;
    edDelimitersRange: TEdit;
    pRangeButtons: TPanel;
    btAddRange: TButton;
    btAddKeywords: TButton;
    btAddSet: TButton;
    //=== "Keywords" page ====================================================
    tabKeywords: TTabSheet;
    Memo: TMemo;
    pProp: TPanel;
    chEnabledKeyList: TCheckBox;
    btSort_old: TButton;
    btLowerCase_old: TButton;
    btSpacesToEol_old: TButton;
    lbKeywordCount: TLabel;
    //=== "Set" page =========================================================
    tabSet: TTabSheet;
    chAnyStart: TCheckBox;
    chEnabledSet: TCheckBox;
    lbSymbSet: TLabel;
    edSymbSet: TEdit;
    //=== Panel "Sample text" ================================================
    pBottom: TPanel;
    pBottomParentCapt: TPanel;
    lbSampMin: TLabel;
    lbSampMax: TLabel;
    pBottomCapt: TPanel;
    Bevel5: TBevel;
    SampleMemo: TSynEdit;
    //=== Panel with "finish" buttons ========================================
    StatusBar: TStatusBar;
    pButtons: TPanel;
    SplitterButtons: TSplitter;
    btOk: TButton;
    btCancel: TButton;
    btApply: TButton;
    //=== Invisible components ===============================================
    SynUniSyn: TSynUniSyn;
    listImages: TImageList;
    listRules: TImageList;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    tabSeveralRules: TTabSheet;
    Label1: TLabel;
    btSort: TSpeedButton;
    btLowerCase: TSpeedButton;
    btSpacesToEol: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chStrikeOut: TCheckBox;
    chUnderline: TCheckBox;
    chItalic: TCheckBox;
    chBold: TCheckBox;
    chForeground: TCheckBox;
    chBackground: TCheckBox;
    TabSheet2: TTabSheet;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    Button1: TButton;
    CheckBox8: TCheckBox;
    Bevel6: TBevel;
    cbStyle: TComboBox;
    Label2: TLabel;
    Label4: TLabel;
    Button3: TButton;
    Label6: TLabel;
    tabFoldRoot: TTabSheet;
    tabFoldRegion: TTabSheet;
    Label7: TLabel;
    Label8: TLabel;
    rbChar: TRadioButton;
    rbKeyword: TRadioButton;
    Label9: TLabel;
    Label10: TLabel;
    edOpen: TEdit;
    edClose: TEdit;
    chAddKeyword: TCheckBox;
    chNoSubFolds: TCheckBox;
    chWholeWords: TCheckBox;
    edOpenRegExpr: TEdit;
    edCloseRegExpr: TEdit;
    chUseOpenRegExpr: TCheckBox;
    chUseCloseRegExpr: TCheckBox;
    popFoldRegionMenu: TPopupMenu;
    Uptoonelevel1: TMenuItem;
    N8: TMenuItem;
    AddRange1: TMenuItem;
    N9: TMenuItem;
    RenameRange1: TMenuItem;
    DeleteRange1: TMenuItem;
    popFoldRootMenu: TPopupMenu;
    MenuItem12: TMenuItem;
    Button2: TButton;
    Label11: TLabel;
    popMultiTags: TPopupMenu;
    N10: TMenuItem;
    Addcoupletags1: TMenuItem;
    Deletecoupletags1: TMenuItem;
    miSomeTag: TMenuItem;
    Closemenu2: TMenuItem;
    N12: TMenuItem;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Edit1: TEdit;
    Label15: TLabel;
    udQuantity: TUpDown;
    Label16: TLabel;
    lbFormatVersion: TLabel;
    tabInfo: TTabSheet;
    tabStyles: TTabSheet;
    Label3: TLabel;
    Label5: TLabel;
    edStylesFile: TEdit;
    btStylesFile: TButton;
    ComboBox2: TComboBox;
    Button4: TButton;
    GroupBox2: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edName: TEdit;
    edExtensions: TEdit;
    edAuthor: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    edEmail: TEdit;
    edWeb: TEdit;
    edCopyright: TEdit;
    edCompany: TEdit;
    edRemark: TEdit;
    Label26: TLabel;
    edVersion: TEdit;
    edRevision: TEdit;
    udVersion: TUpDown;
    udRevision: TUpDown;
    Label28: TLabel;
    popInfoMenu: TPopupMenu;
    frBackColor: TFrameColor;
    frForeColor: TFrameColor;
    frSelectBackColor: TFrameColor;
    frSelectForeColor: TFrameColor;
    frActiveLineColor: TFrameColor;
    tabCustomData: TTabSheet;
    mmCustomData: TMemo;
    btAdd: TButton;
    btDelete: TButton;
    popCustomDataMenu: TPopupMenu;
    lbEntryCount: TLabel;
    Label17: TLabel;
    rb15: TRadioButton;
    rb18: TRadioButton;
    rb20: TRadioButton;
    tabSkipRegion: TTabSheet;
    SREdit2: TEdit;
    SREdit3: TEdit;
    SREdit4: TEdit;
    Label27: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    SRComboBox1: TComboBox;
    MenuItem13: TMenuItem;
    Button5: TButton;
    PopSkipRegionMenu: TPopupMenu;
    MenuItem6: TMenuItem;
    MenuItem9: TMenuItem;

//============================ M E T O D S ===================================
//=== Form events ============================================================
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean); //SCHMaster 2004
//=== TreeView ===============================================================
    procedure TreeEdited(Sender: TObject; Node: TTreeNode; var S: String);
    procedure TreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
//=== Fill Tree with Rules ===================================================
    procedure FillTree();
    procedure SetNodeData(ANode: TTreeNode; AObject: TObject; Root: Boolean = False);
    function TreeAddRule(ParentNode: TTreeNode; Rule: TSynRule;
      AddKind: TAddKind = akAdd): TTreeNode;
    {###function TreeAddRangeLink(Node: TTreeNode; RangeLink: TSynRangeLink;
      AddKind: TAddKind = akAdd): TTreeNode;}
    function TreeAddRange(Node: TTreeNode; Range: TSynRange;
      AddKind: TAddKind = akAdd): TTreeNode;
    function TreeAddKeyList(Node: TTreeNode; Keyword: TSynKeyList;
      AddKind: TAddKind = akAdd): TTreeNode;
    function TreeAddSet(Node: TTreeNode; SymbSet: TSynSet;
      AddKind: TAddKind = akAdd): TTreeNode;
    {$IFDEF SYN_CodeFolding}
    function TreeAddSkipRegions(ANode: TTreeNode;
      ASkipRegions: TSkipRegions): TTreeNode;
    function TreeAddFoldRegions(ANode: TTreeNode; AFoldRegions: TFoldRegions;
      AddKind: TAddKind = akAdd): TTreeNode;
    function TreeAddFoldRegion(ANode: TTreeNode; AFoldRegion: TFoldRegionItem;
      AddKind: TAddKind = akAdd): TTreeNode;
    {$ENDIF}
//=== Adding RangeLink =======================================================
    procedure DoAddRangeLinkToRoot(Sender: TObject);
    procedure DoAddRangeLink(Sender: TObject);
    //###procedure AddingRangeLink(ParentNode: TTreeNode);
//=== Adding Range ===========================================================
    procedure DoAddRangeToRoot(Sender: TObject);
    procedure DoAddRange(Sender: TObject);
    procedure AddingRange(ParentNode: TTreeNode);
//=== Adding KeyList =========================================================
    procedure DoAddKeywordToRoot(Sender:TObject);
    procedure DoAddKeyword(Sender: TObject);
    procedure AddingKeyWord(ParentNode: TTreeNode);
//=== Adding Set =============================================================
    procedure DoAddSetToRoot(Sender:TObject);
    procedure DoAddSet(Sender: TObject);
    procedure AddingSet(ParentNode: TTreeNode);
//=== Adding Fold Region =====================================================
    procedure DoAddFoldRegion(Sender: TObject);
    {$IFDEF SYN_CodeFolding}
    procedure AddingFoldRegion(ParentNode: TTreeNode);
    procedure AddingSkipRegion(ParentNode: TTreeNode);
    {$ENDIF}
//=== Delete and Rename Rules ================================================
    procedure DoDeleteNode(Sender: TObject);
    procedure DeleteNode(Node: TTreeNode; OnlyChilds: Boolean = False);
    procedure DoRenameNode(Sender: TObject);
//=== Useful functions... ====================================================
    function  GetNodeType(Node: TTreeNode): TNodeType;
    procedure TotalUpdate();
    procedure Modified(State: Boolean = True);
//=== KeyList Tools ==========================================================
    procedure btSort_oldClick(Sender: TObject);
    procedure btLowerCase_oldClick(Sender: TObject);
    procedure btSpacesToEol_oldClick(Sender: TObject);
//=== Finish buttons =========================================================
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btApplyClick(Sender: TObject);
//=== Work with schemes ======================================================
{    procedure btNewSchemeClick(Sender: TObject);
    procedure btDelSchemeClick(Sender: TObject);
    procedure cbSchemeChange(Sender: TObject);
    procedure cbSchemeSelect(Sender: TObject);}
//=== Rules changed ==========================================================
    procedure InfoChange(Sender: TObject);
    procedure VersionChange(Sender: TObject);
    procedure CustomDataChange(Sender: TObject);
    procedure RootChange(Sender: TObject);
    procedure RangeChange(Sender: TObject);
    procedure KeywordsChange(Sender: TObject);
    procedure SetChange(Sender: TObject);
    procedure FoldRegionChange(Sender: TObject);
//=== Wotk with Attributes ===================================================
    procedure AttributesChanged(Sender: TObject);
    procedure SetDefaultAttributes(Node: TTreeNode);
    procedure SetControlAttributes(Node: TTreeNode; AlreadyUpdate: Boolean = False);
    procedure SetAttributes(Node: TTreeNode);

//============================ D E S I G N ===================================
//=== Splitter CanResize =====================================================
    procedure SplitterBottomCanResize(Sender: TObject;
      var NewSize: Integer; var Accept: Boolean);
    procedure SplitterCannotResize(Sender: TObject;
      var NewSize: Integer; var Accept: Boolean);
//=== Label Mouse Leave/Enter ================================================
    procedure LabelMouseLeave(Sender: TObject);
    procedure LabelMouseEnter(Sender: TObject);
    procedure LabelContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
//=== CheckBox ===============================================================
    procedure CheckBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DontNeedContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
//=== Show/Hide panels =======================================================
    procedure ShowHideTree(Sender: TObject);
    procedure ShowHideProp(Sender: TObject);
    procedure ShowHideAttr(Sender: TObject);
    procedure ShowHideSamp(Sender: TObject);
    procedure PanelDblClick(Sender: TObject);
//=== Middle panel Resize ====================================================
    procedure pMiddleResize(Sender: TObject);
//=== Push label clicks ======================================================
    procedure lbPropBackClick(Sender: TObject);
    procedure lbRootMenuClick(Sender: TObject);
    procedure lbRuleMenuClick(Sender: TObject);
    procedure lbSampMaxClick(Sender: TObject);
    //procedure lbSampRestoreClick(Sender: TObject);
    procedure lbSampMinClick(Sender: TObject);

//============================ P O P U P S ===================================
//=== Standard PopupMenu =====================================================
    procedure SetPopupMenuEnables(Edit: TCustomEdit; popMenu: TPopupMenu);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure popCopyClick(Sender: TObject);
    procedure popUndoClick(Sender: TObject);
    procedure popCutClick(Sender: TObject);
    procedure popPasteClick(Sender: TObject);
    procedure popDeleteClick(Sender: TObject);
    procedure popSelectAllClick(Sender: TObject);
//=== Sample Memo PopupMenu ==================================================
    procedure SetPopupMenuEnables2(Edit: TCustomSynEdit; popMenu: TPopupMenu);
    procedure SampleMemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SampleMemoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Undo1Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure AddselectedtoKeywords1Click(Sender: TObject);
    procedure popSampleMemoMenuPopup(Sender: TObject);
//=== Tag Menu Clicks... =====================================================
    procedure btTagMenuClick(Sender: TObject);
    procedure miTagMenuClick(Sender: TObject);
    procedure miOpenTagMenuClick(Sender: TObject);
    procedure miCloseTagMenuClick(Sender: TObject);
//=== TabSheet showing =======================================================
    procedure tabInfoShow(Sender: TObject);
    procedure tabCustomDataShow(Sender: TObject);
    procedure tabRootShow(Sender: TObject);
    procedure tabRangeShow(Sender: TObject);
    procedure tabKeywordsShow(Sender: TObject);
    procedure tabSetShow(Sender: TObject);
//=== Work with files ========================================================
//    procedure LoadFromFileClick(Sender: TObject);
    procedure rootSaveToFileClick(Sender: TObject);
    procedure rootLoadFromFileClick(Sender: TObject);
    procedure rangeLoadFromFileClick(Sender: TObject);
    procedure rangeSaveToFileClick(Sender: TObject);
//=== Clipboard ==============================================================
    procedure StreamToClipboard(Stream: TStream);
    function GetClipboardAsStream: TMemoryStream;
//=== Root range =============================================================
    procedure rootCutClick(Sender: TObject);
    procedure rootCopyClick(Sender: TObject);
    procedure rootPasteInsideClick(Sender: TObject);
    procedure rootPasteAndReplaceClick(Sender: TObject);
//=== Other rules ============================================================
    procedure rangeCutClick(Sender: TObject);
    procedure rangeCopyClick(Sender: TObject);
    procedure rangePasteInsideClick(Sender: TObject);
    procedure rangePasteAndReplaceClick(Sender: TObject);
    procedure rangePasteNextToClick(Sender: TObject);

//=== NOT SORTED =============================================================
    procedure rootInfoClick(Sender: TObject);
    procedure TreeClick(Sender: TObject);
    procedure btStylesFileClick(Sender: TObject);
    procedure tabFoldRegionShow(Sender: TObject);
    procedure tabFoldRootShow(Sender: TObject);
    procedure SampleMemoChange(Sender: TObject);
    procedure Addcoupletags1Click(Sender: TObject);
    procedure Deletecoupletags1Click(Sender: TObject);
    procedure cbWordChange(Sender: TObject);
    procedure udQuantityClick(Sender: TObject; Button: TUDBtnType);
    procedure lbFormatVersionClick(Sender: TObject);
    procedure udVersionClick(Sender: TObject; Button: TUDBtnType);
    procedure btAddClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure mmCustomDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure lbEntryCountClick(Sender: TObject);
    procedure SREdit3Change(Sender: TObject);
    procedure AddSkip1Click(Sender: TObject);
    procedure tabSkipRegionShow(Sender: TObject);
  private
    { Private declarations }
    function GetMultiTagIndex(): Integer;
    procedure SetMultiTagIndex(Value: Integer);
    property MultiTagIndex: Integer read GetMultiTagIndex write SetMultiTagIndex;
  public
    { Public declarations }
    {$IFDEF SYN_CodeFolding}
    CodeFoldingNode: TTreeNode;
    {$ENDIF}
    popPropMenu: TPopupMenu;
    OriginalSyn: TSynUniSyn;
    ForceClose: Boolean;
    UpdatingControls: Boolean;
    ShowDialog: Boolean;
    _Modified, _Confirm, _DeleteNode, _SaveChanges, _EnterName, _DeleteScheme,
    _Lines, _Name, _Extensions, _Version, _Date, _Author, _Mail, _Web,
    _Copyright, _Company, _Remark, _FormatVersion: string;
    procedure SetAttributesEnable(AState: Boolean); overload;
    procedure SetAttributesEnable(AState, AParentState: Boolean); overload;
  end;

implementation

{$R *.dfm}

{$IFDEF SYN_CLX}
uses Qt;

const
  VK_F1 = Key_F1;
  VK_F2 = Key_F2;
  VK_RETURN = Key_Return;
  VK_DELETE = Key_Delete;
{$ENDIF}

uses SimpleXml;

const
  _pTopHeight = 210;

function GetFontStyle(Bold, Italic, Underline, StrikeOut: Boolean): TFontStyles;
begin
  Result := [];
  if Bold      then Result := Result + [fsBold];
  if Italic    then Result := Result + [fsItalic];
  if Underline then Result := Result + [fsUnderline];
  if Strikeout then Result := Result + [fsStrikeOut];
end;

(*procedure TSynUniDesigner.DelimDblClick(Sender: TObject);
begin
  (Sender as TEdit).Text := Set2String( DefaultTermSymbols );
end;*)

//============================ M E T O D S ===================================
//=== Form events ============================================================
procedure TfmDesigner.FormCreate(Sender: TObject);
var
  i: Integer;

  procedure AddBitmap(ImageList: TImageList; aColor: TColor; aSize: Integer; aSymbol: string);
  var Bitmap: TBitmap;
  begin
    Bitmap := TBitmap.Create();
    with Bitmap, Bitmap.Canvas do begin
      Width := 16;      Height := 16;
      Font.Name := 'Marlett';      Font.Color := aColor;
      Font.Size := aSize;          TextOut(1, 1, aSymbol);
      ImageList.AddMasked(Bitmap, clWhite);
    end;
    Bitmap.Free;
  end;

begin
  ForceClose := False;
  UpdatingControls := False;
  ShowDialog := True;

  _DeleteNode    := 'Are you sure you want to delete "%s"?';
  _SaveChanges   := 'Save changes in highlight rools?';
  _EnterName     := 'Enter Scheme Name:';
  _DeleteScheme  := 'Delete current color scheme?';
  _Modified      := 'Modified';
  _Confirm       := 'Confirm';
  _Lines         := 'Lines: %d';
  _Name          := 'Name: %s';
  _Extensions    := 'Extensions: %s';
  _Version       := 'Version: %s';
  _Date          := 'Date: %s';
  _Author        := 'Author: %s';
  _Mail          := 'Mail: %s';
  _FormatVersion := 'Format of the file: ';
  _Web           := 'Web: %s';
  _Copyright     := 'Copyright: %s';
  _Company       := 'Company: %s';
  _Remark        := 'Remark: %s';
    
  Caption := 'Unihighlighter Designer ?Fantasist, Vit, Vitalik (2002-2004)';
  if SynUniSyn.Info.General.Name <> '' then
    Caption := Caption + ' - [' + SynUniSyn.Info.General.Name + ']';

  ColorBoxDataModule := TColorBoxDataModule.Create(Self);

  AddBitmap(listRules, clRed,    14,  #52); //: Image0: 'Root Range'
  AddBitmap(listRules, clGreen,  14,  #52); //: Image1: 'Range'
  AddBitmap(listRules, clBlue,   14, #104); //: Image2: 'Keyword'
  AddBitmap(listRules, clMaroon, 14, #104); //: Image3: 'Set'
//  {$IFDEF SYN_CodeFolding}
  AddBitmap(listRules, clBlue,   12, #118); //: Image4: 'RootFoldItem'
  AddBitmap(listRules, clNavy,   12, #118); //: Image5: 'FoldItem'
//  {$ENDIF}
  AddBitmap(listRules, clOlive,  14,  #52); //: Image6: 'RangeLink'
  AddBitmap(listRules, clOlive,  14,  #52); //: Image7: 'Conteiner'
//  AddBitmap(listRules, clBlue,   10, #103); //: Image8: 'Highlighter'
  AddBitmap(listRules, clPurple, 14, #104); //: Image8: 'Information'
  AddBitmap(listRules, clTeal,   14, #104); //: Image9: 'CustomData'

{  cbScheme.Items.AddStrings(SynUniSyn.SchemesList);
  cbScheme.ItemIndex := SynUniSyn.SchemeIndex;}

  SampleMemo.Highlighter := SynUniSyn;
  SampleMemo.Lines.Text := SynUniSyn.Info.General.Sample;
  {$IFDEF SYN_CodeFolding}
  SampleMemo.Gutter.Width := 40;
  SampleMemo.CodeFolding.Enabled := True;
  SampleMemo.CodeFolding.CollapsedCodeHint := True;
  SampleMemo.CodeFolding.CollapsingMarkStyle := msEllipse;
  SampleMemo.CodeFolding.FolderBarColor := clScrollBar;
  SampleMemo.CodeFolding.FolderBarLinesColor := clBlack;//clBtnShadow;
  SampleMemo.InitCodeFolding();
  {$ENDIF}

  {$IFDEF SYN_COMPILER_6_UP}
  Tree.MultiSelectStyle := [msControlSelect, msShiftSelect];
  lbRootMenu.OnMouseEnter := LabelMouseEnter;
  lbRootMenu.OnMouseLeave := LabelMouseLeave;
  lbPropBack.OnMouseEnter := LabelMouseEnter;
  lbPropBack.OnMouseLeave := LabelMouseLeave;
  lbRuleMenu.OnMouseEnter := LabelMouseEnter;
  lbRuleMenu.OnMouseLeave := LabelMouseLeave;
  lbSampMin.OnMouseEnter := LabelMouseEnter;
  lbSampMin.OnMouseLeave := LabelMouseLeave;
  lbSampMax.OnMouseEnter := LabelMouseEnter;
  lbSampMax.OnMouseLeave := LabelMouseLeave;
  Label6.OnMouseEnter := LabelMouseEnter;
  Label6.OnMouseLeave := LabelMouseLeave;
  miOpenTagFirstOnLine.AutoCheck := True;
  miOpenTagFirstNonSpaceOnLine.AutoCheck := True;
  miOpenTagPartOfTerm1.AutoCheck := True;
  miOpenTagPartOfTerm2.AutoCheck := True;
  miOpenTagPartOfTerm3.AutoCheck := True;
  miOpenTagPartOfTerm4.AutoCheck := True;
  miCloseTagFirstOnLine.AutoCheck := True;
  miCloseTagFirstNonSpaceOnLine.AutoCheck := True;
  miCloseTagPartOfTerm1.AutoCheck := True;
  miCloseTagPartOfTerm2.AutoCheck := True;
  miCloseTagPartOfTerm3.AutoCheck := True;
  miCloseTagPartOfTerm4.AutoCheck := True;
  miRulesTree.AutoCheck := True;
  miProperties.AutoCheck := True;
  miAttributes.AutoCheck := True;
  miSampleText.AutoCheck := True;
  miButtons.AutoCheck := True;
  miSomeTag.AutoCheck := True;
  {$ELSE}
  lbRootMenu.Font.Color := clRed;
  lbPropBack.Font.Color := clRed;
  lbRuleMenu.Font.Color := clRed;
  lbSampMin.Font.Color := clRed;
  lbSampMax.Font.Color := clRed;
  Label6.Font.Color := clRed;
  {$ENDIF}

  {$IFDEF SYN_COMPILER_7_UP}
  pLeftParentCapt.ParentBackground := False;
  pRightCapt.ParentBackground := False;
  //~pForeColor.ParentBackground := False;
  //~pBackColor.ParentBackground := False;
  pMiddleParentCapt.ParentBackground := False;
  pBottomParentCapt.ParentBackground := False;
  {$ENDIF}

  MultiTagIndex := 0; //temp
end;

procedure TfmDesigner.FormShow(Sender: TObject);
var
  Stream: TMemoryStream;
begin
  OnShow := nil; // We need it only first time
  Stream := TMemoryStream.Create();
  try
    OriginalSyn.SaveToStream(Stream);
    Stream.Position := 0;
    try
      if Stream.Size <> 0 then
        SynUniSyn.LoadFromStream(Stream);
      Stream.Clear();
      SampleMemo.Text := OriginalSyn.Info.General.Sample;
      with OriginalSyn.EditorProperties do
      begin
        {$IFNDEF SYNEDIT11}SampleMemo.ActiveLineColor := ActiveLineColor;{$ENDIF}
        SampleMemo.SelectedColor.Foreground := SelectedForeground;
        SampleMemo.SelectedColor.Background := SelectedBackground;
      end;
      SynUniSyn.FormatVersion := OriginalSyn.FormatVersion;
      if OriginalSyn.FormatVersion = '' then
        lbFormatVersion.Caption := _FormatVersion + '?.?'
      else
        lbFormatVersion.Caption := _FormatVersion + OriginalSyn.FormatVersion;
    finally end;
  finally
    Stream.Free();
  end;

  FillTree();
  Tree.Selected := Tree.Items[0];
  TreeChange(nil, Tree.Selected);
  Tree.Items[0].getNextSibling.Expand(False);
  {$IFDEF SYN_CodeFolding}Tree.Items[0].getNextSibling.getNextSibling.Expand(False);{$ENDIF}
  Tree.Items[0].Expand(False);
  Tree.Selected := Tree.Items[0];
  Tree.Selected.MakeVisible();
  TotalUpdate();
end;

procedure TfmDesigner.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) and (not Tree.IsEditing) then Close();
end;

procedure TfmDesigner.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
    if ssCtrl in Shift then
      rootInfoClick(Sender)
    else
      Application.MessageBox('UniHighlighter Component'+#13#10#13#10+
                             'Copyright ?2002-2004:'+#13#10+
                             'Fantasist (walking_in_the_sky@yahoo.com)'+#13#10+
                             'Vit (nevzorov@yahoo.com)'+#13#10+
                             'Vitalik (vetal-x@mail.ru)'+#13#10#13#10+
                             'Official Web Site: www.delphist.com'{+#13#10#13#10+
                             'Thanks to:'+#13#10+
                             'P@VeL, '+
                             'bouville, '+
                             'StayAtHome, '+
                             'Jasny, '+
                             'SCHMaster'},
                             'About...', MB_ICONINFORMATION)
  else
    if (ssAlt in Shift) and (ssShift in Shift) and (ssCtrl in Shift) and (Key = VK_F12) then begin
      edStylesFile.Enabled := True;
      btStylesFile.Enabled := True;      
      cbStyle.Enabled := True;
    end;
end;

procedure TfmDesigner.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Choise: Integer;
begin
  if Tree.IsEditing then Tree.Selected.EndEdit(False);
  if ModalResult = mrOk then Exit;
  if btApply.Enabled then begin
    if ForceClose then Exit;
    Choise := Application.MessageBox(PChar(_SaveChanges), PChar(_Confirm), MB_YESNOCANCEL+MB_ICONQUESTION);
    if Choise = ID_YES then begin
      btApplyClick(Sender);
      ModalResult := mrOk
    end
    else if Choise = ID_NO then
      ModalResult := mrCancel
    else
      CanClose := False;
  end
  else
    ModalResult := mrCancel;

//================== SCHMaster ==================
{$IFDEF SYNPLUS}
  if ModalResult = mrNone then
    ModalResult:=mrCancel;
{$ENDIF}
//===============================================
end;

//=== TreeView ===============================================================
procedure TfmDesigner.TreeEdited(Sender: TObject; Node: TTreeNode;
  var S: TNodeText);
begin
  if Node.Data = nil then Exit;
  if TObject(Node.Data) is TSynRange then TSynRange(Node.Data).Name := S;
  if TObject(Node.Data) is TSynKeyList then TSynKeyList(Node.Data).Name := S;
  if TObject(Node.Data) is TSynSet then TSynSet(Node.Data).Name := S;
  {$IFDEF SYN_CodeFolding}
  if TObject(Node.Data) is TFoldRegionItem then TFoldRegionItem(Node.Data).Name := S;
  {$ENDIF}
  Modified();
end;

procedure TfmDesigner.TreeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then DoDeleteNode(Sender) else
  if Key = VK_F2     then DoRenameNode(Sender) else
  if popPropMenu = popRootMenu then
    if (Key = ord('X')) and (ssCtrl in Shift) then rootCutClick(Sender) else
    if (Key = ord('C')) and (ssCtrl in Shift) then rootCopyClick(Sender) else
    if (Key = ord('V')) and (ssCtrl in Shift) then rootPasteInsideClick(Sender) else
  else
  if popPropMenu = popRangeMenu then
    if (Key = ord('X')) and (ssCtrl in Shift) then rangeCutClick(Sender) else
    if (Key = ord('C')) and (ssCtrl in Shift) then rangeCopyClick(Sender) else
    if (Key = ord('V')) and (ssCtrl in Shift) then rangePasteInsideClick(Sender) else
  else
  if (popPropMenu = popKeywordsMenu) or (popPropMenu = popSetMenu) then
    if (Key = ord('X')) and (ssCtrl in Shift) then rangeCutClick(Sender) else
    if (Key = ord('C')) and (ssCtrl in Shift) then rangeCopyClick(Sender) else
    if (Key = ord('V')) and (ssCtrl in Shift) then rangePasteNextToClick(Sender) else
  else
end;

procedure TfmDesigner.TreeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
//: Handle Right Mouse Up on the Tree
var
  iNode: TTreeNode;
begin
  if Button <> mbRight then
    Exit;
//  Tree.PopupMenu := nil;
//  iNode := Tree.GetNodeAt( X, Y );
  iNode := Tree.GetNodeAt( X, Y );
//  Tree.PopupMenu := popRuleMenu;
//  Tree.Items.Item[0].Focused := True;
//  TreeChange(Sender, iNode);
  if iNode <> nil then begin
    iNode.Selected := True;
  TreeChange(Sender, Tree.Selected);
//    TreeChange(Sender, iNode);
//    popRuleMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  {$IFNDEF SYN_COMPILER_6_UP}
    popPropMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  {$ENDIF}
  end;
end;

procedure TfmDesigner.TreeMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
//: Handle Right Mouse Up on the Tree
//: ??? Переделать ???
var
  iNode: TTreeNode;
begin
  if Button <> mbRight then
    Exit;
  iNode := Tree.GetNodeAt( X, Y );
//  TreeChange(Sender, iNode);
  if iNode <> nil then
    iNode.Selected := True;
  TreeChange(Sender, Tree.Selected);
{  case GetNodeType(Tree.Selected) of
    ntRoot:     popRootMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    ntRange:    popRangeMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    ntKeywords: popKeywordsMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    ntSet:      popSetMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  end;}
  popPropMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
//    TreeChange(Sender, iNode);
//    popRuleMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;


procedure TfmDesigner.TreeClick(Sender: TObject);
begin
  TreeChange(Sender, Tree.Selected);
end;

procedure TfmDesigner.TreeChange(Sender: TObject; Node: TTreeNode);
var
  Range: TSynRange;
  Symbol: string;
  i, len: Integer;
  {$IFDEF SYN_CodeFolding}
  FoldRegion: TFoldRegionItem;
  SkipRegion: TSkipRegionItem;
  {$ENDIF}
//  list: TList;
begin
  UpdatingControls := True;
//  ListBox1.Clear;
//  list := TList.Create();
//  Tree.GetSelections(list);
{  for i := 0 to list.Count-1 do
    ListBox1.Items.Add(TTreeNode(list.Items[i]).Text);
  list.Free;}
{$IFDEF SYN_COMPILER_6_UP}
if Tree.SelectionCount > 1 then
  PageControl.ActivePage := tabSeveralRules
else
if Tree.SelectionCount = 1 then begin
{$ENDIF}
//  Tree.Selected := TTreeNode(list.Items[0]);
  case GetNodeType(Node) of
    ntInfo: begin
      with TSynInfo(Node.Data) do
      begin
        edName.Text         := General.Name;
        edExtensions.Text   := General.Extensions;
        udVersion.Position  := General.Version;
        udRevision.Position := General.Revision;
        edAuthor.Text       := Author.Name;
        edEmail.Text        := Author.Email;
        edWeb.Text          := Author.Web;
        edCopyright.Text    := Author.Copyright;
        edCompany.Text      := Author.Company;
        edRemark.Text       := Author.Remark;
      end;
      SetControlAttributes(Node, True);
      PageControl.ActivePage := tabInfo;
    end;
    {$IFDEF CUSTOMDATA}
    ntCustomData: begin
      mmCustomData.Text := TStringList(Node.Data).Text;
      lbEntryCountClick(Sender);
      SetControlAttributes(Node, True);
      PageControl.ActivePage := tabCustomData;
    end;
    {$ENDIF}
    ntRange, ntRangeLink: begin
      {###if (TObject(Node.Data) is TSynRangeLink) then
        Range := TSynRangeLink(Node.Data).Range
      else}
        Range := TSynRange(Node.Data);
      with Range do begin
        while popMultiTags.Items.Count > 5 do popMultiTags.Items.Delete(5);
        for i := 0 to OpenToken.SymbolCount-1 do begin
          popMultiTags.Items.Add(TMenuItem.Create(Self));
          with popMultiTags.Items.Items[popMultiTags.Items.Count-1] do begin
            Caption := 'Open: "'+OpenToken.Symbols[i]+'", Close: "'+CloseToken.Symbols[i]+'"';
            OnClick := cbWordChange;
            RadioItem := True;
            {$IFDEF SYN_COMPILER_6_UP}
            AutoCheck := True;
            {$ENDIF}
            GroupIndex := 1;
          end;
        end;
        MultiTagIndex := 0;

        Symbol := OpenToken.Symbols[MultiTagIndex];
        edFrom.Text := Symbol;
        len := length(Symbol);
        if len > 0 then
          chFromEOL.Checked := Symbol[len] = #0
        else
          chFromEOL.Checked := False;

        Symbol := CloseToken.Symbols[MultiTagIndex];
        edTo.Text := Symbol;
        len := length(Symbol);
        if len > 0 then
          chToEOL.Checked := Symbol[len] = #0
        else
          chToEOL.Checked := False;
  
        chEnabledRange.Checked := Enabled;
        chCloseOnWord.Checked := CloseOnTerm;
        chCloseOnEOL.Checked := CloseOnEol;
        chCloseParent.Checked := AllowPreviousClose;
        chCaseRange.Checked := CaseSensitive;
        edDelimitersRange.Text := SetToStr(Delimiters);
        popOpenTagMenu.Items.Items[2].Checked := OpenToken.StartLine = slFirst;
        popOpenTagMenu.Items.Items[3].Checked := OpenToken.StartLine = slFirstNonSpace;
        popCloseTagMenu.Items.Items[2].Checked := CloseToken.StartLine = slFirst;
        popCloseTagMenu.Items.Items[3].Checked := CloseToken.StartLine = slFirstNonSpace;
        if OpenToken.StartType = stAny then
          if OpenToken.BreakType = btAny then
            popOpenTagMenu.Items.Items[5].Checked := True
          else
            popOpenTagMenu.Items.Items[7].Checked := True
        else
          if OpenToken.BreakType = btAny then
            popOpenTagMenu.Items.Items[6].Checked := True
          else
            popOpenTagMenu.Items.Items[8].Checked := True;
        if CloseToken.StartType = stAny then
          if CloseToken.BreakType = btAny then
            popCloseTagMenu.Items.Items[5].Checked := True
          else
            popCloseTagMenu.Items.Items[7].Checked := True
        else
          if CloseToken.BreakType = btAny then
            popCloseTagMenu.Items.Items[6].Checked := True
          else
            popCloseTagMenu.Items.Items[8].Checked := True;
        SetControlAttributes(Node, True);
        PageControl.ActivePage := tabRange;
      end;
    end;
    ntRoot: begin
      chEnabledRoot.Checked := TSynRange(Node.data).Enabled;
      SetControlAttributes(Node, True);
      with SynUniSyn.EditorProperties do
      begin
        {$IFNDEF SYNEDIT11}frActiveLineColor.Color := ActiveLineColor;{$ENDIF}
        frSelectForeColor.Color := SelectedForeground;
        frSelectBackColor.Color := SelectedBackground;
      end;
      chCaseRoot.Checked := TSynRange(Node.data).CaseSensitive;
      //###edStylesFile.Text := SynUniSyn.SchemeFileName;
      edDelimitersRoot.Text := SetToStr(TSynRange(Node.data).Delimiters);
      PageControl.ActivePage := tabRoot;
    end;
    ntKeywords: begin
      chEnabledKeyList.Checked := TSynKeyList(Node.Data).Enabled;
      Memo.Lines.Assign(TSynKeyList(Node.Data).KeyList);
      SetControlAttributes(Node, True);
      PageControl.ActivePage := tabKeywords;
    end;
    ntSet: begin
      chEnabledSet.Checked := TSynSet(Node.Data).Enabled;
      SetControlAttributes(Node, True);
      edSymbSet.Text := SetToStr(TSynSet(Node.Data).CharSet);
      udQuantity.Position := TSynSet(Node.Data).Quantity;
      PageControl.ActivePage := tabSet;
    end;
    {$IFDEF SYN_CodeFolding}
    // Modified by Administrator 2007-12-1 ЙПОз 01:26:01
    ntSkipRegion : begin
      SkipRegion := TSkipRegionItem(Node.Data);
      SREdit2.Text := SkipRegion.Open;
      SREdit3.Text := SkipRegion.Close;
      SREdit4.Text := SkipRegion.Escape;
      SRComboBox1.ItemIndex := Integer(SkipRegion.RegionType);
      PageControl.ActivePage := tabSkipRegion;
    end;
    ntFoldRoot: begin
      SetControlAttributes(Node, True);
      PageControl.ActivePage := tabFoldRoot;
    end;
    ntFoldRegion: begin
      FoldRegion := TFoldRegionItem(Node.Data);
      with FoldRegion do
      begin
        case FoldRegionType of
          rtChar:    rbChar.Checked := True;
          rtKeyWord: rbKeyword.Checked := True;
        end;
        edOpen.Text         := Open;
        edOpenRegExpr.Text  := RegExpOpen;
        edClose.Text        := Close;
        edCloseRegExpr.Text := RegExpClose;
        chUseOpenRegExpr.Checked := RegExpUseOpen;
        chUseCloseRegExpr.Checked := RegExpUseClose;
        chAddKeyword.Checked := AddEnding;
        chNoSubFolds.Checked := NoSubFoldRegions;
        chWholeWords.Checked := WholeWords;
      end;
      SetControlAttributes(Node, True);
      PageControl.ActivePage := tabFoldRegion;
    end;
    {$ENDIF}
 end;
{$IFDEF SYN_COMPILER_6_UP}
end;
{$ENDIF}
 UpdatingControls := False;
end;

//=== Fill Tree with Rules ===================================================
procedure TfmDesigner.FillTree();  //: Fill Tree with Rules
var
  Node: TTreeNode;
begin
  //Info
  Node := Tree.Items.Add(nil, 'Information');
  SetNodeData(Node, SynUniSyn.Info, True);
  //MainRules
  TreeAddRange(nil, SynUniSyn.MainRules);
  {$IFDEF SYN_CodeFolding}
  //CodeFolding
  CodeFoldingNode := Tree.Items.Add(nil, 'CodeFolding');
  SetNodeData(CodeFoldingNode, nil, True);
  TreeAddFoldRegions(CodeFoldingNode, SynUniSyn.FoldRegions);
  TreeAddSkipRegions(CodeFoldingNode, SynUniSyn.FoldRegions.SkipRegions);
  {$ENDIF}
  {$IFDEF CUSTOMDATA}
  //CustomData
  Node := Tree.Items.Add(nil, 'CustomData');
  SetNodeData(Node, SynUniSyn.CustomData, True);
  {$ENDIF}
end;

procedure TfmDesigner.SetNodeData(ANode: TTreeNode; AObject: TObject; Root: Boolean);
begin
  if AObject is TSynInfo then begin
    ANode.ImageIndex := 8;
    ANode.SelectedIndex := 8;
  end else
  if AObject is TStringList then begin
    ANode.ImageIndex := 9;
    ANode.SelectedIndex := 9;
  end else
  if AObject is TSynRange then begin
    if Root then begin
      ANode.ImageIndex := 0;
      ANode.SelectedIndex := 0;
    end
    else begin
      ANode.ImageIndex := 1;
      ANode.SelectedIndex := 1;
    end
  {###else if Rule is TSynRangeLink then begin
    ANode.ImageIndex := 7;
    ANode.SelectedIndex := 7;
  end}
  end else
  if AObject is TSynKeyList then begin
    ANode.ImageIndex := 2;
    ANode.SelectedIndex := 2;
  end else
  if AObject is TSynSet then begin
    ANode.ImageIndex := 3;
    ANode.SelectedIndex := 3;
  end else
  {$IFDEF SYN_CodeFolding}
  if AObject is TSkipRegionItem then begin
    ANode.ImageIndex := 5;
    ANode.SelectedIndex := 5;
  end else
  if AObject is TFoldRegionItem then begin
    if Root then begin
      ANode.ImageIndex := 4;
      ANode.SelectedIndex := 4;
    end
    else begin
      ANode.ImageIndex := 5;
      ANode.SelectedIndex := 5;
    end
  end else
  if Root then begin
    ANode.ImageIndex := 4;
    ANode.SelectedIndex := 4;
  end
  else
  {$ENDIF}
    raise Exception.Create(ClassName + '.SetNodeData - Unknown rule to set node!');
  ANode.Data := AObject;
end;

function TfmDesigner.TreeAddRule(ParentNode: TTreeNode; Rule: TSynRule; AddKind: TAddKind): TTreeNode;
begin
  //###if Rule is TSynRangeLink then Result:= TreeAddRangeLink(ParentNode, TSynRangeLink(Rule), AddKind) else
  if Rule is TSynRange     then Result:= TreeAddRange(ParentNode, TSynRange(Rule), AddKind) else
  if Rule is TSynKeyList   then Result:= TreeAddKeyList(ParentNode, TSynKeyList(Rule), AddKind) else
  if Rule is TSynSet       then Result:= TreeAddSet(ParentNode, TSynSet(Rule), AddKind) else
    raise Exception.Create(ClassName + '.TreeAddRule - Unknown rule to add!');
end;

{###function TfmDesigner.TreeAddRangeLink(Node: TTreeNode; RangeLink: TSynRangeLink; AddKind: TAddKind): TTreeNode;
begin
  Result := Tree.Items.AddChild(Node, RangeLink.Range.Name);
  SetNodeData(Result, RangeLink);
end;}

function TfmDesigner.TreeAddRange(Node: TTreeNode; Range: TSynRange; AddKind: TAddKind): TTreeNode;
var
  i, ind: Integer;
begin
  if AddKind = akReplace then
    Result := Node
  else
    if Node = nil then begin
      if (Range.Name = '') or (Range.Name = 'Root') then Range.Name := _Root;
      Result := Tree.Items.Add(nil, Range.Name);
      SetNodeData(Result, Range, True);
    end
    else begin
      if AddKind = akInsert then begin
        ind := Node.Index;
        Result := Tree.Items.Insert(Node.Parent.Item[ind], Range.Name)
      end else
        Result := Tree.Items.AddChild(Node, Range.Name);
      SetNodeData(Result, Range);
    end;

  for i := 0 to Range.KeyListCount-1 do TreeAddKeyList(Result, Range.KeyLists[i]);
  for i := 0 to Range.SetCount-1 do TreeAddSet(Result, Range.Sets[i]);
  for i := 0 to Range.RangeCount-1 do TreeAddRange(Result, Range.Ranges[i]);
end;

{$IFDEF SYN_CodeFolding}

function TfmDesigner.TreeAddSkipRegions(ANode: TTreeNode;
  ASkipRegions: TSkipRegions): TTreeNode;
var
  i : Integer;
  Node : TTreeNode;
begin
  for i := 0 to ASkipRegions.Count-1 do
  begin
    Node := TRee.Items.AddChild(ANode, 'SkipRegion');
    SetNodeData(Node, ASkipRegions.SkipRegions[i]);
  end;
end;

function TfmDesigner.TreeAddFoldRegions(ANode: TTreeNode; AFoldRegions: TFoldRegions; AddKind: TAddKind): TTreeNode;
var
  i, j, ind: Integer;
  CurFoldRegion: TFoldRegionItem;
begin
  for i := 0 to AFoldRegions.Count-1 do
  begin
    CurFoldRegion := AFoldRegions[i];
    if AddKind = akReplace then
      Result := ANode
    else
      if ANode = nil then
      begin
        Result := Tree.Items.Add(nil, CurFoldRegion.Name);
        SetNodeData(Result, CurFoldRegion, True);
      end
      else
      begin
        if AddKind = akInsert then
        begin
          ind := ANode.Index;
          Result := Tree.Items.Insert(ANode.Parent.Item[ind], CurFoldRegion.Name)
        end else
          Result := Tree.Items.AddChild(ANode, CurFoldRegion.Name);
        SetNodeData(Result, CurFoldRegion);
      end;
    TreeAddFoldRegions(Result, CurFoldRegion.SubFoldRegions);
  end;
end;

function TfmDesigner.TreeAddFoldRegion(ANode: TTreeNode; AFoldRegion: TFoldRegionItem; AddKind: TAddKind): TTreeNode;
var
  i, j, ind: Integer;
begin
  if AddKind = akReplace then
    Result := ANode
  else
    if ANode = nil then
    begin
      Result := Tree.Items.Add(nil, AFoldRegion.Name);
      SetNodeData(Result, AFoldRegion, True);
    end
    else
    begin
      if AddKind = akInsert then
      begin
        ind := ANode.Index;
        Result := Tree.Items.Insert(ANode.Parent.Item[ind], AFoldRegion.Name)
      end else
        Result := Tree.Items.AddChild(ANode, AFoldRegion.Name);
      SetNodeData(Result, AFoldRegion);
    end;
  TreeAddFoldRegions(Result, AFoldRegion.SubFoldRegions);
end;
{$ENDIF}

function TfmDesigner.TreeAddKeyList(Node: TTreeNode; Keyword: TSynKeyList; AddKind: TAddKind): TTreeNode;
var
  i, ind: Integer;
  NeedToInsert: Boolean;
begin
  if AddKind = akReplace then
    Result := Node
  else
    if AddKind = akInsert then begin
      ind := Node.Index;
      Result := Tree.Items.Insert(Node.Parent.Item[ind], Keyword.Name)
    end else
      if Node.Count = 0 then
        Result := Tree.Items.AddChild(Node, Keyword.Name)
      else begin
        NeedToInsert := False;
        for i := 0 to Node.Count-1 do
          if (TObject(Node.Item[i].Data) is TSynRange) or (TObject(Node.Item[i].Data) is TSynSet) then begin
            NeedToInsert := True;   break;   end;
        if NeedToInsert then Result := Tree.Items.Insert(Node.Item[i], Keyword.Name)
                        else Result := Tree.Items.AddChild(Node, Keyword.Name);
      end;

  SetNodeData(Result, Keyword);
end;

function TfmDesigner.TreeAddSet(Node: TTreeNode; SymbSet: TSynSet; AddKind: TAddKind): TTreeNode;
var
  i, ind: Integer;
  NeedToInsert: Boolean;
begin
  if AddKind = akReplace then
    Result := Node
  else
    if AddKind = akInsert then begin
      ind := Node.Index;
      Result := Tree.Items.Insert(Node.Parent.Item[ind], SymbSet.Name)
    end else
      if Node.Count = 0 then
        Result := Tree.Items.AddChild(Node, SymbSet.Name)
      else begin
        NeedToInsert := False;
        for i := 0 to Node.Count-1 do
          if TObject(Node.Item[i].Data) is TSynRange then begin
            NeedToInsert := True;   break;  end;
        if NeedToInsert then Result := Tree.Items.Insert(Node.Item[i], SymbSet.Name)
                        else Result := Tree.Items.AddChild(Node, SymbSet.Name);
      end;

  SetNodeData(Result, SymbSet);
end;

//=== Adding RangeLink =======================================================
procedure TfmDesigner.DoAddRangeLinkToRoot(Sender:TObject); //: Click on button
begin
  //###AddingRangeLink(Tree.Items[0]);
  Modified();
end;

procedure TfmDesigner.DoAddRangeLink(Sender: TObject); //: Click on button
begin
  //###AddingRangeLink(Tree.Selected);
  Modified();
end;

(*###procedure TfmDesigner.AddingRangeLink(ParentNode: TTreeNode);
var
  Node: TTreeNode;
  RangeLink: TSynRangeLink;
  //i: Integer;
begin
  RangeLink := TSynRangeLink.Create(SynUniSyn.MainRules.Ranges[6]);
  TSynRange(ParentNode.Data).AddRangeLink(RangeLink);
  Node := TreeAddRangeLink(ParentNode, RangeLink);
  with Node do begin
    Expand(False);
    Selected := True;
    Tree.SetFocus;
    EditText;
  end;
{  Range.ClearAttributes();
  for i := 0 to SynUniSyn.SchemesList.Count-1 do begin
    TSynRange(ParentNode.Data).SetAttributesIndex(i);
    Range.AddAttribute();
    SetDefaultAttributes(Node);
  end;
  TSynRange(ParentNode.Data).SetAttributesIndex(SynUniSyn.SchemeIndex);}
  SetControlAttributes(Node);
end;*)

//=== Adding Range ===========================================================
procedure TfmDesigner.DoAddRangeToRoot(Sender:TObject); //: Click on button
begin
  AddingRange(Tree.Items[1]);
  Modified();
end;

procedure TfmDesigner.DoAddRange(Sender: TObject); //: Click on button
begin
  AddingRange(Tree.Selected);
  Modified();
end;

procedure TfmDesigner.AddingRange(ParentNode: TTreeNode);
var Node: TTreeNode;
    Range: TSynRange;
    i: Integer;
begin
  if ParentNode = nil then begin //Never happened ???
    Tree.Items.Clear();
    Node := Tree.Items.Add(nil, _Root);
    SynUniSyn.MainRules.Name := _Root;
    Node.Data := SynUniSyn.MainRules;
    Node.ImageIndex := 0;
    Node.SelectedIndex := 0;
    Exit;
  end
  else begin
    Range := TSynRange.Create();
    Range.Name := _New;
    TSynRange(ParentNode.Data).AddRange(Range);
    Node := TreeAddRange(ParentNode, Range);
    with Node do begin
      Expand(False);
      Selected := True;
      Tree.SetFocus();
      EditText();
    end;
  end;
//  Range.ClearAttributes();
  //###for i := 0 to SynUniSyn.SchemesList.Count-1 do begin
//    TSynRange(ParentNode.Data).SetAttributesIndex(i);
//    Range.AddAttribute();
    SetDefaultAttributes(Node);
  //###end;
//  TSynRange(ParentNode.Data).SetAttributesIndex(SynUniSyn.SchemeIndex);
  SetControlAttributes(Node);
end;

//=== Adding KeyList =========================================================
procedure TfmDesigner.DoAddKeywordToRoot(Sender:TObject); //: Click on button
begin
  AddingKeyword(Tree.Items[1]);
  Modified();
end;

procedure TfmDesigner.DoAddKeyword(Sender: TObject); //: Click on button
begin
  AddingKeyWord(Tree.selected);
  Modified();
end;

procedure TfmDesigner.AddingKeyWord(ParentNode: TTreeNode);
var Node: TTreeNode;
    Keyword: TSynKeyList;
    i: Integer;
begin
  Keyword := TSynKeyList.Create();
  Keyword.Name := _New;
  Node := TreeAddKeyList(ParentNode, Keyword);
  with Node do begin
    Expand(False);
    Selected := True;
    Tree.SetFocus;
    EditText;
  end;
//  Keyword.ClearAttributes();
  //###for i := 0 to SynUniSyn.SchemesList.Count-1 do begin
//    TSynRange(ParentNode.Data).SetAttributesIndex(i);
//    Keyword.AddAttribute();
    SetDefaultAttributes(Node);
  //###end;
//  TSynRange(ParentNode.Data).SetAttributesIndex(SynUniSyn.SchemeIndex);
  TSynRange(ParentNode.Data).AddKeyList(Keyword);
  SetControlAttributes(Node);
end;

//=== Adding Set =============================================================
procedure TfmDesigner.DoAddSetToRoot(Sender:TObject); //: Click on button
begin
  AddingSet(Tree.Items[1]);
  Modified();
end;

procedure TfmDesigner.DoAddSet(Sender: TObject); //: Click on button
begin
  AddingSet(Tree.Selected);
  Modified();
end;

procedure TfmDesigner.AddingSet(ParentNode: TTreeNode);
var
  Node: TTreeNode;
  SymbolSet: TSynSet;
  i: Integer;
begin
  SymbolSet := TSynSet.Create();
  SymbolSet.Name := _New;
  TSynRange(ParentNode.data).AddSet(SymbolSet);
  Node := TreeAddSet(ParentNode, SymbolSet);
  with Node do begin
    Expand(False);
    Selected := True;
    Tree.SetFocus;
    EditText;
  end;
//  SymbolSet.ClearAttributes();
  //###for i := 0 to SynUniSyn.SchemesList.Count-1 do begin
//    TSynRange(ParentNode.Data).SetAttributesIndex(i);
//    SymbolSet.AddAttribute();
    SetDefaultAttributes(Node);
  //###end;
//  TSynRange(ParentNode.Data).SetAttributesIndex(SynUniSyn.SchemeIndex);
  SetControlAttributes(Node);
end;

//=== Adding Fold Region =====================================================
procedure TfmDesigner.DoAddFoldRegion(Sender: TObject); //: Click on button
begin
  {$IFDEF SYN_CodeFolding}AddingFoldRegion(Tree.Selected);{$ENDIF}
  Modified();
end;

{$IFDEF SYN_CodeFolding}

procedure TfmDesigner.AddingSkipRegion(ParentNode: TTreeNode);
var
  SkipRegion : TSkipRegionItem;
  Node: TTreeNode;
begin
  SkipRegion := SynUniSyn.FoldRegions.SkipRegions.Add('', '', '', itString);
  Node := Tree.Items.AddChild(CodeFoldingNode, 'SkipRegion');
  SetNodeData(Node, SkipRegion);
  with Node do begin
    Expand(False);
    Selected := True;
    Tree.SetFocus;
  end;
  SetDefaultAttributes(Node);
  SetControlAttributes(Node);
end;

procedure TfmDesigner.AddingFoldRegion(ParentNode: TTreeNode);
var
  Node: TTreeNode;
  FoldRegion: TFoldRegionItem;
  Regions: TFoldRegions;
  i: Integer;
begin
  if ParentNode.Data = nil then
    Regions := SynUniSyn.FoldRegions
  else
    Regions := TFoldRegionItem(ParentNode.Data).SubFoldRegions;

  FoldRegion := Regions.Add(rtChar, False, False, False, '', '', ParentNode.Data);
  FoldRegion.RegExpUseOpen := False;
  FoldRegion.RegExpUseClose := False;

  FoldRegion.Name := _New;
  Node := TreeAddFoldRegion(ParentNode, FoldRegion);
  with Node do begin
    Expand(False);
    Selected := True;
    Tree.SetFocus;
    EditText;
  end;
//  Range.ClearAttributes();
  //###for i := 0 to SynUniSyn.SchemesList.Count-1 do begin
//    TSynRange(ParentNode.Data).SetAttributesIndex(i);
//    Range.AddAttribute();
    SetDefaultAttributes(Node);
  //###end;
//  TSynRange(ParentNode.Data).SetAttributesIndex(SynUniSyn.SchemeIndex);
  SetControlAttributes(Node);
end;
{$ENDIF}

//=== Delete and Rename Rules ================================================
procedure TfmDesigner.DoDeleteNode(Sender: TObject);
begin
  if not Tree.IsEditing then
    if not ShowDialog or (Application.MessageBox(PChar(Format(_DeleteNode,[Tree.Selected.Text])), PChar(_Confirm), MB_YESNOCANCEL+MB_ICONQUESTION) = ID_YES) then begin
      DeleteNode(Tree.Selected);
      TotalUpdate();
      Modified();
    end;
  ShowDialog := True;
end;

procedure TfmDesigner.DeleteNode(Node: TTreeNode; OnlyChilds: Boolean);
var
  {$IFDEF SYN_CodeFolding}Regions: TFoldRegions;{$ENDIF}
  i: Integer;
begin
//Node.DeleteChildren; - когд?нить исправит?
  while Node.Count > 0 do
    DeleteNode(Node[0]);
  if (Node.Data <> SynUniSyn.MainRules) and (Node.Data <> nil) and not OnlyChilds then begin
    if TObject(Node.Data) is TSynRange then
      TSynRange(Node.Parent.Data).DeleteRange(TSynRange(Node.Data))
    else if TObject(Node.Data) is TSynKeyList then
      TSynRange(Node.Parent.Data).DeleteKeyList(TSynKeyList(Node.Data))
    else if TObject(Node.Data) is TSynSet then
      TSynRange(Node.Parent.Data).DeleteSet(TSynSet(Node.Data))
    {$IFDEF SYN_CodeFolding}
    else if TObject(Node.Data) is TSkipRegionItem then
      TObject(Node.Data).Free
    else if TObject(Node.Data) is TFoldRegionItem then
    begin
      if Node.Parent.Data = nil then
        Regions := SynUniSyn.FoldRegions
      else
        Regions := TFoldRegionItem(Node.Parent.Data).SubFoldRegions;
      for i := 0 to Regions.Count-1 do
        if Regions[i] = TFoldRegionItem(Node.Data) then
        begin
          //ShowMessage(TFoldRegionItem(Node.Data).Name);
          Regions.Delete(i);
        end
    end{$ENDIF};
    Node.Delete;
  end;
end;

procedure TfmDesigner.DoRenameNode(Sender: TObject);
begin
  Tree.Selected.EditText;
end;

//=== Usefuk functions... ====================================================
function TfmDesigner.GetNodeType(Node: TTreeNode): TNodeType;
begin
  Result := ntNone;
  if Node <> nil then
    if (TObject(Node.Data) is TSynRange) and (Node.Level = 0) then Result := ntRoot else
    //###if (TObject(Node.Data) is TSynRangeLink) then Result := ntRangeLink else
    if TObject(Node.Data) is TSynInfo        then Result := ntInfo else
    {$IFDEF CUSTOMDATA}
    if TObject(Node.Data) is TStringList     then Result := ntCustomData else
    {$ENDIF}
    if TObject(Node.Data) is TSynRange       then Result := ntRange else
    if TObject(Node.Data) is TSynKeyList     then Result := ntKeywords else
    if TObject(Node.Data) is TSynSet         then Result := ntSet else
    {$IFDEF SYN_CodeFolding}
    if TObject(Node.Data) is TSkipRegionItem then Result := ntSkipRegion else
    if TObject(Node.Data) is TFoldRegionItem then Result := ntFoldRegion else
      Result := ntFoldRoot;
    {$ENDIF}
end;

procedure TfmDesigner.TotalUpdate();
var
  SelStart, SelEnd: Integer;
begin
  SelStart := SampleMemo.SelStart;
  SelEnd   := SampleMemo.SelEnd;
  SynUniSyn.Reset;
  SynUniSyn.MainRules.Reset;
  SynUniSyn.ResetRange;
  SynUniSyn.Prepare;
  SampleMemo.Highlighter := nil;
  SampleMemo.Highlighter := SynUniSyn;
  with SynUniSyn.EditorProperties do
  begin
    {$IFNDEF SYNEDIT11}SampleMemo.ActiveLineColor := ActiveLineColor;{$ENDIF}
    SampleMemo.SelectedColor.Foreground := SelectedForeground;
    SampleMemo.SelectedColor.Background := SelectedBackground;
  end;
  {$IFDEF SYN_CodeFolding}SampleMemo.InitCodeFolding();{$ENDIF}
  SampleMemo.Refresh;
  SampleMemo.SelStart := SelStart;
  SampleMemo.SelEnd   := SelEnd;
end;

procedure TfmDesigner.Modified(State: Boolean = True);
begin
  if State then begin
    btApply.Enabled := True;
    StatusBar.Panels.Items[0].Text := _Modified;
  end else begin
    btApply.Enabled := False;
    StatusBar.Panels.Items[0].Text := '';
  end;
end;

//=== KeyList Tools ==========================================================
procedure TfmDesigner.btSort_oldClick(Sender: TObject);
var i: Integer;
begin
  With TStringList.Create do
    try
      Sorted := True;
      Duplicates := dupIgnore;
      for i := 0 to Memo.Lines.Count-1 do
        if Trim(Memo.Lines[i]) <> '' then
          Add(Trim(Memo.Lines[i]));
      Sort;
      Memo.Text := Trim(Text);
    finally
      Free;
    end;
end;

procedure TfmDesigner.btLowerCase_oldClick(Sender: TObject);
begin
  Memo.text := LowerCase(Memo.Text);
end;

procedure TfmDesigner.btSpacesToEol_oldClick(Sender: TObject);
begin
  Memo.text := StringReplace(Memo.Text, ' ', #13#10, [rfReplaceAll]);
end;

//=== Finish buttons =========================================================
procedure TfmDesigner.btOkClick(Sender: TObject);
begin
  if Tree.IsEditing then
    Tree.Selected.EndEdit(False)
  else
    if btApply.Enabled then begin
      btApplyClick(Sender);
      ModalResult := mrOk;
    end else
      if (btApply.Tag = 1) then
        ModalResult := mrOk
      else
        ModalResult := mrCancel;
  ForceClose := True;
end;

procedure TfmDesigner.btCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  ForceClose := True;
end;

procedure TfmDesigner.btApplyClick(Sender: TObject);
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create();
  SynUniSyn.SaveToStream(Stream);
  Stream.Position := 0;
  OriginalSyn.LoadFromStream(Stream);
  FreeAndNil(Stream);
  OriginalSyn.Info.General.Sample := SampleMemo.Text;
  if rb15.Checked then OriginalSyn.FormatVersion := '1.5' else
  if rb18.Checked then OriginalSyn.FormatVersion := '1.8'
                  else OriginalSyn.FormatVersion := '2.0';
  Modified(False);
  btApply.Tag := 1;
end;

//=== Work with schemes ======================================================
{procedure TfmDesigner.btNewSchemeClick(Sender: TObject);
var
  Name: string;
begin
  if InputQuery(_EnterName, _EnterName, Name) then begin
    SynUniSyn.AddNewScheme(Name);
    SynUniSyn.MainRules.Attribs.ParentForeground := False;
    SynUniSyn.MainRules.Attribs.ParentBackground := False;
    cbScheme.ItemIndex := cbScheme.Items.Add(Name);
    SetControlAttributes(Tree.Selected);
    TotalUpdate();
    Modified();
  end;
end;

procedure TfmDesigner.btDelSchemeClick(Sender: TObject);
var
  Index: Integer;
begin
  if cbScheme.Items.Count > 1 then
    if Application.MessageBox(PChar(_DeleteScheme),PChar(_Confirm),MB_YESNOCANCEL+MB_ICONQUESTION) = ID_YES then begin
      Index := cbScheme.ItemIndex;
      cbScheme.Items.Delete(Index);
      SynUniSyn.DeleteScheme(Index);
      if cbScheme.Items.Count = Index then
        cbScheme.ItemIndex := Index-1
      else
        cbScheme.ItemIndex := Index;
      SetControlAttributes(Tree.Selected);
      TotalUpdate();
      Modified();
    end;
end;

procedure TfmDesigner.cbSchemeSelect(Sender: TObject);
begin
  SynUniSyn.SetSchemeIndex(cbScheme.ItemIndex);
  SetControlAttributes(Tree.Selected);
  TotalUpdate();
  Modified();
end;

procedure TfmDesigner.cbSchemeChange(Sender: TObject);
var
  SelStart, SelLength: Integer;
begin
  if cbScheme.ItemIndex > -1 then
    cbScheme.Tag := cbScheme.ItemIndex;
  SelStart := cbScheme.SelStart;
  SelLength := cbScheme.SelLength;
  cbScheme.Items[cbScheme.Tag] := cbScheme.Text;
  cbScheme.ItemIndex := cbScheme.Tag;
  SynUniSyn.SchemesList.Strings[cbScheme.Tag] := cbScheme.Text;
  cbScheme.SelStart := SelStart;
  cbScheme.SelLength := SelLength;
  Modified();
end;}

//=== Rules changed ==========================================================
procedure TfmDesigner.InfoChange(Sender: TObject);
begin
  if UpdatingControls then Exit;
  with TSynInfo(Tree.Selected.Data) do
  begin
    General.Name       := edName.Text;
    General.Extensions := edExtensions.Text;
    General.Version    := udVersion.Position;
    General.Revision   := udRevision.Position;
    Author.Name        := edAuthor.Text;
    Author.Email       := edEmail.Text;
    Author.Web         := edWeb.Text;
    Author.Copyright   := edCopyright.Text;
    Author.Company     := edCompany.Text;
    Author.Remark      := edRemark.Text;
  end;
  Modified();
end;

procedure TfmDesigner.VersionChange(Sender: TObject);
begin
  Modified();
end;

procedure TfmDesigner.CustomDataChange(Sender: TObject);
begin
{$IFDEF CUSTOMDATA}
  if UpdatingControls then Exit;
  SynUniSyn.CustomData.Text := mmCustomData.Text; //TODO: заменить на TStringList(Tree.Selected.Data).Text ?
  lbEntryCountClick(Sender);
  Modified();
{$ENDIF}
end;

procedure TfmDesigner.RootChange(Sender: TObject);
var
  i: Integer;
begin
  if UpdatingControls then Exit;
  with SynUniSyn do begin
    //###SchemeFileName := edStylesFile.Text;
    {###if Styles <> nil then begin
      Styles.Free;
      Styles := nil;
    end;
    if FileExists(SchemeFileName) then begin
      Styles := TSynUniStyles.Create();
      Styles.FileName := SchemeFileName;
      Styles.Load;
    end;}
    with EditorProperties do
    begin
      {$IFNDEF SYNEDIT11}ActiveLineColor := frActiveLineColor.Color;{$ENDIF}
      SelectedForeground := frSelectForeColor.Color;
      SelectedBackground := frSelectBackColor.Color;
      {$IFNDEF SYNEDIT11}SampleMemo.ActiveLineColor := ActiveLineColor;{$ENDIF}
      SampleMemo.SelectedColor.Foreground := SelectedForeground;
      SampleMemo.SelectedColor.Background := SelectedBackground;
    end;
  end;
  with TSynRange(Tree.Selected.Data) do begin
    if GetNodeType(Tree.Selected) in [ntRoot] then begin
      CaseSensitive := chCaseRoot.Checked;
      Enabled := chEnabledRoot.Checked;
    end;
    Delimiters := [];
    { the apparently useless typecast to char is for CLX compatibility }
    for i := 1 to length(edDelimitersRoot.Text) do
      Delimiters := Delimiters + [Char(edDelimitersRoot.Text[i])];
  end;
  TotalUpdate();
  Modified();
end;

procedure TfmDesigner.RangeChange(Sender: TObject);
var
  i, index: Integer;
  null: string;
  Range: TSynRange;
begin
  if UpdatingControls then Exit;
  if GetNodeType(Tree.Selected) in [ntRange, ntRangeLink] then begin
    if TObject(Tree.Selected.Data) is TSynRange then
      Range := TSynRange(Tree.Selected.Data)
    {###else if TObject(Tree.Selected.Data) is TSynRangeLink then
      Range := TSynRangeLink(Tree.Selected.Data).Range}
    else
      Exit;
    with Range do begin
     {updating multitokens list}
      index := MultiTagIndex;
      popMultiTags.Items[index+5].Caption := 'Open: "'+edFrom.Text+'", Close: "'+edTo.Text+'"'; //temp position of this code?
      //MultiTagIndex := index;
     {updating attributes}

      if chFromEOL.Checked then null := #0 else null := '';
      OpenToken.Symbols[MultiTagIndex] := edFrom.Text + null;
      if chToEOL.Checked then null := #0 else null := '';
      CloseToken.Symbols[MultiTagIndex] := edTo.Text + null;
      Enabled := chEnabledRange.Checked;
      CloseOnTerm := chCloseOnWord.Checked;
      CloseOnEol := chCloseOnEOL.Checked;
      AllowPreviousClose := chCloseParent.Checked;
      CaseSensitive := chCaseRange.Checked;
      Delimiters := StrToSet(edDelimitersRange.Text);
      { the apparently useless typecast to char is for CLX compatibility }
      for i := 1 to Length(edDelimitersRange.Text) do
        Delimiters := Delimiters + [Char(edDelimitersRange.Text[i])];

        if popOpenTagMenu.Items.Items[2].Checked then
          OpenToken.StartLine := slFirst
        else
        if popOpenTagMenu.Items.Items[3].Checked then
          OpenToken.StartLine := slFirstNonSpace
        else
          OpenToken.StartLine := slNotFirst;

        if popCloseTagMenu.Items.Items[2].Checked then
          CloseToken.StartLine := slFirst
        else
        if popCloseTagMenu.Items.Items[3].Checked then
          CloseToken.StartLine := slFirstNonSpace
        else
          CloseToken.StartLine := slNotFirst;

        if popOpenTagMenu.Items.Items[5].Checked then begin
          OpenToken.StartType := stAny;
          OpenToken.BreakType := btAny;
        end else
        if popOpenTagMenu.Items.Items[6].Checked then begin
          OpenToken.StartType := stTerm;
          OpenToken.BreakType := btAny;
        end else
        if popOpenTagMenu.Items.Items[7].Checked then begin
          OpenToken.StartType := stAny;
          OpenToken.BreakType := btTerm;
        end else
        if popOpenTagMenu.Items.Items[8].Checked then begin
          OpenToken.StartType := stTerm;
          OpenToken.BreakType := btTerm;
        end;

        if popCloseTagMenu.Items.Items[5].Checked then begin
          CloseToken.StartType := stAny;
          CloseToken.BreakType := btAny;
        end else
        if popCloseTagMenu.Items.Items[6].Checked then begin
          CloseToken.StartType := stTerm;
          CloseToken.BreakType := btAny;
        end else
        if popCloseTagMenu.Items.Items[7].Checked then begin
          CloseToken.StartType := stAny;
          CloseToken.BreakType := btTerm;
        end else
        if popCloseTagMenu.Items.Items[8].Checked then begin
          CloseToken.StartType := stTerm;
          CloseToken.BreakType := btTerm;
        end;
    end;
  end;
  TotalUpdate();
  Modified();
end;

procedure TfmDesigner.KeywordsChange(Sender: TObject);
begin
  lbKeywordCount.Caption := Format(_Lines, [Memo.Lines.Count]);
  if UpdatingControls then Exit;
  TSynKeyList(Tree.Selected.Data).Enabled := chEnabledKeyList.Checked;
  TSynKeyList(Tree.Selected.Data).KeyList.Text := Memo.Lines.Text;
  TotalUpdate();
  Modified();
end;

procedure TfmDesigner.SetChange(Sender: TObject);
begin
  if UpdatingControls then Exit;
  TSynSet(Tree.Selected.Data).Enabled := chEnabledSet.Checked;
  TSynSet(Tree.Selected.Data).CharSet := StrToSet(edSymbSet.Text);
  TSynSet(Tree.Selected.Data).Quantity := udQuantity.Position;
  //Caption := IntToStr(udQuantity.Position);
  TotalUpdate();
  Modified();
end;

procedure TfmDesigner.FoldRegionChange(Sender: TObject);
{$IFDEF SYN_CodeFolding}
var
  FoldRegion: TFoldRegionItem;
{$ENDIF}
begin
  if UpdatingControls then Exit;
{$IFDEF SYN_CodeFolding}
  FoldRegion := TFoldRegionItem(Tree.Selected.Data);
  with FoldRegion do
  begin
    if rbChar.Checked then
      FoldRegionType := rtChar
    else
      FoldRegionType := rtKeyWord;
    Open             := PChar(edOpen.Text);
    RegExpOpen       := PChar(edOpenRegExpr.Text);
    RegExpUseOpen    := chUseOpenRegExpr.Checked;
    Close            := PChar(edClose.Text);
    RegExpClose      := PChar(edCloseRegExpr.Text);
    RegExpUseClose   := chUseCloseRegExpr.Checked;
    AddEnding        := chAddKeyword.Checked;
    NoSubFoldRegions := chNoSubFolds.Checked;
    WholeWords       := chWholeWords.Checked;
  end;
{$ENDIF}
  TotalUpdate();
  Modified();
end;

//=== Wotk with Attributes ===================================================
procedure TfmDesigner.AttributesChanged(Sender: TObject);
begin
  SetAttributes(Tree.Selected);
end;

procedure TfmDesigner.SetDefaultAttributes(Node: TTreeNode);
begin
  if TObject(Node.Data) is TSynRule then
    with TSynRule(Node.Data).Attributes do begin
      ParentForeground := True;
      ParentBackground := True;
      Foreground := TSynRange(Node.Parent.Data).Attributes.Foreground;
      Background := TSynRange(Node.Parent.Data).Attributes.Background;
      //###OldColorForeground := Foreground; //!!!!!!!!!!!!!!????????????
      //###OldColorBackground := Background;
      Style := [];
    end
end;

procedure TfmDesigner.SetAttributesEnable(AState: Boolean);
begin
  SetAttributesEnable(AState, AState);
end;

procedure TfmDesigner.SetAttributesEnable(AState, AParentState: Boolean);
begin
  chForeground.Enabled    := AParentState;
  chBackground.Enabled    := AParentState;
  frForeColor.Enabled     := AState;
  frBackColor.Enabled     := AState;
  chBold.Enabled          := AState;
  chItalic.Enabled        := AState;
  chUnderline.Enabled     := AState;
  chStrikeOut.Enabled     := AState;
end;

procedure TfmDesigner.SetControlAttributes(Node: TTreeNode;
  AlreadyUpdate: Boolean);
var
  Rule: TSynRule;
  isCustom: Boolean;
  i: Integer;
begin
  UpdatingControls := True;
  {$IFDEF SYN_CodeFolding}
  if GetNodeType(Node) in [ntInfo, {$IFDEF CUSTOMDATA}ntCustomData, {$ENDIF}ntFoldRoot, ntFoldRegion] then
    SetAttributesEnable(False)
  else
  {$ENDIF}
  begin
    if GetNodeType(Node) in [ntRoot] then
      SetAttributesEnable(True, False)
    else
      SetAttributesEnable(True);
  end;
  if TObject(Node.Data) is TSynRule then
  begin
    Rule := TSynRule(Node.Data);
  {###else if TObject(Node.Data) is TSynRangeLink then
    Rule := TSynRangeLink(Node.Data).Range}
    with Rule do begin
      isCustom := True;
      for i := 0 to cbStyle.Items.Count-2 do
        if cbStyle.Items.Strings[i] = Style then begin
          cbStyle.ItemIndex := i;
          isCustom := False;
          continue;
        end;
      if isCustom then begin
        cbStyle.ItemIndex := cbStyle.Items.Count-2;
        //cbStyle.Text := Style;
      end;
      if GetNodeType(Node) in [ntRoot] then begin
        Attributes.ParentForeground := False;   //Need to fix this problem another way... !!!
        Attributes.ParentBackground := False;
      end;
      chForeground.Checked := Attributes.ParentForeground;
      chBackground.Checked := Attributes.ParentBackground;
      if Attributes.ParentForeground then
        frForeColor.Color := TSynRange(Node.Parent.Data).Attributes.Foreground
      else
        frForeColor.Color := Attributes.Foreground;
      if Attributes.ParentBackground then
        frBackColor.Color := TSynRange(Node.Parent.Data).Attributes.Background
      else
        frBackColor.Color := Attributes.Background;
      chBold.Checked      := fsBold      in Attributes.Style;
      chItalic.Checked    := fsItalic    in Attributes.Style;
      chUnderline.Checked := fsUnderline in Attributes.Style;
      chStrikeOut.Checked := fsStrikeOut in Attributes.Style;
    end;
  end else begin
    SetAttributesEnable(False);
    chBold.checked      := False;
    chItalic.checked    := False;
    chUnderline.checked := False;
    chStrikeOut.checked := False;
    frForeColor.Color := clBtnFace;
    frBackColor.Color := clBtnFace; 
  end;
//    raise Exception.Create(ClassName + '.SetControlAttributes - Wrong Node data!');
  if not AlreadyUpdate then UpdatingControls := False;
end;

procedure TfmDesigner.SetAttributes(Node: TTreeNode);
var
  Rule: TSynRule;
begin
  if UpdatingControls then Exit;
  if (Node <> nil) then begin
    if (TObject(Node.Data) is TSynRule) then
      Rule := TSynRule(Node.Data)
    {###else if (TObject(Node.Data) is TSynRangeLink) then
      Rule := TSynRangeLink(Node.Data).Range}
    else
      Exit;
    with Rule.Attributes, Rule do begin
      Style := cbStyle.Text;
      if (ParentForeground and not chForeground.Checked) then begin
        if frForeColor.Color = Foreground then
          ;//###frForeColor.Color := OldColorForeground;
      end
      else if (not ParentForeground and chForeground.Checked) then begin
        //###OldColorForeground := frForeColor.Color;
        frForeColor.Color := TSynRange(Node.Parent.Data).Attributes.Foreground
      end
      else if chForeground.Checked then
        if frForeColor.Color <> Foreground then
          chForeground.Checked := False;

      if (ParentBackground and not chBackground.Checked) then begin
        if frBackColor.Color = Background then
          ;//###frBackColor.Color := OldColorBackground;
      end
      else if (not ParentBackground and chBackground.Checked) then begin
        //###OldColorBackground := frBackColor.Color;
        frBackColor.Color := TSynRange(Node.Parent.Data).Attributes.Background
      end
      else if chBackground.Checked then
        if frBackColor.Color <> Background then
          chBackground.Checked := False;

      ParentForeground := chForeground.Checked;
      ParentBackground := chBackground.Checked;
      Foreground := frForeColor.Color;
      Background := frBackColor.Color;
      Attributes.Style := GetFontStyle(chBold.checked, chItalic.checked, chUnderline.checked,  chStrikeOut.checked);

      {###if Styles <> nil then begin
        Attribs := Styles.GetStyleDef(Style, Attribs);
        SetControlAttributes(Node);
      end;}

      if TObject(Node.data) is TSynRange then
        TSynRange(Node.data).SetColorForChilds;
      TotalUpdate();
    end;
  end;
  Modified();
end;

//============================ D E S I G N ===================================
//=== Splitter CanResize =====================================================
procedure TfmDesigner.SplitterBottomCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  if pTop.Tag <> -1 then begin
    Accept := False;
    Exit;
  end;
  if pBottom.Height <= pBottom.Constraints.MinHeight then
    lbSampMin.Enabled := False
  else
    lbSampMin.Enabled := True;

  if pTop.Height = 0 then lbSampMax.Enabled := False
                     else lbSampMax.Enabled := True;
  if (0 <= NewSize) and (NewSize < 19) then
    NewSize := 0
  else
  if (19 <= NewSize) and (NewSize <= 19+10) then
    NewSize := 19
  else
  if (_pTopHeight-10 <= NewSize) and (NewSize <= _pTopHeight+10) then
    NewSize := _pTopHeight
end;

procedure TfmDesigner.SplitterCannotResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := False;
end;

//=== Label Mouse Leave/Enter ================================================
procedure TfmDesigner.LabelMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := clBtnFace;
end;

procedure TfmDesigner.LabelMouseEnter(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := clRed;
end;

procedure TfmDesigner.LabelContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  LabelMouseLeave(Sender);
end;

//=== CheckBox ===============================================================
procedure TfmDesigner.CheckBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    with (Sender as TCheckBox) do
      Checked := not Checked;
end;

procedure TfmDesigner.DontNeedContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
end;

//=== Show/Hide panels =======================================================
procedure TfmDesigner.ShowHideTree(Sender: TObject);
begin
  if pLeft.Visible then begin
    pLeft.Hide();
    SplitterLeft.Hide();
  end
  else begin
    SplitterLeft.Show();
    pLeft.Show();
  end;
end;

procedure TfmDesigner.ShowHideProp(Sender: TObject);
begin
  if pMiddle.Visible then begin
    pMiddle.Hide();
    SplitterLeft.Hide();
    pLeft.Tag := pLeft.Width;
    pLeft.Align := alClient;
  end
  else begin
    pLeft.Align := alLeft;
    pLeft.Width := pLeft.Tag;
    SplitterLeft.Show();
    pMiddle.Show();
  end;
end;

procedure TfmDesigner.ShowHideAttr(Sender: TObject);
begin
  if pRight.Visible then begin
    pRight.Hide();
    SplitterRight.Hide();
  end
  else begin
    pRight.Show();
    SplitterRight.Show();
  end;
end;

procedure TfmDesigner.ShowHideSamp(Sender: TObject);
begin
  if pBottom.Visible then begin
    pBottom.Hide();
    SplitterBottom.Hide();
    pTop.Tag := pTop.Height;
    pTop.Align := alClient;
  end
  else begin
    pTop.Align := alTop;
    pTop.Height := pTop.Tag;
    SplitterBottom.Show();
    pBottom.Show();
  end;
end;

procedure TfmDesigner.PanelDblClick(Sender: TObject);
begin
  if (Sender as TPanel).Name = 'pBottomCapt' then begin
    if pTop.Height = _pTopHeight then
      lbSampMaxClick(Sender)
    else begin
      pTop.Height := _pTopHeight;
      lbSampMin.Enabled := True;
      if pTop.Tag <> -1 then
        lbSampMinClick(Sender);
      if not pTop.Visible then
        lbSampMaxClick(Sender);
    end;
  end;
end;

//=== Middle panel Resize ====================================================
procedure TfmDesigner.pMiddleResize(Sender: TObject);
begin
  if tabRoot.Width <> pRootButtons.Width then begin
    pRootButtons.ScaleBy(tabRoot.Width, pRootButtons.Width);
    pRootButtons.Height      := 24;
    btAddRangeRoot.Height    := 24;
    btAddKeywordsRoot.Height := 24;
    btAddSetRoot.Height      := 24;
  end;
  if tabRange.Width <> pRangeButtons.Width then begin
    pRangeButtons.ScaleBy(tabRange.Width, pRangeButtons.Width);
    pRangeButtons.Height := 24;
    btAddRange.Height    := 24;
    btAddKeywords.Height := 24;
    btAddSet.Height      := 24;
  end;
end;

//=== Push label clicks ======================================================
procedure TfmDesigner.lbPropBackClick(Sender: TObject);
begin
  if (Tree.Selected <> Tree.Items[0]) and (Tree.Selected <> nil)
   and (Tree.Selected.Parent <> nil) then
    Tree.Selected.Parent.Selected := True;
end;

procedure TfmDesigner.lbRootMenuClick(Sender: TObject);
begin
  popRootMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  LabelMouseLeave(Sender);
end;

procedure TfmDesigner.lbRuleMenuClick(Sender: TObject);
begin
  popPropMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  LabelMouseLeave(Sender);
end;

procedure TfmDesigner.lbSampMaxClick(Sender: TObject);
begin
  if pTop.Visible then begin    //: Not maximized (Maximize)
    pTop.Hide();
    lbSampMax.Caption := '2';
    if pTop.Tag <> -1 then        //: Minimized (Restore)
      lbSampMinClick(Sender);
  end
  else begin                    //: Maximized (Restore)
    pTop.Show();
    lbSampMax.Caption := '1';
  end;
end;
(*
procedure TfmDesigner.lbSampRestoreClick(Sender: TObject);
begin
  pTop.Height := _pTopHeight;
end;
*)
procedure TfmDesigner.lbSampMinClick(Sender: TObject);
begin
  if pTop.Tag = -1 then begin    //: Not minimized (Minimize)
    pTop.Tag := pTop.Height;
    pTop.Height := ClientHeight - pBottom.Constraints.MinHeight - SplitterBottom.Height - pButtons.ClientHeight - StatusBar.ClientHeight - SplitterButtons.ClientHeight;
    lbSampMin.Caption := '2';
    if not pTop.Visible then      //: Miximized (Restore)
      lbSampMaxClick(Sender);
  end
  else begin                    //: Minimized (Restore)
    pTop.Height := pTop.Tag;
    PTop.Tag := -1;
    lbSampMin.Caption := '0';
  end;
end;

//============================ P O P U P S ===================================
//=== Standard PopupMenu =====================================================
procedure TfmDesigner.SetPopupMenuEnables(Edit: TCustomEdit; popMenu: TPopupMenu);
begin
  with popMenu, Edit do begin
    Items[0].Enabled := CanUndo;
    Items[2].Enabled := SelLength <> 0;
    Items[3].Enabled := SelLength <> 0;
    Items[4].Enabled := Clipboard.AsText <> '';
    Items[5].Enabled := Length(Edit.Text) <> 0;//SelLength <> 0;
    Items[7].Enabled := Text <> SelText;
  end;
end;

procedure TfmDesigner.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SetPopupMenuEnables((Sender as TCustomEdit), popStandard);
end;

procedure TfmDesigner.SREdit3Change(Sender: TObject);
{$IFDEF SYN_CodeFolding}
var
  SkipRegion: TSkipRegionItem;
{$ENDIF}
begin
  if UpdatingControls then Exit;
{$IFDEF SYN_CodeFolding}
  SkipRegion := TSkipRegionItem(Tree.Selected.Data);
  SkipRegion.Open := PChar(SREdit2.Text);
  SkipRegion.Close := PChar(SREdit3.Text);
  SkipRegion.Escape := PChar(SREdit4.Text);
  SkipRegion.RegionType := TSkipRegionItemType(SRComboBox1.ItemIndex);
{$ENDIF}
  TotalUpdate();
  Modified();
end;

procedure TfmDesigner.EditContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  SetPopupMenuEnables((Sender as TCustomEdit), popStandard);
end;

procedure TfmDesigner.popUndoClick(Sender: TObject);
begin
  (ActiveControl as TCustomEdit).Undo;
  SetPopupMenuEnables((ActiveControl as TCustomEdit), popStandard);
end;

procedure TfmDesigner.popCutClick(Sender: TObject);
begin
  (ActiveControl as TCustomEdit).CutToClipboard;
  SetPopupMenuEnables((ActiveControl as TCustomEdit), popStandard);
end;

procedure TfmDesigner.popCopyClick(Sender: TObject);
begin
  (ActiveControl as TCustomEdit).CopyToClipboard;
  SetPopupMenuEnables((ActiveControl as TCustomEdit), popStandard);
end;

procedure TfmDesigner.popPasteClick(Sender: TObject);
begin
  (ActiveControl as TCustomEdit).PasteFromClipboard;
  SetPopupMenuEnables((ActiveControl as TCustomEdit), popStandard);
end;

procedure TfmDesigner.popDeleteClick(Sender: TObject);
begin
  if (ActiveControl as TCustomEdit).SelLength = 0 then
    (ActiveControl as TCustomEdit).SelLength := 1;
  (ActiveControl as TCustomEdit).ClearSelection;
  SetPopupMenuEnables((ActiveControl as TCustomEdit), popStandard);
end;

procedure TfmDesigner.popSelectAllClick(Sender: TObject);
begin
  (ActiveControl as TCustomEdit).SelectAll;
  SetPopupMenuEnables((ActiveControl as TCustomEdit), popStandard);
end;

//=== Sample Memo PopupMenu ==================================================
procedure TfmDesigner.SetPopupMenuEnables2(Edit: TCustomSynEdit; popMenu: TPopupMenu);
begin
  with popMenu, Edit do begin
    Items[0].Enabled := (Edit.SelEnd - Edit.SelStart) <> 0;
    Items[2].Enabled := CanUndo;
    Items[4].Enabled := (Edit.SelEnd - Edit.SelStart) <> 0;
    Items[5].Enabled := (Edit.SelEnd - Edit.SelStart) <> 0;
    Items[6].Enabled := Clipboard.AsText <> '';
    Items[7].Enabled := (Edit.SelEnd - Edit.SelStart) <> 0;
    Items[8].Enabled := Text <> SelText;
  end;
end;

procedure TfmDesigner.SampleMemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SetPopupMenuEnables2(SampleMemo, popSampleMemoMenu);
end;

procedure TfmDesigner.SampleMemoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetPopupMenuEnables2(SampleMemo, popSampleMemoMenu);
end;

procedure TfmDesigner.Undo1Click(Sender: TObject);
begin
  SampleMemo.Undo();
end;

procedure TfmDesigner.Cut1Click(Sender: TObject);
begin
  SampleMemo.CutToClipboard();
end;

procedure TfmDesigner.Copy1Click(Sender: TObject);
begin
  SampleMemo.CopyToClipboard();
end;

procedure TfmDesigner.Paste1Click(Sender: TObject);
begin
  SampleMemo.PasteFromClipboard();
end;

procedure TfmDesigner.Delete1Click(Sender: TObject);
begin
  SampleMemo.ClearSelection();
end;

procedure TfmDesigner.SelectAll1Click(Sender: TObject);
begin
  SampleMemo.SelectAll();
end;

procedure TfmDesigner.AddselectedtoKeywords1Click(Sender: TObject);
begin
  if PageControl.ActivePage = tabKeyWords then begin
    Memo.Lines.Add(SampleMemo.SelText);
    TotalUpdate();
  end;
end;

procedure TfmDesigner.AddSkip1Click(Sender: TObject);
begin
  {$IFDEF SYN_CodeFolding}AddingSkipRegion(Tree.Selected);{$ENDIF}
  Modified();
end;

procedure TfmDesigner.popSampleMemoMenuPopup(Sender: TObject);
begin
  popSampleMemoMenu.Items[0].Visible := PageControl.ActivePage = tabKeyWords;
  popSampleMemoMenu.Items[1].Visible := PageControl.ActivePage = tabKeyWords;
end;

//=== Tag Menu Clicks... =====================================================
procedure TfmDesigner.btTagMenuClick(Sender: TObject);
var
  P: TPoint;
begin
//  popTagMenu.Tag := Mouse.CursorPos.X + Mouse.CursorPos.Y shl 16;
  P := (Sender as TButton).ClientToScreen(Point(0, 0));
  if (Sender as TButton).Name = 'btFromMenu' then
    popOpenTagMenu.Popup(P.x, P.y)
  else if (Sender as TButton).Name = 'btToMenu' then
    popCloseTagMenu.Popup(P.x, P.y)
  else if (Sender as TButton).Name = 'btMultiTags' then
    popMultiTags.Popup(P.x, P.y)
//  popTagMenu.Popup(popTagMenu.Tag and $FFFF,
//                   popTagMenu.Tag shr 16);
end;

procedure TfmDesigner.miTagMenuClick(Sender: TObject);
begin
  if not (Sender as TMenuItem).Checked then
    (Sender as TMenuItem).Checked := True;
  RangeChange(Sender);
end;

procedure TfmDesigner.miOpenTagMenuClick(Sender: TObject);
var
  i: Integer;
begin
  i := popOpenTagMenu.Items.IndexOf(Sender as TMenuItem);
  if popOpenTagMenu.Items.Items[5-i].Checked then
    popOpenTagMenu.Items.Items[5-i].Checked := False;
  RangeChange(Sender);
end;

procedure TfmDesigner.miCloseTagMenuClick(Sender: TObject);
var
  i: Integer;
begin
  i := popCloseTagMenu.Items.IndexOf(Sender as TMenuItem);
  if popCloseTagMenu.Items.Items[5-i].Checked then
    popCloseTagMenu.Items.Items[5-i].Checked := False;
  RangeChange(Sender);
end;

//=== TabSheet showing =======================================================
procedure TfmDesigner.tabInfoShow(Sender: TObject);
begin
  popPropMenu := popInfoMenu;
end;

procedure TfmDesigner.tabCustomDataShow(Sender: TObject);
begin
  popPropMenu := popCustomDataMenu;
end;

procedure TfmDesigner.tabRootShow(Sender: TObject);
begin
  popPropMenu := popRootMenu;
end;

procedure TfmDesigner.tabRangeShow(Sender: TObject);
begin
  popPropMenu := popRangeMenu;
end;

procedure TfmDesigner.tabKeywordsShow(Sender: TObject);
begin
  popPropMenu := popKeywordsMenu;
end;

procedure TfmDesigner.tabSetShow(Sender: TObject);
begin
  popPropMenu := popSetMenu;
end;

procedure TfmDesigner.tabSkipRegionShow(Sender: TObject);
begin
  popPropMenu := PopSkipRegionMenu;
end;

procedure TfmDesigner.tabFoldRegionShow(Sender: TObject);
begin
  popPropMenu := popFoldRegionMenu;
end;

procedure TfmDesigner.tabFoldRootShow(Sender: TObject);
begin
  popPropMenu := popFoldRootMenu;
end;

/////////////////////////////////////////////////////////////////////////////////
// RESORTING  RESORTING  RESORTING  RESORTING  RESORTING  RESORTING  RESORTING //
// RESORTING  RESORTING  RESORTING  RESORTING  RESORTING  RESORTING  RESORTING //
// RESORTING  RESORTING  RESORTING  RESORTING  RESORTING  RESORTING  RESORTING //
// RESORTING  RESORTING  RESORTING  RESORTING  RESORTING  RESORTING  RESORTING //
// RESORTING  RESORTING  RESORTING  RESORTING  RESORTING  RESORTING  RESORTING //
// RESORTING  RESORTING  RESORTING  RESORTING  RESORTING  RESORTING  RESORTING //
/////////////////////////////////////////////////////////////////////////////////

//=== Work with files ========================================================
(*procedure TfmDesigner.LoadFromFileClick(Sender: TObject);
resourcestring
  sUniFileDescription = 'UniHighlighter Syntax';
var
  iDlg: TOpenDialog;
  iFile: TFileStream;
  iNode: TTreeNode;
  iRange: TSynRange;
  cSub: Integer;
begin
  { TreeMenuPopup should handle this }
  Assert( TObject(Tree.Selected.Data) is TSynRange );
  iNode := Tree.Selected;
  iRange := TSynRange(iNode.Data);
  iDlg := TOpenDialog.Create( nil );
  try
    iDlg.DefaultExt := '.hgl';
    iDlg.Filter := sUniFileDescription + ' (*.hgl)|*.hgl';
    if not iDlg.Execute then
      Exit;
    iFile := TFileStream.Create( iDlg.FileName, fmOpenRead or fmShareDenyWrite );
    try
      if iRange = SynUniSyn.MainRules then
      begin
        SynUniSyn.LoadFromStream( iFile );
        Tree.Items.Clear();
        FillTree();
        SampleMemo.Lines.Text := SynUniSyn.SampleSource;
        iNode := Tree.Items[0];
      end
      else begin
        iRange.LoadFromStream( iFile );
        iNode.DeleteChildren();
        for cSub := 0 to iRange.KeyListCount - 1 do
          TreeAddKeyList( iNode, iRange.KeyLists[cSub] );
        for cSub := 0 to iRange.RangeCount - 1 do
          TreeAddRange( iNode, iRange.Ranges[cSub] );
      end;
      iNode.Expand( False );
      TotalUpdate();
    finally
      iFile.Free();
    end;
  finally
    iDlg.Free();
  end;
  Modified();
end;*)

procedure TfmDesigner.rootSaveToFileClick(Sender: TObject);
begin
  if SaveDialog.Execute() then
    SynUniSyn.SaveToFile(SaveDialog.FileName);
end;

procedure TfmDesigner.rootLoadFromFileClick(Sender: TObject);
var
  Ext: string;
  EditPlus: TSynUniFormatEditPlus;
  UltraEdit: TSynUniFormatUltraEdit;
begin
  if OpenDialog.Execute() then begin
    Ext := ExtractFileExt(OpenDialog.FileName);
    try
      if SameText(Ext, '.hgl') or SameText(Ext, '.hlr') then
        SynUniSyn.LoadFromFile(OpenDialog.FileName)
      else
      if SameText(Ext, '.stx') then begin
        TSynUniFormatEditPlus.ImportFromFile(SynUniSyn, OpenDialog.FileName);
        {EditPlus := TSynUniFormatEditPlus.Create();
        EditPlus.LoadFromFile(OpenDialog.FileName);
        EditPlus.Import(SynUniSyn.MainRules, SynUniSyn.Info);
        EditPlus.Free;}
      end else
      if SameText(Ext, '.txt') then begin
        TSynUniFormatUltraEdit.ImportFromFile(SynUniSyn, OpenDialog.FileName);
        {UltraEdit := TSynUniFormatUltraEdit.Create();
        UltraEdit.LoadFromFile(OpenDialog.FileName);
        UltraEdit.Import(SynUniSyn.MainRules, SynUniSyn.Info);
        UltraEdit.Free;}
{      else // '.hlr'
        SynUniSyn.LoadFromFile(OpenDialog.FileName);}
      end else
        raise Exception.Create(ClassName + '.rootLoadFromFile - Bad file extension!'); 
    finally
      Tree.Items.Clear();
      FillTree();
      SampleMemo.Lines.Text := SynUniSyn.SampleSource;
      Tree.Items[0].Expand(False);
      TotalUpdate();
      Modified();
    end;
  end;
end;

procedure TfmDesigner.rangeLoadFromFileClick(Sender: TObject);
begin
  if OpenDialog.Execute() then begin
    if Application.MessageBox('It will delete current rule. Continue?', PChar(_Confirm), MB_OKCANCEL+MB_ICONQUESTION) = ID_OK then begin
      DeleteNode(Tree.Selected, True);
      TSynRule(Tree.Selected.Data).LoadFromFile(OpenDialog.FileName); //Сделат? чт?можн?загрузит?Keywords ?Ranges ???..
      TreeAddRange(Tree.Selected, Tree.Selected.Data, akReplace);
      TreeChange(Sender, Tree.Selected);
      Tree.Selected.Text := TSynRule(Tree.Selected.Data).Name;
      Tree.Items[0].Expand(False);
      TotalUpdate();
      Modified();
    end;
  end;
end;

procedure TfmDesigner.rangeSaveToFileClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    TSynRule(Tree.Selected.Data).SaveToFile(SaveDialog.FileName);
end;

//=== Clipboard ==============================================================
procedure TfmDesigner.StreamToClipboard(Stream: TStream);
var
  Buf: PChar;
  BufSize: Integer;
begin
  buf := nil; // Чтоб?убрать Warning компилятора
  try
    BufSize := Stream.Size;
    GetMem(Buf, BufSize+1);
    Stream.Position := 0;
    Stream.ReadBuffer(Buf^, BufSize);
    Buf[BufSize] := #0;
    Clipboard.SetTextBuf(Buf);
  finally
    FreeMem(Buf);
    Stream.Free();
  end;
end;

function TfmDesigner.GetClipboardAsStream: TMemoryStream;
var
  hClipbrd: THandle;
  Buf: PChar;
begin
  Result := TMemoryStream.Create();
  ClipBoard.Open;
  try
    hClipbrd := Clipboard.GetAsHandle(CF_TEXT);
    Buf := GlobalLock(hClipbrd);
    Result.WriteBuffer(Buf^, StrLen(Buf));
    Result.Position := 0;
    GlobalUnlock(hClipbrd);
  finally
    Clipboard.Close;
  end;
end;

//=== Root range =============================================================
procedure TfmDesigner.rootCutClick(Sender: TObject);
begin
  rootCopyClick(Sender);
  ShowDialog := False;
  DoDeleteNode(Sender);
end;

procedure TfmDesigner.rootCopyClick(Sender: TObject);
begin
  StreamToClipboard(SynUniSyn.GetAsStream());
end;

procedure TfmDesigner.rootPasteInsideClick(Sender: TObject);
begin
  Tree.Selected.Selected := False;
  Tree.Selected := Tree.Items[0];
  rangePasteInsideClick(Sender);
end;

procedure TfmDesigner.rootPasteAndReplaceClick(Sender: TObject);
begin
  Tree.Selected := Tree.Items[0];
  DeleteNode(Tree.Selected, True);
  SynUniSyn.LoadFromStream(GetClipboardAsStream);
  TreeAddRange(Tree.Selected, SynUniSyn.MainRules, akReplace);
  TreeChange(nil, Tree.Selected);
  Tree.Selected.Text := TSynRule(Tree.Selected.Data).Name;
  SampleMemo.Text := SynUniSyn.Info.General.Sample;
  TotalUpdate();
  Modified();
end;

//=== Other rules ============================================================
procedure TfmDesigner.rangeCutClick(Sender: TObject);
begin
  rangeCopyClick(Sender);
  ShowDialog := False;
  DoDeleteNode(Sender);
end;

procedure TfmDesigner.rangeCopyClick(Sender: TObject);
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  TSynRule(Tree.Selected.Data).SaveToStream(Stream);
  StreamToClipboard(Stream);
end;

procedure TfmDesigner.rangePasteInsideClick(Sender: TObject);
var
  Rule: TSynRule;
var
  XMLDocument: IXMLDocument; //TODO: сделат?ка?то парсер?независимы?..
begin
  XMLDocument := CreateXmlDocument('');
  XMLDocument.Load(GetClipboardAsStream());
  if (XMLDocument.DocumentElement.NodeName = 'UniHighlighter') or (XMLDocument.DocumentElement.NodeName = 'Range') then
    Rule := TSynRange.Create() else
  if (XMLDocument.DocumentElement.NodeName = 'KeyList') then
    Rule := TSynKeyList.Create() else
  if (XMLDocument.DocumentElement.NodeName = 'Set') then
    Rule := TSynSet.Create()
  else
    Exit;
  Rule.LoadFromStream(GetClipboardAsStream());
  TSynRange(Tree.Selected.Data).AddRule(Rule);
//  Tree.MultiSelect := False;
  with TreeAddRule(Tree.Selected, Rule) do Selected := True;
  TotalUpdate();
//  Tree.MultiSelect := True;
  Modified();
end;

procedure TfmDesigner.rangePasteAndReplaceClick(Sender: TObject);
begin
  if Application.MessageBox('It will delete current rule. Continue?', PChar(_Confirm), MB_OKCANCEL+MB_ICONQUESTION) = ID_OK then begin
    DeleteNode(Tree.Selected, True);
    TSynRule(Tree.Selected.Data).LoadFromStream(GetClipboardAsStream());
    TreeAddRange(Tree.Selected, Tree.Selected.Data, akReplace);
    TreeChange(Sender, Tree.Selected);
    Tree.Selected.Text := TSynRule(Tree.Selected.Data).Name;
    TotalUpdate();
    Modified();
  end;
end;

procedure TfmDesigner.rangePasteNextToClick(Sender: TObject);
var
  Rule: TSynRule;
var
  XMLDocument: IXMLDocument;
begin
  XMLDocument := CreateXmlDocument('');
  XMLDocument.Load(GetClipboardAsStream());
  if (XMLDocument.DocumentElement.NodeName = 'UniHighlighter') or (XMLDocument.DocumentElement.NodeName = 'Range') then
    Rule := TSynRange.Create() else
  if (XMLDocument.DocumentElement.NodeName = 'KeyList') then
    Rule := TSynKeyList.Create() else
  if (XMLDocument.DocumentElement.NodeName = 'Set') then
    Rule := TSynSet.Create()
  else
    Exit;
  Rule.LoadFromStream(GetClipboardAsStream());
  TSynRange(Tree.Selected.Parent.Data).AddRule(Rule);
  with TreeAddRule(Tree.Selected, Rule, akInsert) do Selected := True;
  TotalUpdate();
  Modified();
end;

//=== UNSORTED ===============================================================
procedure TfmDesigner.rootInfoClick(Sender: TObject);
var InfoText: string;
begin
  with SynUniSyn.Info do begin
    if General.Name <> ''       then InfoText := InfoText + Format(_Name, [General.Name]) + #13#10
                                else InfoText := InfoText + Format(_Name, ['<Noname>']) + #13#10;
    if General.Extensions <> '' then InfoText := InfoText + Format(_Extensions, [General.Extensions]) + #13#10;
    InfoText := InfoText + Format(_Version, [IntToStr(General.Version) + '.' + IntToStr(General.Revision)]) + #13#10;
    //InfoText := InfoText + Format(_Date, [DateTimeToStr(Version.ReleaseDate)]) + #13#10;
    if Author.Name <> ''      then InfoText := InfoText + Format(_Author, [Author.Name]) + #13#10;
    if Author.Email <> ''     then InfoText := InfoText + Format(_Mail, [Author.Email]) + #13#10;
    if Author.Web <> ''       then InfoText := InfoText + Format(_Web, [Author.Web]) + #13#10;
    if Author.Copyright <> '' then InfoText := InfoText + Format(_Copyright, [Author.Copyright]) + #13#10;
    if Author.Company <> ''   then InfoText := InfoText + Format(_Company, [Author.Company]) + #13#10;
    if Author.Remark <> ''    then InfoText := InfoText + Format(_Remark, [Author.Remark]) + #13#10;
    Application.MessageBox(PChar(InfoText),'About highlighter...', MB_ICONINFORMATION);
  end;
end;

procedure TfmDesigner.btStylesFileClick(Sender: TObject);
//var
  //###xml: TXMLParser;
begin
  //if OpenDialog2.Execute() then begin
    {###edStylesFile.Text := OpenDialog2.FileName;
    ComboBox2.Clear();
    xml := TXMLParser.Create();
    try
      if xml.LoadFromFile(edStylesFile.Text) then begin
        xml.StartScan();
        while xml.Scan() do
          if (xml.CurPartType = ptStartTag) and SameText(xml.CurName, 'Scheme') then
            ComboBox2.Items.Add(xml.CurAttr.Value('Name'));
      end;
    finally
      xml.Free();
    end;
    ComboBox2.ItemIndex := 0;}
  //end;
end;
//============================================================================

//----------------------------------------------------------------------------
procedure TfmDesigner.SampleMemoChange(Sender: TObject);
begin
  {$IFDEF SYN_CodeFolding}SampleMemo.InitCodeFolding();{$ENDIF}
end;

//----------------------------------------------------------------------------
procedure TfmDesigner.Addcoupletags1Click(Sender: TObject);
var
  Range: TSynRange;
begin
  Range := TSynRange(Tree.Selected.Data);
  if Assigned(Range) then
    with Range do
    begin
      AddCoupleTokens('', '');
      popMultiTags.Items.Add(TMenuItem.Create(Self));
      with popMultiTags.Items.Items[popMultiTags.Items.Count-1] do begin
        Caption := 'New couple tags';
        OnClick := cbWordChange;
        RadioItem := True;
        {$IFDEF SYN_COMPILER_6_UP}
        AutoCheck := True;
        {$ENDIF}
        GroupIndex := 1;
      end;
      MultiTagIndex := popMultiTags.Items.Count-5 - 1;
      cbWordChange(Sender);
      RangeChange(Sender);
    end;
  Modified();
end;

//----------------------------------------------------------------------------
procedure TfmDesigner.Deletecoupletags1Click(Sender: TObject);
var
  index: Integer;
  Range: TSynRange;
begin
  if popMultiTags.Items.Count-5 = 1 then
  begin
    Application.MessageBox('The last MultiToken can not be deleted!', 'Information', MB_ICONERROR + MB_OK);
    Exit;
  end;

  Range := TSynRange(Tree.Selected.Data);
  if Assigned(Range) then
    with Range do
    begin
      DeleteCoupleTokens(MultiTagIndex);
      index := MultiTagIndex;
      popMultiTags.Items.Delete(MultiTagIndex+5);
      if index < popMultiTags.Items.Count-5 then
        MultiTagIndex := index
      else
        MultiTagIndex := popMultiTags.Items.Count-5 - 1;
      cbWordChange(Sender);
      RangeChange(Sender);
    end;
end;

//----------------------------------------------------------------------------
procedure TfmDesigner.cbWordChange(Sender: TObject);
var
  Range: TSynRange;
begin
  if not (Sender as TMenuItem).Checked then
    (Sender as TMenuItem).Checked := True;
  if MultiTagIndex > -1 then
  begin
    Range := TSynRange(Tree.Selected.Data);
    if Assigned(Range) then
      with Range do
      begin
        UpdatingControls := True;
        edFrom.Text := OpenToken.Symbols[MultiTagIndex];
        edTo.Text := CloseToken.Symbols[MultiTagIndex];
        UpdatingControls := False;
      end;
  end;
end;

//----------------------------------------------------------------------------
function TfmDesigner.GetMultiTagIndex(): Integer;
var
  i: Integer;
begin
  for i := 5 to popMultiTags.Items.Count-1 do
    if popMultiTags.Items[i].Checked then
      Result := i-5;
end;

//----------------------------------------------------------------------------
procedure TfmDesigner.SetMultiTagIndex(Value: Integer);
begin
  popMultiTags.Items[Value+5].Checked := True;
end;

//----------------------------------------------------------------------------
procedure TfmDesigner.udQuantityClick(Sender: TObject; Button: TUDBtnType);
begin
  SetChange(Sender);
end;

//----------------------------------------------------------------------------
procedure TfmDesigner.lbFormatVersionClick(Sender: TObject);
var
  FormatVersion: string;
begin
{  FormatVersion := InputBox('Version of file format for saving in', 'Input version of file format ("1.5", "1.8" or "2.0"):', lbFormatVersion.Caption);
  if (FormatVersion = '1.5') or (FormatVersion = '1.8') or (FormatVersion = '2.0') then
  begin
    SynUniSyn.FormatVersion := FormatVersion;
    lbFormatVersion.Caption := FormatVersion;
  end;}
end;

procedure TfmDesigner.udVersionClick(Sender: TObject; Button: TUDBtnType);
begin
  InfoChange(Sender);
end;

procedure TfmDesigner.btAddClick(Sender: TObject); //TODO: не позволять дубликатов по Name
var
  Name, Value: string;
begin
  Name := InputBox('Input entry name', 'Input entry name:', '');
  if Name = '' then Exit;
  Value := InputBox('Input entry value', 'Input entry value:', '');
  mmCustomData.Lines.Add(Name+'='+Value);
end;

procedure TfmDesigner.btDeleteClick(Sender: TObject);
begin
  mmCustomData.Lines.Delete(mmCustomData.CaretPos.Y);
end;

procedure TfmDesigner.mmCustomDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_INSERT then
    btAddClick(Sender)
  else if (Key = VK_DELETE) and (ssCtrl in Shift) then
  begin
    Key := 0;
    btDeleteClick(Sender);
  end;
end;

procedure TfmDesigner.FormDestroy(Sender: TObject);
begin
  ColorBoxDataModule.Free();
end;

procedure TfmDesigner.lbEntryCountClick(Sender: TObject);
var
  List: TStringList;
  i, Number: Integer;
begin
  List := TStringList.Create();
  List.Text := mmCustomData.Text;
  Number := 0;
  for i := 0 to List.Count-1 do
    if Pos('=', List[i]) > 1 then
      Inc(Number);
  List.Free();
  lbEntryCount.Caption := 'Entry count: '+IntToStr(Number);
end;

end.

