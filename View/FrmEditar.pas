unit FrmEditar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  ClienteController, ClienteModel, CPFException;

type
  TForm3 = class(TForm)
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
  Form3: TForm3;

implementation

uses
  System.UITypes;

{$R *.dfm}

procedure TForm3.AtualizarClienteEdit;
begin
  FCliente.Nome := edtNome.Text;
  FCliente.CPF := edtCPF.Text;
end;

procedure TForm3.DeletarClick(Sender: TObject);
begin
  if (MessageDlg('Deseja remover ? ', mtConfirmation, [mbOK, mbCancel], 0)
    = mrOK) then
    if FClienteControl.ClienteDAO.Remover(Cliente) then
      ModalResult := mrOK;
end;

procedure TForm3.EditarClick(Sender: TObject);
begin
  with FClienteControl do
    try
      AtualizarClienteEdit;
      ValidarCPF(edtCPF.Text);
      ClienteDAO.CPFDuplicado(FCliente);
        if (MessageDlg('Cliente editado', mtConfirmation, [mbOK], 0) = mrOK)
        then
        begin
          ClienteDAO.Editar(FCliente);
          ModalResult := mrOK;
        end;
    except
      on E: ECpfInvalido do
        raise;
      on E: ECpfDuplicado do
        raise;
      on E: ECpfNaoAlterado do
        raise;
      on E: Exception do
        raise Exception.Create(E.Message);
    end;

end;

procedure TForm3.FormShow(Sender: TObject);
begin
  edtNome.Text := FCliente.Nome;
  edtCPF.Text := FCliente.CPF;
end;

end.
