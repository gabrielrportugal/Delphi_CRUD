unit FrmEditar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  ClienteController, ClienteModel, CPFException;

type
  TFormularioEditar = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    edtCPF: TEdit;
    edtNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Editar: TButton;
    Deletar: TButton;
    procedure DeletarClick(Sender: TObject);
    procedure EditarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FClienteControl: TClienteControl;
    FCliente: TCliente;
    procedure AtualizarClienteEdit;
    { Private declarations }
  public
    property ClienteControl: TClienteControl read FClienteControl
      write FClienteControl;
    property Cliente: TCliente read FCliente write FCliente;
    { Public declarations }
  end;

var
  FormularioEditar: TFormularioEditar;

implementation

uses
  System.UITypes;

{$R *.dfm}

//Método que insere no objeto FCliente os dados digitados nos Edits
procedure TFormularioEditar.AtualizarClienteEdit;
begin
  FCliente.Nome := edtNome.Text;
  FCliente.CPF := edtCPF.Text;
end;

//Clique no botão deletar que exclui um item do banco de dados
procedure TFormularioEditar.DeletarClick(Sender: TObject);
begin
  if (MessageDlg('Deseja remover ? ', mtConfirmation, [mbOK, mbCancel], 0)
    = mrOK) then
    try
      FClienteControl.ClienteDAO.Remover(Cliente);
      ModalResult := mrOK;
    except
      on E: Exception do
        raise Exception.Create('Ocorreu um erro : ' + E.Message);
    end;
end;

//Clique no botão editar que modifica os dados no banco através do controlador
procedure TFormularioEditar.EditarClick(Sender: TObject);
begin
  with FClienteControl do
    try
      AtualizarClienteEdit;
      ValidarCPF(edtCPF.Text);
      ClienteDAO.CPFDuplicado(FCliente, true);
      if (MessageDlg('Cliente editado', mtConfirmation, [mbOK], 0) = mrOK) then
      begin
        ClienteDAO.Editar(FCliente);
        ModalResult := mrOK;
      end;
    except
      on E: ECpfInvalido do
        raise;
      on E: ECpfDuplicado do
        raise;
      on E: Exception do
        raise Exception.Create('Ocorreu um erro :' + E.Message);
    end;

end;

//Ao exibir o Form, os dados do objeto FCliente são carregados no Edit.
procedure TFormularioEditar.FormShow(Sender: TObject);
begin
  edtNome.Text := FCliente.Nome;
  edtCPF.Text := FCliente.CPF;
end;

end.
