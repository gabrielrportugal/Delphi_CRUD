unit ClienteDAO;

interface

{ Implementar fun��es do CRUD }

uses
  ConexaoDAO, ClienteModel, System.Generics.Collections;

type
  TClienteDAO = class(TConectDAO)
  private
    FListaCliente: TObjectList<TCliente>;
  public
    LSQL: String;
    constructor Create;
    destructor Destroy; override;
    function Remover(const ACliente: TCliente): Boolean;
    function Editar(const ACliente: TCliente): Boolean;
    function BuscarLista(ANome: String): TObjectList<TCliente>;
    function Inserir(const ACliente: TCliente): Boolean;
    function RetornarListaCompleta: TObjectList<TCliente>;
    function RetornarLista(ASQL: String): TObjectList<TCliente>;
    function CPFDuplicado(const ACliente: TCliente): Boolean;
    function VerificarCPFEditado(const ACliente: TCliente): Boolean;
  end;

implementation

uses
  System.SysUtils, CPFException;

{ TClienteDAO }

function TClienteDAO.BuscarLista(ANome: String): TObjectList<TCliente>;
begin
  LSQL := 'SELECT ID,NOME,CPF,DATA FROM CLIENTE WHERE NOME LIKE ' +
    QuotedStr('%' + ANome + '%') + 'OR  CPF LIKE ' +
    QuotedStr('%' + ANome + '%') + ';';

  ExibirDataSet(LSQL);

  Result := RetornarLista(LSQL);
end;

function TClienteDAO.CPFDuplicado(const ACliente: TCliente): Boolean;
begin
  LSQL := 'SELECT * FROM CLIENTE WHERE CPF = ' + QuotedStr(ACliente.CPF) + ';';

  ExibirDataSet(LSQL);

  if Query.RowsAffected > 0 then
  begin
    Result := false;
    raise ECpfDuplicado.Create('CPF Duplicado');
  end
  else
    Result := true;
end;

constructor TClienteDAO.Create;
begin
  inherited Create;
  FListaCliente := TObjectList<TCliente>.Create;
  RetornarListaCompleta;
end;

destructor TClienteDAO.Destroy;
begin
  inherited;
end;

// Fun��o de editar os dados no banco de dados
function TClienteDAO.Editar(const ACliente: TCliente): Boolean;
begin
  LSQL := 'UPDATE CLIENTE SET NOME = ' + QuotedStr(ACliente.Nome) + ',' +
    ' CPF = ' + QuotedStr(ACliente.CPF) + ' WHERE ID = ' +
    QuotedStr(IntToStr(ACliente.ID));

  Result := ExecutarComando(LSQL);
end;

// Fun��o de inserir dados no banco de dados
function TClienteDAO.Inserir(const ACliente: TCliente): Boolean;
begin
  LSQL := 'INSERT INTO CLIENTE(NOME,CPF,DATA) VALUES (' +
    QuotedStr(ACliente.Nome) + ',' + QuotedStr(ACliente.CPF) + ',' +
    'current_date);';

  Result := ExecutarComando(LSQL);
end;

// Fun��o de deletar dados do banco de dados
function TClienteDAO.Remover(const ACliente: TCliente): Boolean;
begin
  LSQL := ' DELETE FROM CLIENTE WHERE ID = ' +
    QuotedStr(IntToStr(ACliente.ID)) + ';';

  Result := ExecutarComando(LSQL);
end;

// Fun��o que atualiza lista.
function TClienteDAO.RetornarLista(ASQL: String): TObjectList<TCliente>;
var
  I: integer;
begin
  I := 0;

  ExibirDataSet(ASQL);

  FListaCliente.Clear;

  while not Query.Eof do
  begin
    FListaCliente.Add(TCliente.Create);
    FListaCliente[I].ID := Query.FieldByName('ID').Value;
    FListaCliente[I].Nome := Query.FieldByName('NOME').Value;
    FListaCliente[I].CPF := Query.FieldByName('CPF').Value;
    FListaCliente[I].Data := Query.FieldByName('DATA').Value;
    Query.Next;
    Inc(I);
  end;

  Result := FListaCliente;
end;

function TClienteDAO.RetornarListaCompleta: TObjectList<TCliente>;
begin
  LSQL := 'SELECT ID,NOME,CPF,DATA FROM CLIENTE ORDER BY ID';

  ExibirDataSet(LSQL);

  FListaCliente.Clear;

  Result := RetornarLista(LSQL);
end;

function TClienteDAO.VerificarCPFEditado(const ACliente: TCliente): Boolean;
begin
  LSQL := 'SELECT * FROM CLIENTE WHERE NOME =' + QuotedStr(ACliente.Nome) + 'AND CPF = '
    + QuotedStr(ACliente.CPF) + ';';

  ExibirDataSet(LSQL);

  if Query.RowsAffected > 0 then
  begin
    Result := false;
    raise Exception.Create('Nenhuma altera��o realizada');
  end
  else
    Result := true;
end;

end.