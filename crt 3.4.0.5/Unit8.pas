unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, Mask, Buttons, DBClient,
  CheckLst;

type
  TOpf = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    Panel3: TPanel;
    SpeedButton4: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label6: TLabel;
    SpeedButton5: TSpeedButton;
    CheckBox1: TCheckBox;
    RPanel: TPanel;
    GroupBox3: TGroupBox;
    CheckListBox1: TCheckListBox;
    Panel15: TPanel;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Splitter1: TSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton5Click(Sender: TObject);
    procedure GroupBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure CheckListBox1Enter(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Opf: TOpf;
  procedure ClearOperationEdit;
  procedure OperationAction;
  function AddOperation(CDS: TClientDataSet): Boolean;
  function DeleteOperation: Boolean;
  function ChangeOperation: Boolean;

implementation
 uses unit1, Unit6, DMmodel, DB;
{$R *.dfm}

procedure TOpf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.Enabled := True;
end;

procedure TOpf.SpeedButton4Click(Sender: TObject);
begin
  Opf.Close;
  Opf.CheckBox1.Checked := False;
end;

function AddOperation(CDS: TClientDataSet): Boolean;
var Res, Params: Variant;
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
           Params[0] := VarArrayOf(['IDPool', 'NAME', 'COMMENT', 'STATE', 'ROLES_ID', 'KN']);
           Params[1] := VarArrayOf([IdPool, Opf.Edit1.Text,
                                Opf.Edit2.Text,
                                3, Opf.DBLookupComboBox1.KeyValue,
                                form1.user_name.Text + IntToStr(IDPool)]);
             Res := DM.RunSQL('Pav267', Params);
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
   ActiveOperation(form1.CDSOperations);
   form1.CDSOperations.Locate('ID', IDPool, [loCaseInsensitive]);
   OperationAction;
  end;
end;

function DeleteOperation: Boolean;
var OperID: Integer;
    Res, Params: Variant;
begin
  OperID := form1.CDSOperations.FieldByName('ID').AsInteger;
  try
    DM.StartTrans;
    Params := VarArrayCreate([0,1], varVariant);
    Params[0] := VarArrayOf(['ID', 'STATE']);
    Params[1] := VarArrayOf([OperID, -1]);
    Res := DM.RunSQL('Pav269', Params);
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
      ClearOperationEdit;
      ActiveOperation(form1.CDSOperations);
    end;
end;

function ChangeOperation: Boolean;
var MemID: Integer;
    Res, Params: Variant;
begin
  Result := True;
    try
      DM.StartTrans;
      MemID := Opf.DBGrid1.DataSource.DataSet.FieldByName('ID').AsInteger;
      Params := VarArrayCreate([0,1], varVariant);
      Params[0] := VarArrayOf(['ID', 'NAME', 'COMMENT', 'STATE', 'ROLES_ID']);
      Params[1] := VarArrayOf([MemID, Opf.Edit1.Text,
                                Opf.Edit2.Text,
                                2, Opf.DBLookupComboBox1.KeyValue]);
      Res := DM.RunSQL('Pav268', Params);
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
      ActiveOperation(form1.CDSOperations);
      form1.CDSOperations.Locate('ID', MemID, [loCaseInsensitive]);
      OperationAction;
    end;

end;

procedure ClearOperationEdit;
begin
  Opf.Edit1.Clear;
  Opf.Edit2.Clear;
  Opf.Edit3.Clear;
  Opf.DBLookupComboBox1.KeyValue := 0;
end;

procedure OperationAction;
begin
  if form1.CDSOperations.RecordCount > 0 then
    begin
      Opf.DBLookupComboBox1.KeyValue := form1.CDSOperations.FieldByName('ROLES_ID').AsInteger;
      Opf.Edit1.Text := form1.CDSOperations.FieldByName('NAME').AsString;
      Opf.Edit2.Text := form1.CDSOperations.FieldByName('COMMENT').AsString;
      Opf.Edit3.Text := IntToStr(form1.CDSOperations.FieldByName('STATE').AsInteger);
      RoleName := Opf.DBLookupComboBox1.Text;
    end;
end;

procedure TOpf.SpeedButton1Click(Sender: TObject);
begin
  if (Opf.Edit1.Text <> '') and
     (Opf.Edit2.Text <> '') and
     (Opf.DBLookupComboBox1.KeyValue <> 0) then
    begin
      AddOperation(DM.cds_work);
    end;
  Opf.CheckBox1.Checked := False;      
end;

procedure TOpf.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Opf.DBGrid1.FieldCount > 0 then
    begin
      OperationAction;
      form1.RulesOp;
    end;
end;

procedure TOpf.CheckListBox1ClickCheck(Sender: TObject);
var Op_id: Integer;
begin
  Op_id := form1.CDSOperations.FieldByName('id').AsInteger;
  ChangeCheckOp(DM.cds_work, Opf.CheckListBox1, Op_id);
end;

procedure TOpf.CheckListBox1Enter(Sender: TObject);
begin
  if Opf.CheckListBox1.Count > 0 then Opf.CheckListBox1.Selected[0] := True;
end;

procedure TOpf.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Opf.DBGrid1.FieldCount > 0 then
    begin
      OperationAction;
      form1.RulesOp;
    end;
end;

procedure TOpf.SpeedButton3Click(Sender: TObject);
begin
  if (form1.CDSOperations.RecordCount > 0) then
    begin
      ChangeOperation;
    end;
  Opf.CheckBox1.Checked := False;
end;

procedure TOpf.SpeedButton2Click(Sender: TObject);
begin
  if (form1.CDSOperations.RecordCount > 0) then
    begin
      DeleteOperation;
    end;
  Opf.CheckBox1.Checked := False;
end;

procedure TOpf.SpeedButton1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Opf.Label6.Caption := '';
  if (Opf.Edit1.Text <> '') and
     (Opf.Edit2.Text <> '') and
     (Opf.DBLookupComboBox1.KeyValue <> 0) then
    begin
      Opf.Label6.Caption := 'Добавить:' + #13 +
      Opf.Edit1.Text;
    end;
end;

procedure TOpf.SpeedButton3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Opf.Label6.Caption := '';
  if (Opf.Edit1.Text <> '') and
     (Opf.Edit2.Text <> '') and
     (form1.CDSOperations.RecordCount > 0) and
     (Opf.DBLookupComboBox1.KeyValue <> 0) then
    begin
      Opf.Label6.Caption := 'Изменить:' + #13 +
      form1.CDSOperations.FieldByName('NAME').AsString + ' на ' + Opf.Edit1.Text + #13 +
      form1.CDSOperations.FieldByName('COMMENT').AsString + ' на ' + Opf.Edit2.Text + #13 +
      RoleName + ' на ' + Opf.DBLookupComboBox1.Text;
    end;
end;

procedure TOpf.SpeedButton2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Opf.Label6.Caption := '';
  if (form1.CDSOperations.RecordCount > 0) then
    begin
      Opf.Label6.Caption:='Удалить:' + #13 +
      Opf.Edit1.Text;
    end;
end;

procedure TOpf.SpeedButton5Click(Sender: TObject);
begin
  ClearOperationEdit;
end;

procedure TOpf.SpeedButton6Click(Sender: TObject);
begin
  AddGroupClick(5);
end;

procedure TOpf.SpeedButton7Click(Sender: TObject);
var Res, Params: Variant;
    op_id: Integer;
begin
  if (Opf.CheckListBox1.Count > 0) then
    begin
       try
        DM.StartTrans;
        Op_id := form1.CDSOperations.FieldByName('id').AsInteger;
        Params := VarArrayCreate([0,1], varVariant);
        Params[0] := VarArrayOf(['grid_id', 'ITEM_TEXT']);
        Params[1] := VarArrayOf([Op_id, Opf.CheckListBox1.Items.Strings[Opf.CheckListBox1.ItemIndex]]);
        Res := DM.RunSQL('Pavel783', Params);
        if Res <> 0 then
          begin
            DM.BackTrans;
          end
          else
          begin
            DM.CommTrans;
            Opf.CheckListBox1.DeleteSelected;
            form1.RulesOp;
          end;
       except
       end;
    end;
end;

procedure TOpf.GroupBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Opf.Label6.Caption := '';
end;

procedure TOpf.DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Opf.Label6.Caption := '';
end;

procedure TOpf.SpeedButton4MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Opf.Label6.Caption := '';
end;

procedure TOpf.CheckBox1Click(Sender: TObject);
begin
  if Opf.CheckBox1.Checked then
    begin
      Opf.SpeedButton1.Enabled := True;
      Opf.SpeedButton2.Enabled := True;
      Opf.SpeedButton3.Enabled := True;
    end
    else
    begin
      Opf.SpeedButton1.Enabled := False;
      Opf.SpeedButton2.Enabled := False;
      Opf.SpeedButton3.Enabled := False;
    end;
end;

end.
