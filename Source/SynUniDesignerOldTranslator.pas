unit SynUniDesignerOldTranslator;

interface

uses
  SysUtils, Classes, IniFiles,
  SynUniDesignerForm, SynUniColorBoxDataModule;

type
  TSynUniDesignerOldTranslator = class
    class function Translate(ADesignerForm: TfmDesigner; ALangFile: string): Boolean;
  end;

implementation

class function TSynUniDesignerOldTranslator.Translate(ADesignerForm: TfmDesigner; ALangFile: string): Boolean;
var
  L: TStringList;
begin
  L := TStringList.Create();
  if (ALangFile <> '') and FileExists(ALangFile) then
    L.LoadFromFile(ALangFile);

  with ADesignerForm do
  begin
    if Length(L.Values['2000'])>2 then Caption := L.Values['2000'] + ' - [' + SynUniSyn.Info.General.Name + ']';
    with popPanels do begin
      if Length(L.Values['2001'])>2 then Items[0].Caption := L.Values['2001'];
      if Length(L.Values['2002'])>2 then Items[1].Caption := L.Values['2002'];
      if Length(L.Values['2003'])>2 then Items[2].Caption := L.Values['2003'];
      if Length(L.Values['2004'])>2 then Items[3].Caption := L.Values['2004'];
    end;

    if Length(L.Values['2010'])>2 then btOk.Caption     := L.Values['2010'];
    if Length(L.Values['2011'])>2 then btCancel.Caption := L.Values['2011'];
    if Length(L.Values['2012'])>2 then btApply.Caption  := L.Values['2012'];

    with popStandard do begin
      if Length(L.Values['2013'])>2 then Items[0].Caption := L.Values['2013'];
      if Length(L.Values['2014'])>2 then Items[2].Caption := L.Values['2014'];
      if Length(L.Values['2015'])>2 then Items[3].Caption := L.Values['2015'];
      if Length(L.Values['2016'])>2 then Items[4].Caption := L.Values['2016'];
      if Length(L.Values['2017'])>2 then Items[5].Caption := L.Values['2017'];
      if Length(L.Values['2018'])>2 then Items[7].Caption := L.Values['2018'];
    end;

    with popSampleMemoMenu do begin
      if Length(L.Values['2013'])>2 then Items[2].Caption := L.Values['2013'];
      if Length(L.Values['2014'])>2 then Items[4].Caption := L.Values['2014'];
      if Length(L.Values['2015'])>2 then Items[5].Caption := L.Values['2015'];
      if Length(L.Values['2016'])>2 then Items[6].Caption := L.Values['2016'];
      if Length(L.Values['2017'])>2 then Items[7].Caption := L.Values['2017'];
      if Length(L.Values['2018'])>2 then Items[9].Caption := L.Values['2018'];
    end;

    if Length(L.Values['2020'])>2 then _Modified := L.Values['2020'];
    if Length(L.Values['2030'])>2 then _DeleteNode   := L.Values['2030'];
    if Length(L.Values['2031'])>2 then _SaveChanges  := L.Values['2031'];
    if Length(L.Values['2032'])>2 then _EnterName    := L.Values['2032'];
    if Length(L.Values['2033'])>2 then _DeleteScheme := L.Values['2033'];
    if Length(L.Values['2034'])>2 then _Confirm := L.Values['2034'];

    if Length(L.Values['2100'])>2 then pLeftCapt.Caption := L.Values['2100'];
    if Length(L.Values['2200'])>2 then pMiddleCapt.Caption := L.Values['2200'];
    if Length(L.Values['2201'])>2 then lbPropBack.Hint := L.Values['2201'];
    if Length(L.Values['2202'])>2 then lbRuleMenu.Hint := L.Values['2202'];

    with popRootMenu do begin
      if Length(L.Values['2305'])>2 then Items[8].Caption := L.Values['2305'];
      if Length(L.Values['2306'])>2 then Items[9].Caption := L.Values['2306'];
      if Length(L.Values['2307'])>2 then Items[10].Caption := L.Values['2307'];
      if Length(L.Values['2204'])>2 then Items[13].Caption := L.Values['2204'];    
    end;  
    with popRangeMenu do begin
      if Length(L.Values['2203'])>2 then Items[0].Caption := L.Values['2203'];
      if Length(L.Values['2204'])>2 then Items[16].Caption := L.Values['2204'];
      if Length(L.Values['2406'])>2 then Items[11].Caption := L.Values['2406'];
      if Length(L.Values['2407'])>2 then Items[12].Caption := L.Values['2407'];
      if Length(L.Values['2408'])>2 then Items[13].Caption := L.Values['2408'];
    end;
    with popKeywordsMenu do begin
      if Length(L.Values['2203'])>2 then Items[0].Caption := L.Values['2203'];
      if Length(L.Values['2204'])>2 then Items[11].Caption := L.Values['2204'];
    end;
    with popSetMenu do begin
      if Length(L.Values['2203'])>2 then Items[0].Caption := L.Values['2203'];
      if Length(L.Values['2204'])>2 then Items[11].Caption := L.Values['2204'];
    end;

    if Length(L.Values['2300'])>2 then chCaseRoot.Caption        := L.Values['2300'];
    if Length(L.Values['2300'])>2 then chCaseRange.Caption       := L.Values['2300'];
    if Length(L.Values['2301'])>2 then btAddRangeRoot.Caption    := L.Values['2301'];
    if Length(L.Values['2301'])>2 then btAddRange.Caption        := L.Values['2301'];
    if Length(L.Values['2302'])>2 then btAddKeywordsRoot.Caption := L.Values['2302'];
    if Length(L.Values['2302'])>2 then btAddKeywords.Caption     := L.Values['2302'];
    if Length(L.Values['2303'])>2 then btAddSetRoot.Caption      := L.Values['2303'];
    if Length(L.Values['2303'])>2 then btAddSet.Caption          := L.Values['2303'];
    if Length(L.Values['2304'])>2 then lbDelimitersRoot.Caption  := L.Values['2304'];
    if Length(L.Values['2304'])>2 then lbDelimitersRange.Caption := L.Values['2304'];

    if Length(L.Values['2400'])>2 then lbRangeFrom.Caption   := L.Values['2400'];
    if Length(L.Values['2401'])>2 then lbRangeTo.Caption     := L.Values['2401'];
    if Length(L.Values['2402'])>2 then chCloseOnWord.Caption := L.Values['2402'];
    if Length(L.Values['2403'])>2 then chCloseOnEOL.Caption  := L.Values['2403'];
    if Length(L.Values['2404'])>2 then chCloseParent.Caption := L.Values['2404'];

    if Length(L.Values['2501'])>2 then btSort.Hint        := L.Values['2501'];
    if Length(L.Values['2502'])>2 then btLowercase.Hint   := L.Values['2502'];
    if Length(L.Values['2503'])>2 then btSpacesToEol.Hint := L.Values['2503'];

    if Length(L.Values['2600'])>2 then lbSymbSet.Caption := L.Values['2600'];

    if Length(L.Values['2700'])>2 then pRightCapt.Caption   := L.Values['2700'];
    if Length(L.Values['2701'])>2 then chForeground.Caption := L.Values['2701'];
    if Length(L.Values['2702'])>2 then chBackground.Caption := L.Values['2702'];
    if Length(L.Values['2703'])>2 then chBold.Caption       := L.Values['2703'];
    if Length(L.Values['2704'])>2 then chItalic.Caption     := L.Values['2704'];
    if Length(L.Values['2705'])>2 then chUnderline.Caption  := L.Values['2705'];
    if Length(L.Values['2706'])>2 then chStrikeOut.Caption  := L.Values['2706'];
  {  if Length(L.Values['2707'])>2 then lbScheme.Caption     := L.Values['2707'];
    if Length(L.Values['2708'])>2 then btNewScheme.Caption  := L.Values['2708'];
    if Length(L.Values['2709'])>2 then btDelScheme.Caption  := L.Values['2709'];}

    if Length(L.Values['2800'])>2 then pBottomCapt.Caption := L.Values['2800'];
    if Length(L.Values['2801'])>2 then lbSampMin.Hint := L.Values['2801'];
    if Length(L.Values['2802'])>2 then lbSampMax.Hint := L.Values['2802'];

    L.Free;
  end;
end;

end.
