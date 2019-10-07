unit ClienteController;

{ Controlador que possui uma property do ClienteDAO para a View poder utilizar }

interface

uses
  System.Generics.Collections, System.SysUtils, Winapi.Messages,
  Winapi.Windows, ClienteDAO, System.Classes;

type
  TClienteControl = class
  private
    FClienteDAO: TClienteDAO;
  public
    property ClienteDAO: TClienteDAO read FClienteDAO write FClienteDAO;
    function ValidarCPF(ACPF: String): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TClienteControl }

uses
  CPFException;

constructor TClienteControl.Create;
begin
  FClienteDAO := TClienteDAO.Create;
end;

destructor TClienteControl.Destroy;
begin
  FClienteDAO.Free;
  inherited;
end;

// Fun��o que validar� o CPF
function TClienteControl.ValidarCPF(ACPF: String): Boolean;
var
  dig10, dig11: string;
  S, I, R, peso: integer;
begin
  if ((ACPF = '00000000000') or (ACPF = '11111111111') or (ACPF = '22222222222')
    or (ACPF = '33333333333') or (ACPF = '44444444444') or
    (ACPF = '55555555555') or (ACPF = '66666666666') or (ACPF = '77777777777')
    or (ACPF = '88888888888') or (ACPF = '99999999999') or (length(ACPF) <> 11))
  then
  begin
    Result := false;
    raise ECpfInvalido.Create;
  end;
  try
    S := 0;
    peso := 10;
    for I := 1 to 9 do
    begin
      S := S + (StrToInt(ACPF[I]) * peso);
      peso := peso - 1;
    end;
    R := 11 - (S mod 11);
    if ((R = 10) or (R = 11)) then
      dig10 := '0'
    else
      str(R: 1, dig10);
    S := 0;
    peso := 11;
    for I := 1 to 10 do
    begin
      S := S + (StrToInt(ACPF[I]) * peso);
      peso := peso - 1;
    end;
    R := 11 - (S mod 11);
    if ((R = 10) or (R = 11)) then
      dig11 := '0'
    else
      str(R: 1, dig11);
    if ((dig10 = ACPF[10]) and (dig11 = ACPF[11])) then
      Result := true
    else
    begin
      Result := false;
      raise ECpfInvalido.Create;
    end;
  except
    Result := false;
    raise ECpfInvalido.Create;
  end;
end;

end.
