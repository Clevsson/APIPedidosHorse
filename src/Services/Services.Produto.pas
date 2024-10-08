unit Services.Produto;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Generics.Collections;

type
  TServiceProduto = class(TProvidersCadastro)
    qryPesquisaid: TLargeintField;
    qryPesquisanome: TWideStringField;
    qryPesquisavalor: TFMTBCDField;
    qryPesquisastatus: TSmallintField;
    qryPesquisaestoque: TFMTBCDField;
    qryCadastroid: TLargeintField;
    qryCadastronome: TWideStringField;
    qryCadastrovalor: TFMTBCDField;
    qryCadastrostatus: TSmallintField;
    qryCadastroestoque: TFMTBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
    function ListAll(const AParams: TDictionary<string,string>): TFDQuery; override;
  end;

var
  ServiceProduto: TServiceProduto;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceProduto }

function TServiceProduto.ListAll(const AParams: TDictionary<string, string>): TFDQuery;
begin
  if AParams.ContainsKey('id') then
  begin
    qryPesquisa.SQL.Add('and id = :id');
    qryPesquisa.ParamByName('id').AsLargeInt := AParams.Items['id'].ToInt64;
    qryRecordCount.SQL.Add('and id = :id');
    qryRecordCount.ParamByName('id').AsLargeInt := AParams.Items['id'].ToInt64;
  end;
  if AParams.ContainsKey('nome') then
  begin
    qryPesquisa.SQL.Add('and lower(nome) like :nome');
    qryPesquisa.ParamByName('nome').AsString := '%' + AParams.Items['nome'].ToLower + '%';
    qryRecordCount.SQL.Add('and lower(nome) like :nome');
    qryRecordCount.ParamByName('nome').AsString := '%' + AParams.Items['nome'].ToLower + '%';
  end;
  if AParams.ContainsKey('status') then
  begin
      qryPesquisa.SQL.Add('and status = :status');
      qryPesquisa.ParamByName('status').AsSmallInt := AParams.Items['status'].ToInteger;
      qryRecordCount.SQL.Add('and status = :status');
      qryRecordCount.ParamByName('status').AsSmallInt := AParams.Items['status'].ToInteger;
  end;
  qryPesquisa.SQL.Add('order by id');
  Result := inherited ListAll(AParams);
end;

end.
