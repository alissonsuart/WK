unit Controller.Pedidos;

interface
uses System.SysUtils, FireDac.Comp.Client, Model.Pedidos;

function ListaTodosCodigo: TFDQuery;
function ListaPorID(AID: Integer): TFDQuery;
function ListaPorCliente(ACliente: integer): TFDQuery;
function BuscaPedidoExiste(AID: Integer): boolean;

function InserirPedido(APedido : TPedidos) : boolean;
function DeletarPedido(APedido: Integer): boolean;

implementation

function ListaTodosCodigo: TFDQuery;
var Lista: TPedidos;
    qry: TFDQuery;
    erro: String;
Begin
   Try
     Lista := TPedidos.Create;
   except
      raise Exception.Create('erro ao listar');
   End;

   if not assigned(qry) then
      qry := TFDQuery.Create(Nil);

   qry.SQL.Clear;
   Try
     qry := Lista.Lista('idPedido DESC',erro);

     if Trim(erro) <> '' then
        raise Exception.Create(erro);

   Finally
     Lista.Free;
     Result := qry;
     Qry.Free;
   End;
End;

function ListaPorID(AID: Integer): TFDQuery;
var Lista: TPedidos;
    qry: TFDQuery;
    erro: string;
begin
   Try
     Lista := TPedidos.Create;
     Lista.IDPedido := AID;
   except
      raise Exception.Create('erro ao listar');
   End;

   if not assigned(qry) then
      qry := TFDQuery.Create(Nil);

   qry.SQL.Clear;
   Try
     qry := Lista.Lista('',erro);

     if Trim(erro) <> '' then
        raise Exception.Create(erro);

   Finally
     Result := qry;
   End;
end;

function ListaPorCliente(ACliente: integer): TFDQuery;
var Lista: TPedidos;
    qry: TFDQuery;
    erro: string;
begin
   Try
     Lista := TPedidos.Create;
     Lista.IDCliente := ACliente;
   except
      raise Exception.Create('erro ao listar');
   End;

   if not assigned(qry) then
      qry := TFDQuery.Create(Nil);

   qry.SQL.Clear;
   Try
     qry := Lista.Lista('',erro);

     if Trim(erro) <> '' then
        raise Exception.Create(erro);

   Finally
     Lista.Free;
     Result := qry;
     Qry.Free;
   End;
end;

function BuscaPedidoExiste(AID: Integer): boolean;
var Lista: TPedidos;
    qry: TFDQuery;
    erro: string;
begin
   Try
     Lista := TPedidos.Create;
     Lista.IDPedido := AID;
   except
      raise Exception.Create('erro ao listar');
   End;

   if not assigned(qry) then
      qry := TFDQuery.Create(Nil);

   qry.SQL.Clear;
   Try
     qry        := Lista.Lista('',erro);
     qry.Active := True;

     if Trim(erro) <> '' then
        raise Exception.Create(erro);

   Finally
     if qry.IsEmpty then
          Result := False
     else Result := True;

     qry.Active := False;
     qry.Free;
   End;

End;

function InserirPedido(APedido : TPedidos) : boolean;
var Ped : TPedidos;
    error: string;
begin
   Try
     Try
       Ped := TPedidos.Create;
       Ped := APedido;
       Ped.Inserir(error);
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

function DeletarPedido(APedido: Integer): boolean;
var Ped : TPedidos;
    error: string;
begin
   Try
     Try
       Ped := TPedidos.Create;
       Ped.IDPedido := APedido;
       Ped.Deletar(error);
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
end.
