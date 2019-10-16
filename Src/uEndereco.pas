unit uEndereco;

interface

uses
  SysUtils, StrUtils, IdHTTP, Jsons, XMLIntf;

type
  TEndereco = class
  private
    FCidade: string;
    FUf: string;
    FCep: string;
    FBairro: string;
    FLogradouro: string;
    FPais: string;
    FLocalizado: boolean;
  public
    constructor Create(PCep: string);

    procedure BuscarCep(PCep: String);

    function NodeXml(root: IXMLNode) : IXMLNode;

    property Localizado: boolean read FLocalizado write FLocalizado;
    property Cep: string read FCep write FCep;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Bairro: string read FBairro write FBairro;
    property Cidade: string read FCidade write FCidade;
    property Uf: string read FUf write FUf;
    property Pais: string read FPais write FPais;
  end;

implementation

{ TEndereco }

procedure TEndereco.BuscarCep(PCep: String);
var
  url, retorno: string;
  ihttp: TIdHttp;
  json: TJson;
begin
  url := 'http://viacep.com.br/ws/'+ PCep + '/json';
  ihttp := TIdHTTP.Create(nil);
  retorno := UTF8Decode(ihttp.Get(url));

  Localizado := not AnsiContainsStr(retorno, 'erro');
  if (Localizado) then
  begin
    json := TJson.Create;
    json.Parse(retorno);

    Cep := PCep;
    Logradouro := json['logradouro'].AsString;
    Bairro := json['bairro'].AsString;
    Cidade := json['localidade'].AsString;
    Uf := json['uf'].AsString;
    Pais := 'Brasil';
  end;
end;

constructor TEndereco.Create(PCep: string);
begin
  BuscarCep(PCep);
end;

function TEndereco.NodeXml(root: IXMLNode): IXMLNode;
var
  iNode: IXMLNode;
begin
  with root do
  begin
    iNode := AddChild('Cep');
    iNode.Text := Cep;

    iNode := AddChild('Logradouro');
    iNode.Text := Logradouro;

    iNode := AddChild('Bairro');
    iNode.Text := Bairro;

    iNode := AddChild('Cidade');
    iNode.Text := Cidade;

    iNode := AddChild('Uf');
    iNode.Text := Uf;

    iNode := AddChild('Pais');
    iNode.Text := Pais;
  end;

  Result := iNode;
end;

end.
