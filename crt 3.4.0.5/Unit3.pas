unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Grids, DBGrids, ExtCtrls, Mask, DBCtrls, DBClient,
  CheckLst, DB;

type
  TUsf = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Panel4: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    Label5: TLabel;
    SpeedButton5: TSpeedButton;
    GroupBox2: TGroupBox;
    CheckListBox1: TCheckListBox;
    Panel5: TPanel;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    CheckBox1: TCheckBox;
    SpeedButton10: TSpeedButton;
    procedure Edit3Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure CheckListBox1Enter(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Usf: TUsf;

  function AddUser: Boolean;
  function DeleteUser: Boolean;
  function ChangeUser: Boolean;
  procedure UserAction;
  procedure ClearUserEdit;
  procedure Groups;
  function ChangePasswordUser: Boolean;

implementation
      uses unit1, Unit6, UnxCrypt, DMmodel;
{$R *.dfm}

procedure TUsf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.Enabled := True;
end;

function AddUser: Boolean;
var Res, Params: Variant;
begin
  Result := True;
  try
    DM.StartTrans;
    Params := VarArrayCreate([0,1], varVariant);
    Params[0] := VarArrayOf(['NAME', 'NIKNAME', 'PSW', 'COMMENT', 'STATE', 'ROLES_ID']);
    Params[1] := VarArrayOf([Usf.Edit1.Text, Usf.Edit2.Text,
                             CreateInterbasePassword(Usf.Edit3.Text),
                             Usf.Edit4.Text, 3,
                             Usf.DBLookupComboBox1.KeyValue]);
    Res := DM.RunSQL('Pav272', Params);
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
      ActiveUser(form1.CDSUsers);
      UserAction;
    end;
end;

function DeleteUser: Boolean;
var Res, Params: Variant;
begin
  Result := True;
  try
    DM.StartTrans;
    Params := VarArrayCreate([0,1], varVariant);
    Params[0] := VarArrayOf(['STATE', 'ID']);
    Params[1] := VarArrayOf([-1, CurUserID]);
    Res := DM.RunSQL('Pav274', Params);
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
      ClearUserEdit;
      ActiveUser(form1.CDSUsers);
    end;
end;

function ChangeUser: Boolean;
var SaveUserID: Integer;
    Res, Params: Variant;
begin
  Result := True;
  try
    SaveUserID := CurUserID;
    DM.StartTrans;
    Params := VarArrayCreate([0,1], varVariant);
    Params[0] := VarArrayOf(['NAME', 'NIKNAME', 'COMMENT', 'STATE', 'ROLES_ID', 'ID']);
    Params[1] := VarArrayOf([Usf.Edit1.Text, Usf.Edit2.Text,
                             {CreateInterbasePassword(Usf.Edit3.Text)}
                             Usf.Edit4.Text, 3,
                             Usf.DBLookupComboBox1.KeyValue,
                             CurUserID]);
    Res := Dm.RunSQL('Pav273', Params);
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
      ActiveUser(form1.CDSUsers);
      form1.CDSUsers.Locate('ID', SaveUserID, [loCaseInsensitive]);
      UserAction;
    end;
end;

function ChangePasswordUser: Boolean;
var SaveUserID: Integer;
    Res, Params: Variant;
begin
  Result := True;
  try
    SaveUserID := CurUserID;
    DM.StartTrans;
    Params := VarArrayCreate([0,1], varVariant);
    Params[0] := VarArrayOf(['PSW', 'ID']);
    Params[1] := VarArrayOf([CreateInterbasePassword(Usf.Edit3.Text), CurUserID]);
    Res := Dm.RunSQL('Pav287', Params);
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
      ActiveUser(form1.CDSUsers);
      form1.CDSUsers.Locate('ID', SaveUserID, [loCaseInsensitive]);
      UserAction;
    end;
end;

procedure UserAction;
begin
  if form1.CDSUsers.RecordCount > 0 then
    begin
      CurUserID := form1.CDSUsers.FieldByName('ID').AsInteger;
      Usf.Edit1.Text := form1.CDSUsers.FieldByName('NAME').AsString;
      Usf.Edit2.Text := form1.CDSUsers.FieldByName('NIKNAME').AsString;
      Usf.Edit3.Text := form1.CDSUsers.FieldByName('PSW').AsString;
      Usf.Edit4.Text := form1.CDSUsers.FieldByName('COMMENT').AsString;
      Usf.DBLookupComboBox1.KeyValue := form1.CDSUsers.FieldByName('ROLES_ID').AsInteger;
    end;
end;

procedure ClearUserEdit;
begin
  Usf.Edit1.Clear;
  Usf.Edit2.Clear;
  Usf.Edit3.Clear;
  Usf.Edit4.Clear;
  Usf.DBLookupComboBox1.KeyValue:=0;
  Usf.CheckListBox1.Clear;
end;

procedure TUsf.SpeedButton10Click(Sender: TObject);
begin
  if ChangePasswordUser then MessageDlg('Пароль успешно изменен.', mtInformation, [mbOk], 0)
                        else MessageDlg('Ошибка при изменении пароля!', mtError, [mbOk], 0)
end;

procedure TUsf.SpeedButton1Click(Sender: TObject);
begin
  if (Usf.Edit1.Text <> '') and
     (Usf.Edit2.Text <> '') and
     (Usf.Edit3.Text <> '') and
     (Usf.Edit4.Text <> '') and
     (Usf.DBLookupComboBox1.KeyValue <> 0) then
    begin
      AddUser;
    end;
  Usf.CheckBox1.Checked := False;
end;

procedure TUsf.SpeedButton4Click(Sender: TObject);
begin
  Usf.Close;
  Usf.CheckBox1.Checked := False;
end;

procedure TUsf.SpeedButton5Click(Sender: TObject);
begin
  ClearUserEdit;
end;

procedure TUsf.DBGrid1CellClick(Column: TColumn);
begin
  UserAction;
end;

procedure Groups;
begin
  Usf.CheckListBox1.Clear;
  if form1.CDSUsers.RecordCount > 0 then
    begin
      InsertChe(DM.cds_work, Usf.CheckListBox1, Usf.DBGrid1.DataSource.DataSet.FieldByName('id').AsInteger, 1);
      if Usf.CheckListBox1.Count > 0 then Usf.CheckListBox1.Selected[0] := True;
    end
    else
      Usf.CheckListBox1.Clear;
end;

procedure TUsf.CheckListBox1Enter(Sender: TObject);
begin
  if Usf.CheckListBox1.Count > 0 then Usf.CheckListBox1.Selected[0] := True;
end;

procedure TUsf.CheckListBox1ClickCheck(Sender: TObject);
var tCheck: string;
    Sta: Integer;
    Res, Params: Variant;
begin
  tCheck := Usf.CheckListBox1.Items.Strings[Usf.CheckListBox1.ItemIndex];
  if Usf.CheckListBox1.Checked[Usf.CheckListBox1.ItemIndex] then Sta := 1
                                                            else Sta := 0;
  try
    Params:= VarArrayCreate([0, 1], varVariant);
    Params[0] := VarArrayOf(['Sta','UserID','tCheck']);
    Params[1] := VarArrayOf([Sta, CurUserID, tCheck]);
    DM.StartTrans;
    Res := DM.RunSQL('Pav276', Params);
    if Res <> 0 then
      begin
        DM.BackTrans;
        Exit;
      end;
    DM.CommTrans;
   except
     MessageBox(form1.Handle,'[Update] Изменить статус не представляется возможным','Ошибка', mb_ok);
   end;
end;

procedure TUsf.SpeedButton6Click(Sender: TObject);
begin
  AddGroupClick(4);
end;

procedure TUsf.SpeedButton7Click(Sender: TObject);
var Res, Params: Variant;
begin
  if (Conn) and
     (Usf.CheckListBox1.Count > 0) then
    begin
      try
        DM.StartTrans;
        Params := VarArrayCreate([0,1], varVariant);
        Params[0] := VarArrayOf(['CurUserID', 'ITEM_TEXT']);
        Params[1] := VarArrayOf([CurUserID, Usf.CheckListBox1.Items.Strings[Usf.CheckListBox1.ItemIndex]]);
        Res := DM.RunSQL('Pav275', Params);
        if Res <> 0 then
          begin
            DM.BackTrans;
          end
          else
          begin
            DM.CommTrans;
            Usf.CheckListBox1.DeleteSelected;
            Groups;
          end;

      except
      end;
    end;
end;

procedure TUsf.SpeedButton3Click(Sender: TObject);
begin
  if (form1.CDSUsers.RecordCount > 0) then
    begin
      ChangeUser;
    end;
  Usf.CheckBox1.Checked := False;
end;

procedure TUsf.SpeedButton2Click(Sender: TObject);
begin
  if (form1.CDSRoles.RecordCount > 0) then
    begin
      DeleteUser;
    end;
  Usf.CheckBox1.Checked := False;
end;

procedure TUsf.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 UserAction;
 if form1.CDSUsers.RecordCount > 0 then Groups;
end;

procedure TUsf.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  UserAction;
  if form1.CDSUsers.RecordCount > 0 then Groups;
end;

procedure TUsf.Edit3Click(Sender: TObject);
begin
  Usf.Edit3.SelectAll;
end;

procedure TUsf.CheckBox1Click(Sender: TObject);
begin
  if Usf.CheckBox1.Checked then
    begin
      Usf.SpeedButton1.Enabled := True;
      Usf.SpeedButton2.Enabled := True;
      Usf.SpeedButton3.Enabled := True;
    end
    else
    begin
      Usf.SpeedButton1.Enabled := False;
      Usf.SpeedButton2.Enabled := False;
      Usf.SpeedButton3.Enabled := False;
    end;
end;

end.
