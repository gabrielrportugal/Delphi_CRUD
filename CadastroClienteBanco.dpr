program CadastroClienteBanco;

uses
  Vcl.Forms,
  FrmPrincipal in 'View\FrmPrincipal.pas' {FormularioPrincipal},
  FrmAdicionar in 'View\FrmAdicionar.pas' {FormularioAdicionar},
  FrmEditar in 'View\FrmEditar.pas' {FormularioEditar},
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
  Application.CreateForm(TFormularioPrincipal, FormularioPrincipal);
  Application.Run;

end.
