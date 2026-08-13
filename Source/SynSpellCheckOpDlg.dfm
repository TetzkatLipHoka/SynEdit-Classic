object SpellCheckOpForm: TSpellCheckOpForm
  Left = 351
  Top = 238
  BorderStyle = bsDialog
  Caption = #25340#20889#26816#26597#36873#39033
  ClientHeight = 378
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 48
    Height = 13
    Caption = #35789#20856#36335#24452
  end
  object Label2: TLabel
    Left = 16
    Top = 72
    Width = 72
    Height = 13
    Caption = #29992#25143#35789#20856#36335#24452
  end
  object Label3: TLabel
    Left = 16
    Top = 316
    Width = 48
    Height = 13
    Caption = #36873#25321#35789#20856
  end
  object ComboBox1: TComboBox
    Left = 80
    Top = 312
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 16
    Top = 32
    Width = 297
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 16
    Top = 88
    Width = 297
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 321
    Top = 32
    Width = 64
    Height = 22
    Caption = #27983#35272'(&B)...'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 321
    Top = 88
    Width = 64
    Height = 22
    Caption = #27983#35272'(&B)...'
    TabOrder = 4
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 128
    Width = 369
    Height = 169
    Caption = #36873#39033
    TabOrder = 5
    object CheckBox1: TCheckBox
      Left = 24
      Top = 32
      Width = 121
      Height = 17
      Caption = #38190#20837#26102#33258#21160#26816#26597'(&A)'
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 24
      Top = 64
      Width = 113
      Height = 17
      Caption = #24573#30053#21333#20010#23383#31526'(&S)'
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 24
      Top = 96
      Width = 153
      Height = 17
      Caption = #24573#30053#21547#26377#25968#23383#30340#21333#35789'(&N)'
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 24
      Top = 128
      Width = 129
      Height = 17
      Caption = #26174#31034#24314#35758#21333#35789'(&U)'
      TabOrder = 3
    end
    object CheckBox5: TCheckBox
      Left = 184
      Top = 32
      Width = 169
      Height = 17
      Caption = #20445#25345#21333#35789#25110#39318#20010#23383#27597#22823#20889'(&M)'
      TabOrder = 4
    end
    object CheckBox6: TCheckBox
      Left = 184
      Top = 64
      Width = 153
      Height = 17
      Caption = #20174#20809#26631#22788#24320#22987#26816#26597'(&F)'
      TabOrder = 5
    end
  end
  object Button3: TButton
    Left = 312
    Top = 344
    Width = 75
    Height = 25
    Cancel = True
    Caption = #20851#38381
    ModalResult = 2
    TabOrder = 6
  end
  object Button4: TButton
    Left = 232
    Top = 344
    Width = 75
    Height = 25
    Caption = #30830#23450
    Default = True
    ModalResult = 1
    TabOrder = 7
  end
end
