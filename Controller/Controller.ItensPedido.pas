unit Controller.ItensPedido;

interface

uses System.SysUtils, FireDac.Comp.Client, Model.ItensPedido;

function ListaTodosCodigo(AIDPedido: integer): TFDQuery;
function InserirPedido(AItens: TItensPedido) : boolean;
function DeletaPedido(AIDPedido: integer): Boolean;

implementation

function ListaTodosCodigo(AIDPedido: integer): TFDQuery;
var Lista: TItensPedido;
    qry: TFDQuery;
    erro: String;
Begin
   if AIDPedido = 0 then
      raise Exception.Create('Informe um pedido v�lido');
   Try
     Lista := TItensPedido.Create;
     if AIDPedido > 0 then
        Lista.IDPedido := AIDPedido;
   except
      raise Exception.Create('erro ao listar');
   End;
   if not assigned(qry) then
      qry := TFDQuery.Create(Nil);
   qry.SQL.Clear;
   Try
     qry := Lista.Lista('idItemPedido',erro);
     if Trim(erro) <> '' then
        raise Exception.Create(erro);
   Finally
     Result := qry;
   End;
End;

function InserirPedido(AItens: TItensPedido) : boolean;
var error: string;
    Itens : TItensPedido;
    I : Integer;
begin
   Try
     Try
       Itens := TItensPedido.Create;
       Itens := AItens;
       Itens.inserirItens(error);

       if Trim(error) <> '' then
          raise Exception.Create(error);
       result := True;
     Except
        Result := False;
     End;
   Finally
//     Itens.Free;
   End;
end;

function DeletaPedido(AIDPedido: integer): Boolean;
var IPed: TItensPedido;
    error: String;
begin
   try
       Try
         if AIDPedido = 0 then
            raise Exception.Create('Informe um Pedido para excluir');
         IPed := TItensPedido.Create;
         IPed.IDPedido := AIDPedido;
         IPed.DeletarItens(error);
           if Trim(error) <> '' then
              raise Exception.Create(error);
         result := True;
       except
          result := false;
       End;
   finally
     IPed.Free;
   end;
end;

end.
