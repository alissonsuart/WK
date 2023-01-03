unit Model.ItensPedido;

interface

Uses Firedac.Comp.Client, Data.DB, System.SysUtils, Model.DAO;

Type
   TItensPedido = class
     private
        FIDItem: integer;
        FIDPedido: integer;
        FIDProduto: integer;
        FQuantidade: Double;
        FValorUnitario: Double;
        FDescricaoProduto: String;
     public
        constructor Create;
        destructor Destroy; override;
        property IDItem: integer read FIDItem write FIDItem;
        property IDPedido: integer read FIDPedido write FIDPedido;
        property IDProduto: integer read FIDProduto write FIDProduto;
        property Quantidade: double read FQuantidade write FQuantidade;
        property ValorUnitario: double read FValorUnitario write FValorUnitario;
        property DescricaoProduto: String read FDescricaoProduto write FDescricaoProduto;

        function Lista(AOrderBy: String; out Error: String) : TFDQuery;
        function inserirItens(out error: string) : boolean;
        function DeletarItens(out error: string):Boolean;
   end;

implementation

{ ItensPedido }

constructor TItensPedido.Create;
begin

end;

function TItensPedido.DeletarItens(out error: string): Boolean;
var qry : TFDQuery;
begin
     qry := TFDQuery.Create(Nil);
     qry.Connection  := Model.Dao.connected;
     qry.Transaction := Model.DAO.Transaction;

     FTran.StartTransaction;
     qry.SQL.Clear;
     Try
       qry.SQL.Add('delete from itenspedidos where idPedido = :idPedido');
       qry.ParamByName('idPedido').AsInteger     := IDPedido;
       qry.ExecSQL;

       Result := True;
       FTran.Commit;
     except on e: exception do
     begin
        FTran.Rollback;
        error  := e.Message;
        Result := False;
     end;
     End;
end;

destructor TItensPedido.Destroy;
begin

  inherited;
end;

function TItensPedido.Lista(AOrderBy: String; out Error: String): TFDQuery;
var qry : TFDQuery;
begin
   Model.DAO.connected;
   Try
     qry := TFDQuery.Create(Nil);
     qry.Connection := Model.DAO.FConn;

     With qry Do
     Begin
        Active := False;
        SQL.Clear;
        SQL.Add('select ip.*, p.descricao from itenspedidos ip inner join produtos p (ip.idproduto = p.idproduto)');

        if (IDPedido > 0) Or (IDProduto > 0) Then
        Begin
           SQL.Add(' where ');
           if IDPedido > 0 then
              SQL.Add(' ip.idPedido = ' + IntToStr(IDPedido));

           if (IDPedido > 0) and (IDProduto > 0) then
               SQL.Add(' and ');

           if IDProduto > 0 then
              SQL.Add(' p.idProduto = ' + IntToStr(IDProduto));
        End;

        if Trim(AOrderBy) <> '' then
           SQL.Add(' order by p.' + AOrderBy);

        Active := True;
     End;

     error  := EmptyStr;
     Result := qry;
   except on e: exception do
     Begin
        error  := 'Erro ao listar itens do pedido: ' + e.Message;
        Result := Nil;
     End;
   End;

   Model.DAO.Disconnected;
end;

function TItensPedido.inserirItens(out error: string) : boolean;
var qry : TFDQuery;
begin
     qry := TFDQuery.Create(Nil);
     qry.Connection  := Model.Dao.connected;
     qry.Transaction := Model.DAO.Transaction;

     FTran.StartTransaction;
     qry.SQL.Clear;
     Try
       qry.SQL.Add('insert into itenspedidos (iditemPedido, idPedido, idProduto, Quantidade, ValorUnitario)');
       qry.SQL.Add('values (:idItem, :idPedido, :idProduto, :Quantidade, :valorUnitario)');

       qry.ParamByName('idItem').AsInteger       := IDItem;
       qry.ParamByName('idPedido').AsInteger     := IDPedido;
       qry.ParamByName('idProduto').AsInteger    := IDProduto;
       qry.ParamByName('Quantidade').AsFloat     := Quantidade;
       qry.ParamByName('valorUnitario').AsFloat  := valorUnitario;
       qry.ExecSQL;

       Result := True;
       FTran.Commit;
     except on e: exception do
     begin
        FTran.Rollback;
        error  := e.Message;
        Result := False;
     end;
     End;
end;

end.
