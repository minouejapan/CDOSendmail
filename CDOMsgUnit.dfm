object CDOMessage: TCDOMessage
  Left = 0
  Top = 0
  Caption = 'CDOMessage'
  ClientHeight = 418
  ClientWidth = 463
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Yu Gothic UI'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object MainPanel: TPageControl
    Left = 0
    Top = 0
    Width = 463
    Height = 418
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #12513#12540#12523
      object Label7: TLabel
        Left = 8
        Top = 20
        Width = 24
        Height = 15
        Caption = #23451#20808
      end
      object Label8: TLabel
        Left = 8
        Top = 52
        Width = 24
        Height = 15
        Caption = #20214#21517
      end
      object Label9: TLabel
        Left = 8
        Top = 80
        Width = 24
        Height = 15
        Caption = #26412#25991
      end
      object Label10: TLabel
        Left = 8
        Top = 304
        Width = 58
        Height = 15
        Caption = #28155#20184#12501#12449#12452#12523
      end
      object ToAddress: TEdit
        Left = 48
        Top = 16
        Width = 393
        Height = 23
        TabOrder = 0
      end
      object Subject: TEdit
        Left = 48
        Top = 52
        Width = 393
        Height = 23
        TabOrder = 1
      end
      object Body: TMemo
        Left = 12
        Top = 96
        Width = 429
        Height = 205
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object Attachment: TEdit
        Left = 12
        Top = 322
        Width = 377
        Height = 23
        TabOrder = 3
      end
      object Button1: TButton
        Left = 388
        Top = 320
        Width = 53
        Height = 25
        Caption = #21442#29031'...'
        TabOrder = 4
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 366
        Top = 356
        Width = 75
        Height = 25
        Caption = #12513#12540#12523#36865#20449
        TabOrder = 5
        OnClick = Button2Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #36865#20449#35373#23450
      ImageIndex = 1
      object Label1: TLabel
        Left = 16
        Top = 20
        Width = 66
        Height = 15
        Caption = 'SMTP'#12469#12540#12496#12540
      end
      object Label2: TLabel
        Left = 342
        Top = 19
        Width = 26
        Height = 15
        Caption = #12509#12540#12488
      end
      object Label3: TLabel
        Left = 92
        Top = 85
        Width = 48
        Height = 15
        Caption = #35469#35388#26041#24335
      end
      object Label4: TLabel
        Left = 20
        Top = 128
        Width = 48
        Height = 15
        Caption = #12518#12540#12470#12540#21517
      end
      object Label5: TLabel
        Left = 20
        Top = 164
        Width = 44
        Height = 15
        Caption = #12497#12473#12527#12540#12489
      end
      object Label6: TLabel
        Left = 20
        Top = 208
        Width = 61
        Height = 15
        Caption = #12513#12540#12523#12450#12489#12524#12473
      end
      object SMTP: TEdit
        Left = 92
        Top = 16
        Width = 233
        Height = 23
        TabOrder = 0
        Text = 'smtp.'
      end
      object PortNo: TEdit
        Left = 374
        Top = 16
        Width = 63
        Height = 23
        TabOrder = 1
      end
      object UseSSL: TCheckBox
        Left = 92
        Top = 52
        Width = 97
        Height = 17
        Caption = 'SSL'#25509#32154#12377#12427
        TabOrder = 2
      end
      object Authenticate: TComboBox
        Left = 156
        Top = 81
        Width = 85
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 3
        Text = 'BASIC'#35469#35388
        Items.Strings = (
          'BASIC'#35469#35388
          'NTLM'#35469#35388)
      end
      object UserName: TEdit
        Left = 92
        Top = 124
        Width = 345
        Height = 23
        TabOrder = 4
      end
      object PassWord: TEdit
        Left = 92
        Top = 160
        Width = 345
        Height = 23
        PasswordChar = '*'
        TabOrder = 5
      end
      object FromAddress: TEdit
        Left = 92
        Top = 205
        Width = 345
        Height = 23
        TabOrder = 6
      end
    end
  end
  object OD: TOpenDialog
    Left = 16
    Top = 352
  end
end
