unit FrmAdicionar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  ClienteController, ClienteModel;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    edtNome: TEdit;
    edtCPF: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Adicionar: TButton;
    procedure AdicionarClick(Sender: TObject);
  private
    FClienteControl: TClienteControl;
    FCliente: TCliente;
    procedure AddCliente(const ANome, ACPF: String);
    { Private declarations }
  public
    { Public declarations }
    property ClienteControl: TClienteControl read FClienteControl
      write FClienteControl;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses
  UITypes, CPFException;

procedure TForm2.AddCliente(const ANome, ACPF: String);
begin
  FCliente.Nome := ANome;
  FCliente.CPF := ACPF;
end;

procedure TForm2.AdicionarClick(Sender: TObject);
begin
  FCliente := TCliente.Create;
  try
    AddCliente(edtNome.Text, edtCPF.Text);
    try
      if FClienteControl.ValidarCPF(FCliente.CPF) then
        if FClienteControl.ClienteDAO.CPFDuplicado(FCliente) then
          if FClienteControl.ClienteDAO.Inserir(FCliente) then
            if (MessageDlg('Cliente cadastrado', mtConfirmation, [mbOK], 0)
              = mrOK) then
              ModalResult := mrOK;
    except
      on E: ECpfDuplicado do
        raise;
      on E: ECpfInvalido do
        raise;
    end;
  finally
     FCliente.Free;
  end;
end;

end.