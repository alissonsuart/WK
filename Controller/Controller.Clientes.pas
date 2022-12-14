unit Controller.Clientes;

interface
uses System.SysUtils, FireDac.Comp.Client, Model.Clientes;

function ListaTodosCodigo: TFDQuery;
function ListaPorID(AID: Integer): TClientes;


implementation

function ListaTodosCodigo: TFDQuery;
var Lista: TClientes;
    qry: TFDQuery;
    erro: String;
Begin
   Try
     Lista := TClientes.Create;
   except
      raise Exception.Create('erro ao listar');
   End;

   if not assigned(qry) then
      qry := TFDQuery.Create(Nil);

   qry.SQL.Clear;
   Try
     qry := Lista.Lista('idCliente',erro);

     if Trim(erro) <> '' then
        raise Exception.Create(erro);

   Finally
     Lista.Free;
     Result := qry;
     Qry.Free;
   End;
End;

function ListaPorID(AID: Integer): TClientes;
var Lista: TClientes;
    qry: TFDQuery;
    erro: string;
begin
   Try
     Lista := TClientes.Create;
     Lista.ID := AID;
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

     With Lista Do
     Begin
        ID     := qry.FieldByName('IDCliente').AsInteger;
        Nome   := qry.FieldByName('Nome').AsString;
        Cidade := qry.FieldByName('Cidade').AsString;
        UF     := qry.FieldByName('UF').AsString;
     End;

   Finally
     Result := Lista;
     Qry.Free;
   End;
end;

end.
