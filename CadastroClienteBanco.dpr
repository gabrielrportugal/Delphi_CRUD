program CadastroClienteBanco;

uses
  Vcl.Forms,
  FrmPrincipal in 'FrmPrincipal.pas' {Form1},
  FrmAdicionar in 'View\FrmAdicionar.pas' {Form2},
  FrmEditar in 'View\FrmEditar.pas' {Form3},
  Vcl.Themes,
  Vcl.Styles,
  ClienteModel in 'Model\ClienteModel.pas',
  ClienteController in 'Controller\ClienteController.pas',
  ConexaoDAO in 'DAO\ConexaoDAO.pas',
  ClienteDAO in 'DAO\ClienteDAO.pas',
  CPFException in 'Exception\CPFException.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
