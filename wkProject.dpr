program wkProject;

uses
  Vcl.Forms,
  uPrincipal in 'View\uPrincipal.pas' {frm_Principal},
  Model.DAO in 'Model\Model.DAO.pas',
  Model.Clientes in 'Model\Model.Clientes.pas',
  Controller.Clientes in 'Controller\Controller.Clientes.pas',
  Model.Produtos in 'Model\Model.Produtos.pas',
  Controller.Produtos in 'Controller\Controller.Produtos.pas',
  Model.Pedidos in 'Model\Model.Pedidos.pas',
  Controller.Pedidos in 'Controller\Controller.Pedidos.pas',
  Model.ItensPedido in 'Model\Model.ItensPedido.pas',
  Controller.ItensPedido in 'Controller\Controller.ItensPedido.pas',
  Model.ListaItensPedido in 'Model\Model.ListaItensPedido.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_Principal, frm_Principal);
  Application.Run;
end.
