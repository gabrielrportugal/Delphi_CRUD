unit CPFException;

{ Exceções criadas para tratar erros na validação do CPF}

interface

uses
  SysUtils;

type
  ECpfInvalido = class(Exception)
    constructor Create(const AMessageErro: String = 'CPF Invalido');
  end;

  ECpfDuplicado = class(Exception)
    constructor Create(const AMessageErro: String = 'CPF Duplicado');
  end;

implementation

{ ECpfDuplicado }

constructor ECpfDuplicado.Create(const AMessageErro: String = 'CPF Duplicado');
begin
  Self.Message := AMessageErro;
end;

{ ECpfInvalido }

constructor ECpfInvalido.Create;
begin
  Self.Message := AMessageErro;
end;


end.
