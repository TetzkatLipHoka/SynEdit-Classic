unit SynUniColorBoxDataModule;

interface

uses
  Forms, SysUtils, Classes, Menus, ImgList, Controls, ExtCtrls, Graphics,
  SynUniColorBox;

type
  TColorBoxDataModule = class(TDataModule)
    popColorStd: TPopupMenu;
    popColorAdv: TPopupMenu;
    popColorSys: TPopupMenu;
    listColors16: TImageList;
    listColors40: TImageList;
    listColorsSys: TImageList;
    procedure DataModuleCreate(Sender: TObject);
    procedure miColor16Click(Sender: TObject);
    procedure miColorSysClick(Sender: TObject);
    procedure miColor40Click(Sender: TObject);
    procedure Color40MeasureItem(Sender: TObject; ACanvas: TCanvas;
      var Width, Height: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    ColorPanel: TFrameColor;
    procedure AddBitmapColor(out AImageList: TImageList; AColor: TColor);
    procedure CreateMenuItem(out APopupMenu: TPopupMenu; ACaption: TCaption;
      AOnClick: TNotifyEvent; AImageIndex: Integer);
  end;

var
  ColorBoxDataModule: TColorBoxDataModule;

const
  Colors16: array [0..15] of TColor = (clBlack, clMaroon, clGreen, clOlive,
    clNavy, clPurple, clTeal, clGray, clSilver, clRed, clLime, clYellow,
    clBlue, clFuchsia, clAqua, clWhite);
  Colors16s: array [0..15] of string = ('Black', 'Maroon', 'Green', 'Olive',
    'Navy', 'Purple', 'Teal', 'Gray', 'Silver', 'Red', 'Lime', 'Yellow',
    'Blue', 'Fuchsia', 'Aqua', 'White');
  Colors40: array [0..39] of TColor = (
    $000000, $000080, $0000FF, $FF00FF, $CC99FF, $003399, $0066FF, $0099FF,
    $00CCFF, $99CCFF, $003333, $008080, $00CC99, $00FFFF, $99FFFF, $003300,
    $008000, $669933, $00FF00, $CCFFCC, $663300, $808000, $CCCC33, $FFFF00,
    $FFFFCC, $800000, $FF0000, $FF6633, $FFCC00, $FFCC99, $993333, $996666,
    $800080, $663399, $FF99CC, $333333, $808080, $969696, $C0C0C0, $FFFFFF);
  ColorsSys: array [0..27] of TColor = (clActiveBorder, clActiveCaption,
    clAppWorkSpace, clBackground, clBtnFace, clBtnHighlight, clBtnShadow,
    clBtnText, clCaptionText, clDefault,
    {$IFDEF SYN_COMPILER_6_UP}
    clGradientActiveCaption, clGradientInactiveCaption,
    {$ELSE}
    clActiveCaption, clInactiveCaption,
    {$ENDIF}
    clGrayText, clHighlight, clHighlightText,
    clInactiveBorder, clInactiveCaption, clInactiveCaptionText,
    clInfoBk, clInfoText, clMenu, clMenuText, clScrollBar, cl3DDkShadow,
    cl3DLight, clWindow, clWindowFrame, clWindowText);

implementation

{$R *.dfm}

procedure TColorBoxDataModule.AddBitmapColor(out AImageList: TImageList; AColor: TColor);
var
  Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create();
  with Bitmap, Bitmap.Canvas do begin
    Width := 16; Height := 16;
    Brush.Color := clBtnFace;    FillRect(Rect(0, 0, 16, 16));
    Brush.Color := AColor;       Rectangle(1, 1, 15, 15);
    AImageList.AddMasked(Bitmap, clBtnFace);
  end;
  Bitmap.Free;
end;

procedure TColorBoxDataModule.CreateMenuItem(out APopupMenu: TPopupMenu;
  ACaption: TCaption; AOnClick: TNotifyEvent; AImageIndex: Integer);
begin
  APopupMenu.Items.Add(TMenuItem.Create(Self));
  with APopupMenu.Items.Items[APopupMenu.Items.Count-1] do begin
    Caption := ACaption;
    ImageIndex := AImageIndex;
    OnClick := AOnClick;
  end;
end;

procedure TColorBoxDataModule.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
  popColorStd.Images := listColors16;
  for i := 0 to 15 do begin
    AddBitmapColor(listColors16, Colors16[i]);
    CreateMenuItem(popColorStd, Colors16s[i], miColor16Click, i);
  end;
  popColorStd.Items[8].Break := mbBarBreak;

  popColorAdv.Images := listColors40;
  for i := 0 to 39 do begin
    AddBitmapColor(listColors40, Colors40[i]);
    CreateMenuItem(popColorAdv, '', miColor40Click, i);
    popColorAdv.Items.Items[i].OnMeasureItem := Color40MeasureItem;
  end;
  for i := 1 to 7 do
    popColorAdv.Items[5*i].Break := mbBreak;

  popColorSys.Images := listColorsSys;
  for i := 0 to 27 do begin
    AddBitmapColor(listColorsSys, ColorsSys[i]);
    CreateMenuItem(popColorSys, ColorToString(ColorsSys[i]), miColorSysClick, i);
  end;
  popColorSys.Items[14].Break := mbBarBreak;
end;

procedure TColorBoxDataModule.miColor16Click(Sender: TObject);
begin
  ColorPanel.pColor.Color := Colors16[(Sender as TMenuItem).ImageIndex];
  ColorPanel.DoChange();
end;

procedure TColorBoxDataModule.miColorSysClick(Sender: TObject);
begin
  ColorPanel.pColor.Color := ColorsSys[(Sender as TMenuItem).ImageIndex];
  ColorPanel.DoChange();
end;

procedure TColorBoxDataModule.miColor40Click(Sender: TObject);
begin
  ColorPanel.pColor.Color := Colors40[(Sender as TMenuItem).ImageIndex];
  ColorPanel.DoChange();
end;

procedure TColorBoxDataModule.Color40MeasureItem(Sender: TObject; ACanvas: TCanvas;
  var Width, Height: Integer);
begin
  Width := 6;
end;

end.
