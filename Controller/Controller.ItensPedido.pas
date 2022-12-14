unit Controller.ItensPedido;

interface
uses System.SysUtils, FireDac.Comp.Client, Model.ItensPedido;

function ListaTodosCodigo(AIDPedido: integer): TFDQuery;
function InserirPedido(APedido : TItensPedido) : boolean;
function DeletaPedido(AIDPedido: integer): Boolean;

implementation

function ListaTodosCodigo(AIDPedido: integer): TFDQuery;
var Lista: TItensPedido;
    qry: TFDQuery;
    erro: String;
Begin
   if AIDPedido = 0 then
      raise Exception.Create('Informe um pedido válido');

   Try
     Lista := TItensPedido.Create;
   except
      raise Exception.Create('erro ao listar');
   End;

   if not assigned(qry) then
      qry := TFDQuery.Create(Nil);

   qry.SQL.Clear;
   Try
     qry := Lista.Lista('idItem',erro);

     if Trim(erro) <> '' then
        raise Exception.Create(erro);

   Finally
     Lista.Free;
     Result := qry;
//     Qry.Free;
   End;
End;

function InserirPedido(APedido : TItensPedido) : boolean;
var Ped : TItensPedido;
    error: string;
begin
   Try
     Try
       Ped := TItensPedido.Create;
       Ped := APedido;
       Ped.inserirItens(error);
       if Trim(error) <> '' then
          raise Exception.Create(error);

       result := True;
     Except
        Result := False;
     End;
   Finally
     Ped.Free;
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
