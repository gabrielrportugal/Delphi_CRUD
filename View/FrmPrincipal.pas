unit FrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  FrmEditar, FrmAdicionar, ClienteController;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ListView1: TListView;
    Panel2: TPanel;
    Atualizar: TButton;
    Adicionar: TButton;
    Editar: TButton;
    edtBusca: TEdit;
    Buscar: TButton;
    procedure AdicionarClick(Sender: TObject);
    procedure EditarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AtualizarClick(Sender: TObject);
    procedure BuscarClick(Sender: TObject);
    procedure AtualizarBusca(AIndice: integer);

  private
    { Private declarations }
    FClienteControl: TClienteControl;
    procedure ConfigListView;
    procedure BuscarCliente;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AdicionarClick(Sender: TObject);
var
  LFormAdicionar: TForm2;
begin
  LFormAdicionar := TForm2.Create(nil);
  try
    LFormAdicionar.ClienteControl := FClienteControl;
    LFormAdicionar.ShowModal;
  finally
    if LFormAdicionar.ModalResult = mrOK then
      BuscarCliente;
    if Assigned(LFormAdicionar) then
      LFormAdicionar.Free;
  end;
end;

procedure TForm1.EditarClick(Sender: TObject);
var
  LFormEditar: TForm3;
begin
  if FClienteControl.ListaCliente.Count <= 0 then
    raise Exception.Create('Não existem clientes cadastrados');
  LFormEditar := TForm3.Create(nil);
  try
    LFormEditar.ClienteControl := FClienteControl;
    LFormEditar.Indice := ListView1.ItemIndex;
    LFormEditar.ShowModal;
  finally
    if LFormEditar.ModalResult = mrOK then
      BuscarCliente;
    if Assigned(LFormEditar) then
      LFormEditar.Free;
  end;
end;

procedure TForm1.AtualizarBusca(AIndice: integer);
var
  ListaItem: TListItem;
begin
  ListView1.Clear;
  begin
    ListaItem := ListView1.Items.Add;
    ListaItem.Caption := IntToStr(AIndice);
    ListaItem.SubItems.Add(FClienteControl.ListaCliente[AIndice].Nome);
    ListaItem.SubItems.Add(FClienteControl.ListaCliente[AIndice].CPF);
  end;
end;

procedure TForm1.AtualizarClick(Sender: TObject);
begin
  BuscarCliente;
end;

procedure TForm1.ConfigListView;
var
  LListaColuna: TListColumn;
begin
  with ListView1 do
  begin
    RowSelect := True;
    ViewStyle := vsReport;
    Align := alClient;
    LListaColuna := Columns.Add;
    LListaColuna.Caption := 'ID';
    LListaColuna.Width := 50;
    LListaColuna.Alignment := taLeftJustify;

    LListaColuna := Columns.Add;
    LListaColuna.Caption := 'Nome';
    LListaColuna.Width := 170;
    LListaColuna.Alignment := taLeftJustify;

    LListaColuna := Columns.Add;
    LListaColuna.Caption := 'CPF';
    LListaColuna.Width := 170;
    LListaColuna.Alignment := taLeftJustify;

    LListaColuna := Columns.Add;
    LListaColuna.Caption := 'DATA';
    LListaColuna.Width := 170;
    LListaColuna.Alignment := taLeftJustify;
  end;
end;

procedure TForm1.BuscarClick(Sender: TObject);
var
  temp_I: integer;
begin
  try
    temp_I := FClienteControl.BuscarLista(edtBusca.Text);
    AtualizarBusca(temp_I);
  except
    on E: Exception do
      raise Exception.Create('Erro ' + E.Message);
  end;
end;

procedure TForm1.BuscarCliente;
var
  I: integer;
  ListaItem: TListItem;
begin
  if FClienteControl.ListaCliente.Count > 0 then
  begin
    ListView1.Clear;
    for I := 0 to FClienteControl.ListaCliente.Count - 1 do
    begin
      ListaItem := ListView1.Items.Add;
      ListaItem.Caption := IntToStr(I);
      ListaItem.SubItems.Add(FClienteControl.ListaCliente[I].Nome);
      ListaItem.SubItems.Add(FClienteControl.ListaCliente[I].CPF);
      ListaItem.SubItems.Add(DateToStr(Now));
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FClienteControl := TClienteControl.Create;
  ConfigListView;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FClienteControl.Free;
end;

end.
