unit CPFException;

{ Exceções criadas para tratar erros na validação do CPF}

interface

uses
  SysUtils;

type
  ECpfInvalido = class(Exception)
    constructor Create(const AMessage: String = 'CPF Invalido');
  end;

  ECpfDuplicado = class(Exception)
    constructor Create(const AMessage: String = 'CPF Duplicado');
  end;

implementation

{ ECpfDuplicado }

constructor ECpfDuplicado.Create(const AMessage: String = 'CPF Duplicado');
begin
  Self.Message := AMessage;
end;

{ ECpfInvalido }

constructor ECpfInvalido.Create;
begin
  Self.Message := AMessage;
end;


end.
