unit Unit1;

interface

uses
  Horse, System.Generics.Collections, System.DateUtils, System.JSON;

procedure registry(identit: Integer);

procedure consulta_dataHr(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses
  System.SysUtils, Horse.Commons, System.Classes, Vcl.ExtCtrls, Data.SqlTimSt;

type
  TDateHora = class
  private
    fdataHora: string;
  public
    property dataHora: string read fdataHora write fdataHora;

  end;

  TAPIError = class
  private
    Ferror: string;

  public
    property error: string read Ferror write Ferror;
  end;

  TTooMany = class
  private
    Ferror: string;

  public
    property mensagem: string read Ferror write Ferror;
  end;

var
  LConfServer: TJSONArray;


procedure registry(identit: Integer);
begin

  THorse.get('/mcdatahora', consulta_dataHr);
end; //, THorseRateLimit.New(Config)

procedure consulta_dataHr(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  resposta: string;
begin

  resposta := '|' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + '|';
  Res.Send(TJSONArray.Create(TJSONObject.Create(TJSONPair.Create('hs', resposta))));

end;

end.

