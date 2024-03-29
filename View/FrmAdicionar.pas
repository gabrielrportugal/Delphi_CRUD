unit FrmAdicionar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  ClienteController, ClienteModel;

type
  TFormularioAdicionar = class(TForm)
    PainelCampos: TPanel;
    PainelAcoes: TPanel;
    edtNome: TEdit;
    edtCPF: TEdit;
    lblNome: TLabel;
    lblCPF: TLabel;
    btnAdicionar: TButton;
    procedure btnAdicionarClick(Sender: TObject);
    procedure EventoController(Sender: TObject);
  private
    FClienteControl: TClienteControl;
    FCliente: TCliente;
    { Private declarations }
  public
    { Public declarations }
    property ClienteControl: TClienteControl read FClienteControl
      write FClienteControl;
  end;

var
  FormularioAdicionar: TFormularioAdicionar;

implementation

{$R *.dfm}

uses
  UITypes, CPFException;

{ M�todo do clique do bot�o adicionar que insere os dados no
  banco de dados atrav�s do controlador }
procedure TFormularioAdicionar.btnAdicionarClick(Sender: TObject);
begin
  FCliente := TCliente.Create;
  try
    FCliente.Nome := edtNome.Text;
    FCliente.CPF := edtCPF.Text;
    try
      FClienteControl.ValidarCPF(FCliente.CPF);
      FClienteControl.ClienteDAO.CPFDuplicado(FCliente);
      FClienteControl.ClienteDAO.Inserir(FCliente);
      if (MessageDlg('Cliente cadastrado', mtConfirmation, [mbOK], 0) = mrOK)
      then
        ModalResult := mrOK;
    except
      on E: ECpfDuplicado do
        raise;
      on E: ECpfInvalido do
        raise;
      on E: Exception do
        raise Exception.Create('Ocorreu um erro ' + E.Message);
    end;
  finally
    FCliente.Free;
  end;
end;

procedure TFormularioAdicionar.EventoController(Sender: TObject);
begin
  ShowMessage('Nome registrado');
end;

end.
