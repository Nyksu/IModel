unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, ComCtrls, ExtCtrls, DB, Buttons, Grids,
  DBGrids, DBTables, DBClient;

type
  TForm6 = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    TreeView1: TTreeView;
    Panel4: TPanel;
    Panel3: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    CheckBox1: TCheckBox;
    procedure TreeView1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TreeView1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure SpeedButton1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TreeView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;
  mH:integer;
  HighID:integer;

  procedure TreeAction(CDS: TClientDataSet);
  procedure ClearEdit;
  function RunOperation(Query:TQuery):boolean;
  function DeleteBlock:boolean;
  function AddBlock(CDS: TClientDataSet): Boolean;
  function ChangeBlock(CDS: TClientDataSet): Boolean;
  function FindCurrentNode(Index:integer; tView:TTreeView):integer;

implementation
  uses unit1, DMmodel;
{$R *.dfm}

procedure TForm6.TreeView1Click(Sender: TObject);
begin
  if form6.TreeView1.Items.Count > 0 then TreeAction(DM.cds_work);
end;

procedure TForm6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.Enabled := True;
end;

procedure TForm6.FormShow(Sender: TObject);
begin
  FillTree(form6.TreeView1, DM.cds_work, 'id', 'hi_id', 'name', True);
end;

procedure TForm6.TreeView1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if form6.TreeView1.Items.Count > 0 then TreeAction(DM.cds_work);
end;

procedure TreeAction(CDS: TClientDataSet);
var i: Integer;
    Res, Params: Variant;
begin
  i := Integer(form6.TreeView1.Selected.Data);
  HighID := i;
  if i > 0 then
    begin
      try
        Params := VarArrayCreate([0,1], varVariant);
        Params[0] := VarArrayOf(['ID']);
        Params[1] := VarArrayOf([i]);
        CDS.Active := False;
        Res := DM.GetData('Pav264', Params);
        if not VarIsNull(Res) then
          begin
            CDS.Data := Res;
      form6.Edit1.Text := CDS.FieldByName('NAME').AsString;
      form6.Edit2.Text := CDS.FieldByName('STATE').AsString;
      form6.Edit3.Text := CDS.FieldByName('ID').AsString;
      form6.Edit4.Text := CDS.FieldByName('HI_ID').AsString;
          end;
      except

      end;
    end
    else
    begin
      ClearEdit;
    end;
  FindCurrentNode(HighID, form1.TreeView1);
  RefreshGrid(Form1.CDSSQLCode, i, 0);


end;

procedure ClearEdit;
begin
  form6.Edit1.Clear;
  form6.Edit2.Clear;
  form6.Edit3.Clear;
  form6.Edit4.Clear;
end;

procedure TForm6.SpeedButton1Click(Sender: TObject);
begin
  if (form6.Edit1.Text <> '') and (form6.Edit1.Text <> 'Блоки:') then
    begin
      AddBlock(DM.cds_work);
    end;
  form6.CheckBox1.Checked := False;
end;

function AddBlock(CDS: TClientDataSet): Boolean;
var Res, Params: Variant;
    MemID: Integer;
begin
  Result := True;
  try
     DM.StartTrans;
     if Central then
        begin
          CDS.Active := False;
          Params := Null;
          Res := DM.GetData('Pav250', Params);
          if not VarIsNull(Res) then
            begin
              CDS.Data := Res;
              IDPool := CDS.FieldByName('IDPOOL').AsInteger;
            end;

        end
        else
        begin
          IDPool := UseOnePoolID;
        end;

     if IDPool <> 0 then
       begin
         Params := VarArrayCreate([0,1], varVariant);
         Params[0] := VarArrayOf(['IDPool', 'NAME', 'STATE', 'HI_ID', 'KN']);
         Params[1] := VarArrayOf([IdPool, form6.Edit1.Text, 3, HighID,
                                  form1.user_name.Text + IntToStr(IDPool)]);
         Res := DM.RunSQL('Pav261', Params);
         if Res <> 0 then
           begin
             DM.BackTrans;
             Result := False;
           end
           else
             DM.CommTrans;
       end
       else
       begin
         MessageDlg('Нет доступных ключей!', mtError, [mbOK], 0);
         Result := False;
       end;


  except
    Result := False;
  end;


if Result then
  begin
    if not Central then
      begin
        PoolTable.Delete(0);
        form1.Label9.Caption := IntToStr(StrToInt(form1.Label9.Caption)-1);
        SavePoolTable;
        if PoolTable.Count = 0 then
          begin
            DeleteFile(PoolFile);
          end;
      end;
    FillTree(form1.TreeView1, DM.cds_work, 'id', 'hi_id', 'name', False);
    FillTree(form6.TreeView1, DM.cds_work, 'id', 'hi_id', 'name', True);
    FindCurrentNode(IDPool, form6.TreeView1);
    FindCurrentNode(IDPool, form1.TreeView1);
    TreeAction(DM.cds_work);
  end;
end;

