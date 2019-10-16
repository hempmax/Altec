unit uCadastro;

interface

uses
  uEndereco, XMLIntf;

type
  TCadastro = class
  private
    FId: integer;
    FCpf: string;
    FIdentidade: string;
    FTelefone: string;
    FNumero: string;
    FComplemento: string;
    FEmail: string;
    FNome: string;
    FEndereco: TEndereco;
  public
    function NodeXml(root: IXMLNode) : IXMLNode;
    
    property Id: integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Email: string read FEmail write FEmail;
    property Telefone: string read FTelefone write FTelefone;
    property Identidade: string read FIdentidade write FIdentidade;
    property Cpf: string read FCpf write FCpf;
    property Endereco: TEndereco read FEndereco write FEndereco;
    property Numero: string read FNumero write FNumero;
    property Complemento: string read FComplemento write FComplemento;
  end;

implementation

{ TCadastro }

function TCadastro.NodeXml(root: IXMLNode): IXMLNode;
var
  iNode: IXMLNode;
begin
  with root do
  begin
    iNode := AddChild('Nome');
    iNode.Text := Nome;

    iNode := AddChild('Email');
    iNode.Text := Email;

    iNode := AddChild('Telefone');
    iNode.Text := Telefone;

    iNode := AddChild('Identidade');
    iNode.Text := Identidade;

    iNode := AddChild('Cpf');
    iNode.Text := Cpf;

    iNode := AddChild('Número');
    iNode.Text := Numero;

    iNode := AddChild('Complemento');
    iNode.Text := Complemento;

    if (Endereco <> nil) then
    begin
      iNode := AddChild('Endereco');
      iNode := Endereco.NodeXml(iNode);
    end;
  end;

  Result := iNode;
end;

end.
