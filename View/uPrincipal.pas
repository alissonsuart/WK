unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.Mask, Datasnap.DBClient, Model.DAO, Model.Clientes, Model.Produtos,
  Controller.Clientes, Controller.Produtos, Model.Pedidos, Model.ItensPedido, Model.ListaItensPedido;

type
  Tfrm_Principal = class(TForm)
    panelPrincipal: TPanel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn6: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit4: TEdit;
    BitBtn7: TBitBtn;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label8: TLabel;
    DataSource1: TDataSource;
    cdsItens: TClientDataSet;
    cdsItensidItem: TIntegerField;
    cdsItensidPedido: TIntegerField;
    cdsItensidProduto: TIntegerField;
    cdsItensDescricaoProduto: TStringField;
    cdsItensquantidade: TFloatField;
    cdsItensvalor_unitario: TFloatField;
    cdsItensvalor_total: TFloatField;
    BitBtn2: TBitBtn;
    procedure ValidaQuantidade;
    procedure ValidaValor;
    procedure limpaItens;
    procedure limpaCampos;
    procedure totalizaPedido;
    procedure alteraProduto;
    procedure carregaItens;
    procedure carregaPedido;
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit7Exit(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure DBGrid1Exit(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit6Enter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
  private
    { Private declarations }
    bAlterando : boolean;

    ListaItensPed : TListaItens;
    ItensPedido : TItensPedido;
    Pedido : TPedidos;
  public
    { Public declarations }
  end;

var
  frm_Principal: Tfrm_Principal;

implementation

{$R *.dfm}

uses Controller.Pedidos, Controller.ItensPedido;

procedure Tfrm_Principal.alteraProduto;
begin
   Edit1.Text     := cdsItensidProduto.AsString;
   Label8.Caption := cdsItensDescricaoProduto.AsString;
   Edit2.Text     := cdsItensquantidade.AsString;
   Edit3.Text     := cdsItensvalor_unitario.AsString;
   Edit2.SetFocus;
end;

procedure Tfrm_Principal.BitBtn1Click(Sender: TObject);
var FConn : TFDConnection;
begin
   Try
     FConn := Model.DAO.Connected;
     if FConn.Connected then
     Begin
        ShowMessage('Conectado com sucesso');
        Model.DAO.Disconnected;
     End;
   except on e: exception do
      raise Exception.Create('erro ao criar conex�o: ' + e.Message);
   End;
end;

procedure Tfrm_Principal.BitBtn2Click(Sender: TObject);
begin
   limpaCampos;
   Edit5.SetFocus;
   cdsItens.EmptyDataSet;
   ListaItensPed.Clear;
end;

procedure Tfrm_Principal.BitBtn3Click(Sender: TObject);
var
  I: Integer;
begin
   carregaPedido;
   If Controller.Pedidos.InserirPedido(Pedido) Then
   begin
        cdsItens.First;
        while not(cdsItens.Eof) do
        begin
           carregaItens;
           Controller.ItensPedido.InserirPedido(ItensPedido);

           cdsItens.Next;
        end;

        ShowMessage('Pedido gravado com sucesso');
        limpaCampos;
   end
   else raise Exception.Create('Falha ao gravar pedido');
end;

procedure Tfrm_Principal.BitBtn5Click(Sender: TObject);
var nPed: String;
begin
   if InputQuery('Informe o Pedido para Excluir','Nr.Pedido',nPed) then
   Begin
      If Controller.ItensPedido.DeletaPedido(StrtoInt(nPed)) Then
         if Controller.Pedidos.DeletarPedido(StrToInt(nPed)) Then
         Begin
            ShowMessage('Exclus�o efetuada com sucesso.');
            limpaCampos;
         End;
   End;
end;

procedure Tfrm_Principal.BitBtn6Click(Sender: TObject);
begin
   ValidaQuantidade;
   ValidaValor;
   Try
     if not(bAlterando) then
     Begin
         with cdsItens Do
         Begin
            Insert;
            FieldByName('idItem').AsInteger          := cdsItens.RecordCount + 1;
            FieldByName('idPedido').AsInteger        := StrToInt(Edit5.Text);
            FieldByName('idProduto').AsInteger       := StrToInt(Edit1.Text);
            FieldByName('DescricaoProduto').AsString := Label8.Caption;
            FieldByName('Quantidade').AsFloat        := StrToFloat(edit2.Text);
            FieldByName('Valor_Unitario').AsFloat    := StrToFloat(Edit3.Text);
            FieldByName('Valor_total').AsFloat       := StrToFloat(edit2.Text) * StrToFloat(Edit3.Text);
            Post;
         End;
     End
       else
     Begin
         with cdsItens Do
         Begin
            Edit;
            FieldByName('Quantidade').AsFloat        := StrToFloat(edit2.Text);
            FieldByName('Valor_Unitario').AsFloat    := StrToFloat(Edit3.Text);
            FieldByName('Valor_total').AsFloat       := StrToFloat(edit2.Text) * StrToFloat(Edit3.Text);
            Post;
         End;
     End;
     bAlterando := False;
     limpaItens;
     TotalizaPedido;
     Edit1.SetFocus;
     cdsItens.IndexFieldNames := 'idItem';
   Except
   End;
end;

procedure Tfrm_Principal.BitBtn7Click(Sender: TObject);
var nPed: String;
    qry: TFDQuery;
begin
   if InputQuery('Informe o Pedido para pesquisar','Nr.Pedido',nPed) then
   Begin
      Try
        qry := TFDQuery.Create(Nil);
        qry.Connection := Model.DAO.connected;
        qry            := Controller.Pedidos.ListaPorID(StrToInt(nPed));
        qry.Active     := True;

        if not qry.IsEmpty then
        Begin
           Edit4.Text := FormatFloat('##0.00',qry.FieldByName('ValorTotal').AsFloat);
           Edit5.Text := qry.FieldByName('IDPedido').AsString;
           Edit6.Text := qry.FieldByName('DataEmissao').AsString;
           Edit7.Text := qry.FieldByName('idCliente').AsString;
           Edit8.Text := qry.FieldByName('Nome').AsString;
        End;

        qry.Active     := False;
        qry.SQL.Clear;
        qry            := Controller.ItensPedido.ListaTodosCodigo(StrToInt(nPed));
        qry.Connection := Model.DAO.connected;
        qry.Active     := True;

        if not qry.IsEmpty then
        Begin
           cdsItens.EmptyDataSet;
           while not qry.Eof do
           Begin
               with cdsItens Do
               Begin
                  Insert;
                  FieldByName('idItem').AsInteger          := qry.FieldByName('idItemPedido').AsInteger;
                  FieldByName('idPedido').AsInteger        := qry.FieldByName('idPedido').AsInteger;
                  FieldByName('idProduto').AsInteger       := qry.FieldByName('idProduto').AsInteger;
                  FieldByName('DescricaoProduto').AsString := qry.FieldByName('Descricao').AsString;
                  FieldByName('Quantidade').AsFloat        := qry.FieldByName('Quantidade').AsFloat;
                  FieldByName('Valor_Unitario').AsFloat    := qry.FieldByName('ValorUnitario').AsFloat;
                  FieldByName('Valor_total').AsFloat       := qry.FieldByName('Quantidade').AsFloat * qry.FieldByName('ValorUnitario').AsFloat;
                  Post;
               End;
               qry.Next;
           End;
        End;
      Finally
        qry.Close;
        qry.Free;
      End;
   End;
end;

procedure Tfrm_Principal.carregaItens;
begin
   with Itenspedido do
   Begin
      IDItem           := cdsItensidItem.AsInteger;
      IDPedido         := cdsItensidPedido.AsInteger;
      IDProduto        := cdsItensidProduto.AsInteger;
      DescricaoProduto := cdsItensDescricaoProduto.AsString;
      Quantidade       := cdsItensquantidade.AsFloat;
      ValorUnitario    := cdsItensvalor_unitario.AsFloat;
   End;
end;

procedure Tfrm_Principal.carregaPedido;
begin
   With Pedido Do
   Begin
      IDPedido    := StrToInt(Edit5.Text);
      DataEmissao := StrToDate(Edit6.Text);
      IDCliente   := StrToInt(Edit7.Text);
      ValorTotal  := StrToFloat(StringReplace(Edit4.Text,'.','',[rfReplaceAll]));
   End;
end;

procedure Tfrm_Principal.DBGrid1Enter(Sender: TObject);
begin
   frm_Principal.KeyPreview := False;
end;

procedure Tfrm_Principal.DBGrid1Exit(Sender: TObject);
begin
   frm_Principal.KeyPreview := True;
end;

procedure Tfrm_Principal.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case key of
      VK_DELETE : if Messagedlg('Excluir registro ?', mtConfirmation, [mbyes,mbno],0)= mrYes then
                  Begin
                     cdsItens.Delete;
                     totalizaPedido;
                  End;

      VK_RETURN : begin
                     AlteraProduto;
                     bAlterando := True;
                  end;
   end;
end;

procedure Tfrm_Principal.Edit1Exit(Sender: TObject);
var Produtos : TProdutos;
begin
   if Trim(Edit1.Text) <> '' then
   Begin
      Try
        Produtos := TProdutos.Create;
        Produtos := Controller.Produtos.ListaPorID(StrToInt(Edit1.Text));
      Finally
        Edit1.Text     := Produtos.ID.ToString;
        Label8.Caption := Produtos.Descricao;
        Edit3.Text     := FormatFloat('###,##0.00',Produtos.Preco);
        Edit2.SetFocus;
        Produtos.Free;
      End;
   End;
end;

procedure Tfrm_Principal.Edit5Exit(Sender: TObject);
begin
   if Trim(Edit5.Text) <> '' then
   Begin
      if Controller.Pedidos.BuscaPedidoExiste(StrToInt(Edit5.Text)) then
      begin
         Edit5.SetFocus;
         raise Exception.Create('Este n�mero de pedido j� existe.');
      end;
   End;
end;

procedure Tfrm_Principal.Edit6Enter(Sender: TObject);
begin
   if Trim(Edit6.Text) = '' then
      Edit6.Text := DateToStr(Now);
end;

procedure Tfrm_Principal.Edit7Exit(Sender: TObject);
var Cliente: TClientes;
begin
   if Trim(Edit7.Text) <> '' then
   Begin
      Try
        Cliente := TClientes.Create;
        Cliente := Controller.Clientes.ListaPorID(StrToInt(Edit7.Text));
      Finally
        Edit7.Text := Cliente.ID.ToString;
        Edit8.Text := Cliente.Nome;
        Cliente.Free;
      End;
   End;
end;

procedure Tfrm_Principal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure Tfrm_Principal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If (Key = #13) Then
  Begin
    If Not (ActiveControl is TDBGrid) Then
    Begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0);
    End ;
  End ;

  If (Key = #9) Then
  Begin
    If (ActiveControl is TDBGrid) Then
    Begin
      Perform(WM_NEXTDLGCTL,0,0);
      Key := #0;
    End ;
  End ;
end;

procedure Tfrm_Principal.FormShow(Sender: TObject);
begin
   cdsItens.Close;
   cdsItens.CreateDataSet;
   cdsItens.Open;

   ItensPedido   := TItensPedido.Create;
   Pedido        := TPedidos.Create;
   ListaItensPed := TListaItens.Create;

   cdsItensquantidade.DisplayFormat     := '##0.000';
   cdsItensvalor_unitario.DisplayFormat := '##0.00';
   cdsItensvalor_total.DisplayFormat    := '##0.00';

   Edit5.SetFocus;
end;

procedure Tfrm_Principal.limpaCampos;
begin
   Edit1.Clear;
   Edit2.Clear;
   Edit3.Clear;
   Edit4.Clear;
   Edit5.Clear;
   Edit6.Clear;
   Edit7.Clear;
   Edit8.Clear;
   cdsItens.EmptyDataSet;
end;

procedure Tfrm_Principal.limpaItens;
begin
   Edit1.Clear;
   Label8.Caption := EmptyStr;
   Edit2.Clear;
   Edit3.Clear;
end;

procedure Tfrm_Principal.totalizaPedido;
var totalItem: Currency;
begin
   totalItem := 0;
   cdsItens.First;
   while not(cdsItens.Eof) do
   begin
      totalItem := totalItem + cdsItensvalor_total.AsFloat;

      cdsItens.Next;
   end;

   Edit4.Text := FormatFloat('###,##0.00', totalItem);
end;

procedure Tfrm_Principal.ValidaQuantidade;
begin
   if Trim(Edit2.Text) = '' then
   Begin
      Edit2.SetFocus;
      raise Exception.Create('Informe uma quantidade');
   End;

   Try
     StrToInt(Edit2.Text);
   except
     raise Exception.Create('Informe somente N�meros para a quantidade');
   End;
end;

procedure Tfrm_Principal.ValidaValor;
begin
   if Trim(Edit3.Text) = '' then
   Begin
      Edit3.SetFocus;
      raise Exception.Create('Informe um valor');
   End;

   Try

   except
     raise Exception.Create('Informe um valor para o produto');
   End;

end;

end.
