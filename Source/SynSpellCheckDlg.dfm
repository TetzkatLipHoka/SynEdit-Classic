object CheckWordDlg: TCheckWordDlg
  Left = 289
  Top = 177
  BorderStyle = bsNone
  Caption = #25340#20889#26816#26597
  ClientHeight = 246
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 17
    Top = 57
    Width = 38
    Height = 13
    Caption = #24314#35758'(&T)'
    FocusControl = ListBox1
  end
  object Label4: TLabel
    Left = 17
    Top = 14
    Width = 30
    Height = 13
    Caption = #35789'(&W)'
    FocusControl = Edit1
  end
  object Label3: TLabel
    Left = 17
    Top = 161
    Width = 38
    Height = 13
    Caption = #35789#20856'(&Z)'
  end
  object Label1: TLabel
    Left = 162
    Top = 14
    Width = 48
    Height = 13
    Caption = #26356#27491#20026'(&I)'
    FocusControl = Edit3
  end
  object Button2: TButton
    Left = 295
    Top = 135
    Width = 108
    Height = 23
    Caption = #20840#37096#24573#30053'(&K)'
    ModalResult = 9
    TabOrder = 0
  end
  object ListBox1: TListBox
    Left = 17
    Top = 73
    Width = 266
    Height = 86
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox1Click
  end
  object Edit2: TEdit
    Left = 17
    Top = 178
    Width = 266
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 17
    Top = 30
    Width = 136
    Height = 21
    TabOrder = 3
  end
  object Button8: TButton
    Left = 295
    Top = 82
    Width = 108
    Height = 23
    Cancel = True
    Caption = #21462#28040'(&N)'
    ModalResult = 2
    TabOrder = 4
  end
  object Button7: TButton
    Left = 295
    Top = 161
    Width = 108
    Height = 23
    Caption = #25764#28040'(&D)'
    ModalResult = 3
    TabOrder = 5
  end
  object Button6: TButton
    Left = 295
    Top = 108
    Width = 108
    Height = 23
    Caption = #26356#27491#20840#37096'(&H)'
    ModalResult = 10
    TabOrder = 6
  end
  object Button5: TButton
    Left = 132
    Top = 205
    Width = 109
    Height = 23
    Caption = #33258#21160#26356#27491'(&U)'
    ModalResult = 4
    TabOrder = 7
  end
  object Button4: TButton
    Left = 295
    Top = 29
    Width = 108
    Height = 23
    Caption = #26356#27491'(&C)'
    Default = True
    ModalResult = 1
    TabOrder = 8
  end
  object Button3: TButton
    Left = 17
    Top = 205
    Width = 109
    Height = 23
    Caption = #28155#21152#21040#35789#20856'(&D)...'
    ModalResult = 6
    TabOrder = 9
  end
  object Button1: TButton
    Left = 295
    Top = 55
    Width = 108
    Height = 23
    Caption = #24573#30053#19968#27425'(&S)'
    ModalResult = 5
    TabOrder = 10
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 420
    Height = 1
    Align = alTop
    BevelOuter = bvNone
    Color = 5723991
    TabOrder = 11
  end
  object Panel2: TPanel
    Left = 0
    Top = 245
    Width = 420
    Height = 1
    Align = alBottom
    BevelOuter = bvNone
    Color = 5723991
    TabOrder = 12
  end
  object Panel3: TPanel
    Left = 0
    Top = 1
    Width = 1
    Height = 244
    Align = alLeft
    BevelOuter = bvNone
    Color = 5723991
    TabOrder = 13
  end
  object Panel4: TPanel
    Left = 419
    Top = 1
    Width = 1
    Height = 244
    Align = alRight
    BevelOuter = bvNone
    Color = 5723991
    TabOrder = 14
  end
  object Edit3: TEdit
    Left = 161
    Top = 30
    Width = 120
    Height = 21
    TabOrder = 15
  end
end
