# DefaultHeaders
Middleware para o frameWork Horse - DefaultHeaders é possível definir os cabeçalho padrão para no inicio do projeto, para qualquer resposta de requisição,     Exemplo:


    
    program Project1;

    {$APPTYPE CONSOLE}

    {$R *.res}

    uses
      System.SysUtils,
      System.JSON,
      Horse,
      Horse.defaultheader;

    var
      defaultHead: TDefaultHeader;
    begin
    
      // Para adicionar mais de um reader, basta passar um ArrayJson para a propriedade Headers.
      defaultHead.Headers := TJSONArray.Create(TJSONObject.Create(TJSONPair.Create('X-GitHub', 'github.com/EmanoelG')));

      defaultHead.name_version := 'appversion';
      defaultHead.version_server := 'AppVersion(V1.0.0)- Release';
      THorse.Use(HorseDefaultHeader(defaultHead));

      THorse.Get('/ping',
        procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
        begin
          Res.Send('pong');
        end);

      THorse.Listen(9000);
    end.
