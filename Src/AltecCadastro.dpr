program AltecCadastro;

uses
  Forms,
  uFrmCadastro in 'uFrmCadastro.pas' {FrmCadastro},
  uCadastro in 'uCadastro.pas',
  uEndereco in 'uEndereco.pas',
  Jsons in 'Jsons.pas',
  uILogavel in 'uILogavel.pas',
  uAcoes in 'uAcoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmCadastro, FrmCadastro);
  Application.Run;
end.
