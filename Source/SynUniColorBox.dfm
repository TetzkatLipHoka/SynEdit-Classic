object FrameColor: TFrameColor
  Left = 0
  Top = 0
  Width = 115
  Height = 23
  TabOrder = 0
  TabStop = True
  OnContextPopup = FrameContextPopup
  object pColorBox: TPanel
    Left = 0
    Top = 0
    Width = 41
    Height = 23
    TabOrder = 0
    object pColor: TPanel
      Left = 2
      Top = 2
      Width = 28
      Height = 18
      BevelInner = bvLowered
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      OnClick = pColorClick
      OnMouseUp = pColorMouseUp
    end
    object pColorArrow: TPanel
      Left = 31
      Top = 2
      Width = 8
      Height = 18
      BevelOuter = bvNone
      Caption = 'u'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Marlett'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnMouseUp = pColorArrowMouseUp
    end
  end
end
