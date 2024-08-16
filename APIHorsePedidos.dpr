 {
   ____   __  _
 / ___| /_/_| | __ _  __ _  ___
| |  _ / _` | |/ _` |/ _` |/ _ \
| |_| | (_| | | (_| | (_| | (_) |
 \____|\__,_|_|\__,_|\__, |\___/
                     |___/
 }
program APIHorsePedidos;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  System.SysUtils,
  Providers.Connection in 'src\providers\Providers.Connection.pas' {ProvidersConnection: TDataModule},
  Providers.Cadastro in 'src\providers\Providers.Cadastro.pas' {ProvidersCadastro: TDataModule},
  Services.Produto in 'src\Services\Services.Produto.pas' {ServiceProduto: TDataModule},
  Controllers.Produto in 'src\Controllers\Controllers.Produto.pas';

procedure OnListen;
begin
  Writeln(Format('Servidor rodando na porta %d', [THorse.Port]));
end;

begin
  THorse.Use(Jhonson())
        .Use(HandleException);

  Controllers.Produto.Registry;
  THorse.Listen(9000, OnListen);

end.end.
