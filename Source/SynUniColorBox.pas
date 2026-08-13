unit SynUniColorBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF SYN_COMPILER_6_UP}Variants,{$ENDIF} 
  ExtCtrls, Menus;

type
  TFrameColor = class(TFrame)
    pColorBox: TPanel;
    pColor: TPanel;
    pColorArrow: TPanel;
    procedure pColorArrowMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pColorClick(Sender: TObject);
    procedure FrameContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private declarations }
    //FOnChange: TNotifyEvent;
    function GetColor(): TColor;
    procedure SetColor(Value: TColor);
  protected
    procedure SetEnabled(Value: Boolean); override;
  public
    { Public declarations }
    procedure DoChange();
    property Color: TColor read GetColor write SetColor;
    //property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

uses SynUniColorBoxDataModule;

{$R *.dfm}

//----------------------------------------------------------------------------
procedure TFrameColor.SetEnabled(Value: Boolean);
begin
  inherited;
  if Value then
    pColorArrow.Font.Color := clWindowText
  else
    pColorArrow.Font.Color := clGrayText;
end;

//----------------------------------------------------------------------------
procedure TFrameColor.DoChange();
begin
  Self.Click();
end;

//----------------------------------------------------------------------------
function TFrameColor.GetColor(): TColor;
begin
  Result := pColor.Color;
end;

//----------------------------------------------------------------------------
procedure TFrameColor.SetColor(Value: TColor);
begin
  pColor.Color := Value;
end;

//----------------------------------------------------------------------------
procedure TFrameColor.pColorClick(Sender: TObject);
//: Handle clicking on Color panel (Show ColorBox to choose color)
begin
  with TColorDialog.Create(Self) do
    try
      Color := pColor.Color;
      CustomColors.Text :=
        'ColorA=' + IntToHex(Color, 6) + #13#10+
        'ColorB=FFFFEE'+#13#10+'ColorC=EEFFFF'+#13#10+'ColorD=EEFFEE'+#13#10+
        'ColorE=EEEEFF'+#13#10+'ColorF=FFEEEE'+#13#10+'ColorG=EEEEEE'+#13#10+
        'ColorH=FFEEAA'+#13#10+'ColorJ=FFAAEE'+#13#10+'ColorK=AAFFEE'+#13#10+
        'ColorI=AAEEFF'+#13#10+'ColorL=EEFFAA'+#13#10+'ColorM=EEAAFF'+#13#10+
        'ColorN=AAAAAA'+#13#10+'ColorO=DDDDDD'+#13#10+'ColorP=999999';
      {$IFNDEF SYN_CLX}Options := [cdFullOpen];{$ENDIF} //???
      if Execute() then
        begin
          pColor.Color := Color;
          DoChange();
        end;
    finally
      Free();
    end;
end;

//----------------------------------------------------------------------------
procedure TFrameColor.pColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with ColorBoxDataModule do
  begin
    ColorPanel := Self;
    if (Button = mbMiddle) then
      popColorSys.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
    else if ((Button = mbRight) and (ssLeft in Shift)) then
      popColorAdv.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
    else
    if Button = mbRight then begin
      if ssShift in Shift then
        popColorAdv.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
      else
        popColorStd.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    end;
  end;
end;

//----------------------------------------------------------------------------
procedure TFrameColor.pColorArrowMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with ColorBoxDataModule do
  begin
    ColorPanel := Self;
    pColorArrow.BevelInner := bvLowered;
    if (Button = mbLeft) then
      popColorStd.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    if (Button = mbMiddle) then
      popColorAdv.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
    else if ((Button = mbRight) and (ssLeft in Shift)) then
      popColorAdv.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
    else
    if Button = mbRight then begin
      if ssShift in Shift then
        popColorAdv.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
      else
        popColorSys.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    end;
    pColorArrow.BevelInner := bvNone;
  end;
end;

//----------------------------------------------------------------------------
procedure TFrameColor.FrameContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  Handled := True;
end;

end.
