unit uFrmCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, uCadastro, uEndereco, XmlDoc, XMLIntf,
  uILogavel, uAcoes, uListaCadastro;

type
  TFrmCadastro = class(TForm, ILogavel)
    gbxCadastro: TGroupBox;
    lblNome: TLabel;
    edtNome: TEdit;
    lblEmail: TLabel;
    edtEmail: TEdit;
    edtTelefone: TMaskEdit;
    lblTelefone: TLabel;
    lblIdentidade: TLabel;
    edtIdentidade: TMaskEdit;
    lblCpf: TLabel;
    edtCpf: TMaskEdit;
    edtCep: TMaskEdit;
    lblCep: TLabel;
    edtLogradouro: TEdit;
    lblLogradouro: TLabel;
    btnPesquisarCep: TBitBtn;
    edtBairro: TEdit;
    lblBairro: TLabel;
    edtCidade: TEdit;
    lblCidade: TLabel;
    lblUf: TLabel;
    lblPais: TLabel;
    lblNumero: TLabel;
    edtNumero: TEdit;
    edtComplemento: TEdit;
    lblComplemento: TLabel;
    lblInfoCep: TLabel;
    cbxUf: TComboBox;
    cbxPais: TComboBox;
    btnCadastrar: TBitBtn;
    lblObrigatorioNome: TLabel;
    lblObrigatorioEmail: TLabel;
    edtResultado: TMemo;
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarCepClick(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FEndereco: TEndereco;
    FListaCadastro: TListaCadastro;

    procedure InformarProcessamento(PTexto: string);
    procedure LimpaForm();
    procedure BuscaCep(PCep: string);

    function ValidarCadastro(): boolean;
    function CarregaObj(): TCadastro;
  public
    { Public declarations }
  end;

var
  FrmCadastro: TFrmCadastro;

implementation

{$R *.dfm}

{ TFrmCadastro }

procedure TFrmCadastro.LimpaForm;
begin
  cbxUf.ItemIndex := 0;
  cbxPais.ItemIndex := 0;
  edtNome.Text := EmptyStr;
  edtEmail.Text := EmptyStr;
  edtTelefone.Text := EmptyStr;
  edtIdentidade.Text := EmptyStr;
  edtCpf.Text := EmptyStr;
  edtCep.Text := EmptyStr;
  edtLogradouro.Text := EmptyStr;
  edtBairro.Text := EmptyStr;
  edtCidade.Text := EmptyStr;
  edtNumero.Text := EmptyStr;
  edtComplemento.Text := EmptyStr;
end;

procedure TFrmCadastro.FormShow(Sender: TObject);
begin
  LimpaForm;
end;

function TFrmCadastro.CarregaObj: TCadastro;
var
  obj: TCadastro;
begin
  obj := TCadastro.Create();
  with obj do
  begin
    Nome := edtNome.Text;
    Email := edtEmail.Text;
    Telefone := edtTelefone.Text;
    Identidade := edtIdentidade.Text;
    Cpf := edtCpf.Text;
    Numero := edtNumero.Text;
    Complemento := edtComplemento.Text;
    Endereco := FEndereco;
  end;

  Result := obj;
end;

procedure TFrmCadastro.btnPesquisarCepClick(Sender: TObject);
begin
  BuscaCep(Trim(edtCep.Text));
end;

procedure TFrmCadastro.BuscaCep(PCep: string);
begin
  lblInfoCep.Visible := false;
  FEndereco := TEndereco.Create(PCep);

  with FEndereco do
  begin
    lblInfoCep.Visible := not Localizado;
    edtLogradouro.Enabled := not Localizado;
    edtBairro.Enabled := not Localizado;
    edtCidade.Enabled := not Localizado;
    cbxUf.Enabled := not Localizado;
    cbxPais.Enabled := not Localizado;

    edtLogradouro.Text := Logradouro;
    edtBairro.Text := Bairro;
    edtCidade.Text := Cidade;
    cbxUf.ItemIndex := cbxUf.Items.IndexOf(Uf);
    cbxPais.ItemIndex := cbxPais.Items.IndexOf(Pais);
  end;
end;

procedure TFrmCadastro.btnCadastrarClick(Sender: TObject);
var
  arq: string;
  acoes: TAcoes;
  cad: TCadastro;
begin
  if (ValidarCadastro()) then
  begin
    cad := CarregaObj();
    acoes := TAcoes.Create(self, self, cad);
    arq := acoes.ExportarXml();

    //TODO: informar o remetente do e-mail, e as outras configurações de SMTP,
    // após isto, descomentar a linha abaixo
    //acoes.EnviarEmail('', 'Altec - Cadastro', arq);

    InformarProcessamento('Cadastro finalizado com sucesso.');
    FListaCadastro.Adicionar(cad);
    InformarProcessamento(IntToStr(FListaCadastro.Count) + ' itens cadastrados');
    LimpaForm();
  end;
end;

procedure TFrmCadastro.InformarProcessamento(PTexto: string);
var
  data: string;
begin
  DateTimeToString(data, 'dd/MM/yyyy HH:mm:ss', Now);
  edtResultado.Lines.Append(data + ' - ' + PTexto);
  edtResultado.Lines[edtResultado.Lines.Count-1];
end;

function TFrmCadastro.ValidarCadastro(): boolean;
begin
  //TODO: Criar outras validações
  //TODO: validar e-mail informado, cpf

  lblObrigatorioNome.Visible := Trim(edtNome.Text) = EmptyStr;
  lblObrigatorioEmail.Visible := Trim(edtEmail.Text) = EmptyStr;

  Result := (not lblObrigatorioNome.Visible)
        and (not lblObrigatorioEmail.Visible);
end;

procedure TFrmCadastro.FormCreate(Sender: TObject);
begin
  FListaCadastro := TListaCadastro.Create;
end;

end.
