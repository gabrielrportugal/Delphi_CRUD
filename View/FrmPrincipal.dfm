object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Cadastro'
  ClientHeight = 333
  ClientWidth = 565
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 565
    Height = 57
    Align = alTop
    TabOrder = 0
    object Atualizar: TButton
      Left = 480
      Top = 16
      Width = 75
      Height = 27
      Cursor = crHandPoint
      Caption = 'Atualizar'
      TabOrder = 0
      OnClick = AtualizarClick
    end
    object edtBusca: TEdit
      Left = 24
      Top = 19
      Width = 225
      Height = 21
      TabOrder = 1
    end
    object Buscar: TButton
      Left = 264
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Buscar'
      TabOrder = 2
      OnClick = BuscarClick
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 57
    Width = 565
    Height = 232
    Align = alClient
    Columns = <>
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 289
    Width = 565
    Height = 44
    Align = alBottom
    TabOrder = 2
    object Adicionar: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Caption = 'Adicionar'
      TabOrder = 0
      OnClick = AdicionarClick
    end
  end
  object Editar: TButton
    Left = 89
    Top = 295
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = 'Editar'
    TabOrder = 3
    OnClick = EditarClick
  end
end
