unit Controllers.Cliente;

interface

procedure Registry;

implementation

uses Horse, Services.Cliente, System.JSON, DataSet.Serialize, data.DB, SysUtils;

procedure ListarClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  LService : TServiceCliente;
  LRetorno : TJSONObject;
begin
  LService := TServiceCliente.Create;
  try
    LRetorno := TJSONObject.Create;
    LRetorno.AddPair('data', LService.ListAll(Req.Query.Dictionary).ToJSONArray());
    LRetorno.AddPair('records', TJSONNumber.Create(LService.GetRecordCount));
    Res.Send(LRetorno);
  finally
    LService.Free;
  end;
end;

procedure ObterCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceCliente;
  LIdCliente: string;
begin
  LService := TServiceCliente.Create;
  try
   LIdCliente := Req.Params['id'];
   if LService.GetById(LIdCliente).IsEmpty then
     raise EHorseException.New.Status(THTTPStatus.NotFound).Error('Cliente não encontrado');
   Res.Send(LService.qryCadastro.ToJSONObject);
  finally
   LService.Free;
  end;
end;

procedure CadastrarCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService : TServiceCliente;
  LCliente: TJSONObject;
begin
  LService := TServiceCliente.Create;
  try
    LCliente := Req.Body<TJSONObject>;
    if LService.Append(LCliente) then
      Res.Send(LService.qryCadastro.ToJSONObject()).Status(THTTPStatus.Created); //Retorna o objeto cadastrado e status code
  finally
  LService.Free;
  end;
end;

procedure AlterarCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceCliente;
  LIdCliente: string;
  LCliente: TJSONObject;
begin
  LService := TServiceCliente.Create;
  try
    LIdCliente := Req.Params['id'];
    if LService.GetById(LIdCliente).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('Cliente não encontrado');
    LCliente := Req.Body<TJSONObject>;
    if LService.Update(LCliente) then
    Res.Status(THTTPStatus.NoContent);
  finally
  LService.Free;
  end;
end;

procedure DeletarCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceCliente;
  LIdCliente : string;
begin
  LService := TServiceCliente.Create;
  try
    LIdCliente := Req.Params['id'];
    if LService.GetById(LIdCliente).IsEmpty then
      raise EHorseException.New.Status(THTTPStatus.NotFound).Error('Cliente não encontrado');
     if LService.Delete then
     begin
     Res.Status(THTTPStatus.NoContent);
     end;
  finally
  LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/clientes', ListarClientes);
  THorse.Get('/clientes/:id', ObterCliente);
  THorse.Post('/clientes', CadastrarCliente);
  THorse.Put('/clientes/:id', AlterarCliente);
  THorse.Delete('clientes/:id', DeletarCliente);
end;

end.
