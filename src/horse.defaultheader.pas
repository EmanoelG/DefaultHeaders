unit horse.defaultheader;
{$IF DEFINED(FPC)}
{$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses
{$IF DEFINED(FPC)}
  SysUtils, Classes, HTTPDefs, fpjson, jsonparser,
{$ELSE}
  System.Classes, System.JSON, Web.HTTPApp,
{$ENDIF}
  Horse, Horse.Commons;

type
  TDefaultHeader = record
    name_version: string;
    version_server: string;
    Headers: TJSONArray;
  end;

 function HorseDefaultHeader( AConfig: TDefaultHeader): THorseCallback; overload;
 procedure Middleware(Req: THorseRequest; Res: THorseResponse; Next: {$IF DEFINED(FPC)}TNextProc{$ELSE}TProc{$ENDIF});

 var
   ConfigHeaderDefault: TDefaultHeader;
implementation

uses
  System.SysUtils, REST.Json;

function HorseDefaultHeader(AConfig: TDefaultHeader): THorseCallback;overload;
begin
   ConfigHeaderDefault := AConfig;
   Result := Middleware;
end;

procedure Middleware(Req: THorseRequest; Res: THorseResponse; Next: {$IF DEFINED(FPC)}TNextProc{$ELSE}TProc{$ENDIF});
var
  i:integer;
  data: TJSONArray;
  dataValue: TJSONValue;
  valor, chave, aux: String;
begin

  try
    Next;
  finally
    if Trim(ConfigHeaderDefault.name_version)='' then
      ConfigHeaderDefault.name_version:= 'X-version';
      Res.AddHeader(ConfigHeaderDefault.name_version,ConfigHeaderDefault.version_server );
      if (ConfigHeaderDefault.HeaderS<> nil) and ( ConfigHeaderDefault.HeaderS.Count>0) then
        for i := 0 to ConfigHeaderDefault.HeaderS.Count-1 do
        begin
          aux := ConfigHeaderDefault.HeaderS.Items[i].ToJSON.Replace('"','').Replace('{','').Replace('}','');
          aux.Split([':']);
          chave:= aux.Split([':'])[0];
          valor:= aux.Split([':'])[1];
          Res.AddHeader(chave, valor);
        end;

  end;
end;

end.

