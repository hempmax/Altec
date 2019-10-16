unit uListaCadastro;

interface

uses
  Classes, uCadastro, Dialogs;

type
  TListaCadastro = class
  private
    FListaCadastro: TList;
  public
    constructor Create;

    procedure Adicionar(ACadastro: TCadastro);
    procedure Remover(AIndex: Integer);
    function Count: Integer;
  end;

implementation

{ TListaCadastro }

procedure TListaCadastro.Adicionar(ACadastro: TCadastro);
begin
   FListaCadastro.Add(ACadastro);
end;

function TListaCadastro.Count: Integer;
begin
  Result := FListaCadastro.Count;
end;

constructor TListaCadastro.Create;
begin
  FListaCadastro := TList.Create;
end;

procedure TListaCadastro.Remover(AIndex: Integer);
begin
  if (AIndex < Count) and (AIndex > -1) then
    FListaCadastro.Delete(AIndex);
end;

end.
