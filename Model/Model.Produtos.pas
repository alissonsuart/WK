unit Model.Produtos;

interface

Uses Firedac.Comp.Client, Data.DB, System.SysUtils, Model.DAO;

type
   TProdutos = class
     private
        FID: integer;
        FDescricao: string;
        FPreco: double;
     public
        constructor Create;
        destructor Destroy; override;
        property ID: integer read FID write FID;
        property Descricao: string read FDescricao write FDescricao;
        property Preco: double read FPreco write FPreco;

        function Lista(AOrderBy: string; out error: string) : TFDQuery;
   end;


implementation

{ TProdutos }

constructor TProdutos.Create;
begin
   Model.DAO.connected;
end;

destructor TProdutos.Destroy;
begin
   Model.DAO.Disconnected;
  inherited;
end;

function TProdutos.Lista(AOrderBy: string; out error: string): TFDQuery;
var qry : TFDQuery;
begin
   Try
     qry := TFDQuery.Create(Nil);
     qry.Connection := Model.DAO.FConn;

     With qry Do
     Begin
        Active := False;
        SQL.Clear;
        SQL.Add('select * from produtos');

        if ID > 0 then
           SQL.Add(' where idProduto = ' + IntToStr(ID));

        if Trim(AOrderBy) <> '' then
           SQL.Add(' order by ' + AOrderBy);

        Active := True;
     End;

     error  := EmptyStr;
     Result := qry;
   except on e: exception do
     Begin
        error  := 'Erro ao listar produtos: ' + e.Message;
        Result := Nil;
     End;
   End;
end;

end.