function DeleteBlock: Boolean;
var Res, Params: Variant;
begin
  Result := True;
  try
    DM.StartTrans;
    Params := VarArrayCreate([0,1], varVariant);
    Params[0] := VarArrayOf(['STATE', 'ID']);
    Params[1] := VarArrayOf([-1, HighID]);
    Res := DM.RunSQL('Pav263', Params);
    if Res <> 0 then
      begin
        DM.BackTrans;
        Result := False;
      end
      else
        DM.CommTrans;
  except
    Result := False;
  end;

  if Result=true then
  begin
    FillTree(form1.TreeView1, DM.cds_work, 'id', 'hi_id', 'name', False);
    FillTree(form6.TreeView1, DM.cds_work, 'id', 'hi_id', 'name', True);
    ClearEdit;
    TreeAction(DM.cds_work);
  end;
end;

function ChangeBlock(CDS: TClientDataSet): Boolean;
var Res, Params: Variant;
    MemID: string;
begin
  Result := True;
    try
      DM.StartTrans;
      Params := VarArrayCreate([0,1], varVariant);
      Params[0] := VarArrayOf(['NAME', 'STATE', 'ID']);
      Params[1] := VarArrayOf([form6.Edit1.Text, 2, HighID]);
      Res := DM.RunSQL('Pav262', Params);
      if Res <> 0 then
        begin
          DM.BackTrans;
          Result := False;
        end
        else
          DM.CommTrans;
    except
      Result := False;
    end;

  if Result then
    begin
      FillTree(form1.TreeView1, DM.cds_work, 'id', 'hi_id', 'name', False);
      FillTree(form6.TreeView1, DM.cds_work, 'id', 'hi_id', 'name', True);
      FindCurrentNode(HighID, form6.TreeView1);
      FindCurrentNode(HighID, form1.TreeView1);
      TreeAction(DM.cds_work);
    end;

end;

function RunOperation(Query:TQuery):boolean;
begin
 Result:=false;
    try
     Query.ExecSQL;

     Result:=true;
    except

     MessageDlg('Вероятно поля с такими параметрами уже существуют.', mtError, [mbOk], 0);
    end;
end;

procedure TForm6.SpeedButton3Click(Sender: TObject);
begin
  if (form6.TreeView1.Selected.Text <> 'Блоки:') then ChangeBlock(DM.cds_work);
  form6.CheckBox1.Checked := False;
end;

procedure TForm6.SpeedButton2Click(Sender: TObject);
begin
  if (form6.TreeView1.Selected.Text <> 'Блоки:') then DeleteBlock;
  form6.CheckBox1.Checked := False;
end;

procedure TForm6.SpeedButton4Click(Sender: TObject);
begin
  form6.CheckBox1.Checked := False;
  form6.Close;
end;

procedure TForm6.TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex := 1;
end;

procedure TForm6.SpeedButton1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  form6.Label6.Caption:='';
if form6.Edit1.Text<>'' then
 begin
  form6.Label6.Caption:='Добавить:'+#13+
  form6.Edit1.Text+#13+
  'в'+#13+form6.TreeView1.Selected.Text;
 end;
end;

procedure TForm6.Panel4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  form6.Label6.Caption:='';
end;

procedure TForm6.GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  form6.Label6.Caption:='';
end;

procedure TForm6.TreeView1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  form6.Label6.Caption := '';
end;

procedure TForm6.SpeedButton2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  form6.Label6.Caption:='';
if form6.Edit1.Text<>'' then
 begin
  form6.Label6.Caption:='Удалить:'+#13+
  form6.TreeView1.Selected.Text;
 end;
end;

procedure TForm6.SpeedButton3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  form6.Label6.Caption:='';

if (form6.Edit1.Text<>'') and (form6.TreeView1.Selected.Text<>'<Блоки:') then
 begin
  form6.Label6.Caption:='Изменить:'+#13+
  form6.TreeView1.Selected.Text+#13+
  'на'+#13+form6.Edit1.Text;
 end;
end;

procedure TForm6.SpeedButton4MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  form6.Label6.Caption:='';
end;

function FindCurrentNode(Index:integer; tView:TTreeView):integer;
var tNode:TTreeNode;
    i,Cur:integer;
begin
   Result:=0;
   for i:=0 to tView.Items.Count-1 do
     begin
       Cur:=Integer(tView.Items.Item[i].Data);
       if Cur=Index then
          begin
           tNode:=tView.Items.Item[i];
           tView.Select(tNode, [ssLeft]);
           Result:=i;
           Exit;
          end;
     end;
end;

procedure TForm6.CheckBox1Click(Sender: TObject);
begin
  if form6.CheckBox1.Checked then
    begin
      form6.SpeedButton1.Enabled := True;
      form6.SpeedButton2.Enabled := True;
      form6.SpeedButton3.Enabled := True;
    end
    else
    begin
      form6.SpeedButton1.Enabled := False;
      form6.SpeedButton2.Enabled := False;
      form6.SpeedButton3.Enabled := False;
    end;
end;

end.
