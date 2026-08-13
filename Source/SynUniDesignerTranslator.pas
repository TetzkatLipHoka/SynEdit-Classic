unit SynUniDesignerTranslator;

interface

uses
  SysUtils, Classes, IniFiles, Menus, Dialogs,
  SynUniDesignerForm, SynUniColorBoxDataModule;

type
  TSynUniDesignerTranslator = class
    class function Translate(ADesignerForm: TfmDesigner; ALangFile: string): Boolean;
  end;

implementation

class function TSynUniDesignerTranslator.Translate(ADesignerForm: TfmDesigner; ALangFile: string): Boolean;
var
  List: TStringList;
  Ini: TIniFile;
  i: Integer;

  procedure ReadSection(Name: string);
  begin
    Ini.ReadSectionValues(Name, List);
  end;

  function GetTranslate(Name: string): string;
  begin
    if Length(List.Values[Name]) > 0 then
      Result := List.Values[Name]
    else
      Result := Name;
  end;

  procedure TranslatePopupMenu(APopupMenu: TPopupMenu);
  var
    i: Integer;
  begin
    with APopupMenu do
    begin
      for i := 0 to Items.Count-1 do
        Items[i].Caption := GetTranslate(Items[i].Caption);
    end;
  end;

begin
  if (ALangFile = '') or not FileExists(ALangFile) then
    Exit;

  Ini := TIniFile.Create(ALangFile);
  List := TStringList.Create();
  ReadSection('Form');
  with ADesignerForm do
  begin
    if Length(List.Values['Caption']) > 0 then
      Caption := List.Values['Caption'];
    btOk.Caption     := GetTranslate(btOk.Caption    );
    btCancel.Caption := GetTranslate(btCancel.Caption);
    btApply.Caption  := GetTranslate(btApply.Caption );
    _Modified        := GetTranslate(_Modified       );
    _Name            := GetTranslate(_Name           );
    _Extensions      := GetTranslate(_Extensions     );
    _Version         := GetTranslate(_Version        );
    _Date            := GetTranslate(_Date           );
    _Author          := GetTranslate(_Author         );
    _Mail            := GetTranslate(_Mail           );
    _Web             := GetTranslate(_Web            );
    _Copyright       := GetTranslate(_Copyright      );
    _Company         := GetTranslate(_Company        );
    _Remark          := GetTranslate(_Remark         );
    _DeleteNode      := GetTranslate(_DeleteNode     );
    _SaveChanges     := GetTranslate(_SaveChanges    );
    _EnterName       := GetTranslate(_EnterName      );
    _DeleteScheme    := GetTranslate(_DeleteScheme   );
    _Confirm         := GetTranslate(_Confirm        );

    ReadSection('popPanels');         TranslatePopupMenu(popPanels);
    ReadSection('popStandard');       TranslatePopupMenu(popStandard);
    ReadSection('popTagMenus');       TranslatePopupMenu(popOpenTagMenu);
    ReadSection('popTagMenus');       TranslatePopupMenu(popCloseTagMenu);
    ReadSection('popRootMenu');       TranslatePopupMenu(popRootMenu);
    ReadSection('popRangeMenu');      TranslatePopupMenu(popRangeMenu);
    ReadSection('popKeywordsMenu');   TranslatePopupMenu(popKeywordsMenu);
    ReadSection('popSetMenu');        TranslatePopupMenu(popSetMenu);
    ReadSection('popSampleMemoMenu'); TranslatePopupMenu(popSampleMemoMenu);
    ReadSection('popColorStd');       TranslatePopupMenu(ColorBoxDataModule.popColorStd);

    ReadSection('pLeft');
    pLeftCapt.Caption := GetTranslate(pLeftCapt.Caption);
    lbRootMenu.Hint   := GetTranslate(lbRootMenu.Hint  );

    ReadSection('pMiddle');
    pMiddleCapt.Caption := GetTranslate(pMiddleCapt.Caption);
    lbPropBack.Hint     := GetTranslate(lbPropBack.Hint    );
    lbRuleMenu.Hint     := GetTranslate(lbRuleMenu.Hint    );

    ReadSection('tabRoot');
    chCaseRoot.Caption        := GetTranslate(chCaseRoot.Caption       );
    chEnabledRoot.Caption     := GetTranslate(chEnabledRoot.Caption    );
    lbDelimitersRoot.Caption  := GetTranslate(lbDelimitersRoot.Caption );
    btAddRangeRoot.Caption    := GetTranslate(btAddRangeRoot.Caption   );
    btAddKeywordsRoot.Caption := GetTranslate(btAddKeywordsRoot.Caption);
    btAddSetRoot.Caption      := GetTranslate(btAddSetRoot.Caption     );

    ReadSection('tabRange');
    chCaseRange.Caption       := GetTranslate(chCaseRange.Caption      );
    chEnabledRange.Caption    := GetTranslate(chEnabledRange.Caption   );
    lbRangeFrom.Caption       := GetTranslate(lbRangeFrom.Caption      );
    lbRangeTo.Caption         := GetTranslate(lbRangeTo.Caption        );
    chCloseOnWord.Caption     := GetTranslate(chCloseOnWord.Caption    );
    chCloseOnEol.Caption      := GetTranslate(chCloseOnEol.Caption     ); 
    chCloseParent.Caption     := GetTranslate(chCloseParent.Caption    ); 
    lbDelimitersRange.Caption := GetTranslate(lbDelimitersRange.Caption); 
    btAddRange.Caption        := GetTranslate(btAddRange.Caption       ); 
    btAddKeywords.Caption     := GetTranslate(btAddKeywords.Caption    ); 
    btAddSet.Caption          := GetTranslate(btAddSet.Caption         ); 

    ReadSection('tabKeywords');
    chEnabledKeyList.Caption :=  GetTranslate(chEnabledKeyList.Caption);
    btSort.Hint              :=  GetTranslate(btSort.Hint             ); 
    btLowerCase.Hint         :=  GetTranslate(btLowerCase.Hint        ); 
    btSpacesToEol.Hint       :=  GetTranslate(btSpacesToEol.Hint      ); 
    _Lines                   :=  GetTranslate(_Lines                  ); 

    ReadSection('tabSet');
    chEnabledSet.Caption := GetTranslate(chEnabledSet.Caption);
    lbSymbSet.Caption    := GetTranslate(lbSymbSet.Caption   );

    ReadSection('tabSeveralRules');
    Label1.Caption := GetTranslate(Label1.Caption);

    ReadSection('pRight');
    pRightCapt.Caption   := GetTranslate(pRightCapt.Caption  );
    chForeground.Caption := GetTranslate(chForeground.Caption);
    chBackground.Caption := GetTranslate(chBackground.Caption);
    chBold.Caption       := GetTranslate(chBold.Caption      );
    chItalic.Caption     := GetTranslate(chItalic.Caption    );
    chUnderline.Caption  := GetTranslate(chUnderline.Caption );
    chStrikeOut.Caption  := GetTranslate(chStrikeOut.Caption );

    {lbScheme.Caption    := GetTranslate(lbScheme.Caption   );
    btNewScheme.Caption  := GetTranslate(btNewScheme.Caption);
    btDelScheme.Caption  := GetTranslate(btDelScheme.Caption);}

    ReadSection('pBottom');
    pBottomCapt.Caption := GetTranslate(pBottomCapt.Caption);
    lbSampMin.Hint      := GetTranslate(lbSampMin.Hint     );
    lbSampMax.Hint      := GetTranslate(lbSampMax.Hint     );
  end;
  List.Free();
  Ini.Free();
end;

end.
