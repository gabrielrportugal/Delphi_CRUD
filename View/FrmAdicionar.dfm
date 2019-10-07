object FormularioAdicionar: TFormularioAdicionar
  Left = 0
  Top = 0
  Caption = 'Adicionar'
  ClientHeight = 230
  ClientWidth = 318
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PainelCampos: TPanel
    Left = 0
    Top = 0
    Width = 318
    Height = 184
    Align = alClient
    TabOrder = 0
    object lblNome: TLabel
      Left = 24
      Top = 59
      Width = 42
      Height = 16
      Caption = 'Nome:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object lblCPF: TLabel
      Left = 32
      Top = 109
      Width = 31
      Height = 16
      Caption = 'CPF:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object edtNome: TEdit
      Left = 80
      Top = 56
      Width = 193
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TextHint = 'Ex : Gabriel'
    end
    object edtCPF: TEdit
      Left = 80
      Top = 106
      Width = 193
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TextHint = 'Ex : 17621076780'
    end
  end
  object PainelAcoes: TPanel
    Left = 0
    Top = 184
    Width = 318
    Height = 46
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      318
      46)
    object btnAdicionar: TButton
      Left = 224
      Top = 6
      Width = 80
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'Adicionar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnAdicionarClick
    end
  end
end
