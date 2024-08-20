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
  Controllers.Produto in 'src\Controllers\Controllers.Produto.pas',
  Services.Cliente in 'src\Services\Services.Cliente.pas' {ServiceCliente: TDataModule},
  Controllers.Cliente in 'src\Controllers\Controllers.Cliente.pas';

procedure OnListen;
begin
  Writeln(Format('Servidor rodando na porta %d', [THorse.Port]));
end;

begin
  THorse.Use(Jhonson())
        .Use(HandleException);

  Controllers.Produto.Registry;
  Controllers.Cliente.Registry;

  THorse.Listen(9000, OnListen);

end.end.
