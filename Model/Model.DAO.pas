unit Model.DAO;

interface

uses System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL, FireDAC.Comp.UI;

  Function  connected : TFDConnection;
  Procedure Disconnected;
  Function  Transaction : TFDTransaction;

var
  FConn : TFDConnection;
  FTran : TFDTransaction;
  FMySQLDrive: TFDPhysMySQLDriverLink;

implementation

function Connected : TFDConnection;
begin
   FMySQLDrive           := TFDPhysMySQLDriverLink.Create(Nil);
   FMySQLDrive.VendorLib := 'C:\Sistema\Executaveis\libmysql.dll';

   FConn := TFDConnection.Create(Nil);
   FConn.Params.DriverID := 'MYSQL';
   FConn.Params.Database := 'banco_teste';
   FConn.Params.UserName := 'Alisson';
   FConn.Params.Password := 'Dmasters@10';
   FConn.Params.Add('Port=3306');
   FConn.Params.Add('Server=192.168.0.99');
   FConn.Connected := True;
   Result := FConn;
end;

procedure Disconnected;
begin
   if Assigned(FConn) then
   Begin
      FConn.Connected := False;
      FConn.Free;
      FMySQLDrive.Free;
   End;
end;

Function  Transaction : TFDTransaction;
Begin
   FTran := TFDTransaction.Create(Nil);
   FTran.Connection := FConn;
   Result := FTran;
End;

end.