unit Model.ListaItensPedido;
interface
Uses Firedac.Comp.Client, Data.DB, System.SysUtils, Model.DAO, Model.ItensPedido,
     Classes, Dialogs;
Type
    TListaItens = class
      private
         FListaItens : TList;
      public
         Constructor Create;
         procedure Add(pItens : TItensPedido);
         procedure Del(Index : Integer);
         Function Count: Integer;
         Procedure Items(Index: Integer);
         Function ItensPedido(Index: integer) : TItensPedido;
         Procedure Clear;
    end;
implementation
{ TListaItens }
procedure TListaItens.Add(pItens: TItensPedido);
begin
   FListaItens.Add(pItens);
end;
procedure TListaItens.Clear;
begin
   FListaItens.Clear;
end;

function TListaItens.Count: Integer;
begin
   Result := FListaItens.Count;
end;
Procedure TListaItens.Items(Index: Integer);
begin
   FListaItens.Items[index];
end;
function TListaItens.ItensPedido(Index: integer): TItensPedido;
begin
   FListaItens.Items[Index];
   Result := (TItensPedido(FListaItens));
end;
constructor TListaItens.Create;
begin
   FListaItens := TList.Create;
end;
procedure TListaItens.Del(Index: Integer);
begin
   if Index < Count then
      FListaItens.Delete(Index)
   else ShowMessage('item n�o localizado.');
end;
end.
