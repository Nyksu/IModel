unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, Mask, Grids, DBGrids, ExtCtrls, Buttons, DBClient;

type
  TGrf = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Panel3: TPanel;
    SpeedButton3: TSpeedButton;
    Edit2: TEdit;
    SpeedButton4: TSpeedButton;
    CheckBox1: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Grf: TGrf;
  get_gr_id,get_gr_name:string;
  editGrName:boolean;
  
procedure Grid;
function AddRoleGroup(tab:integer):boolean;
function DeleteRoleGroup(tab:integer):boolean;

implementation
          uses unit1, Unit3, unit6, DMmodel, DB, Unit8;
{$R *.dfm}

procedure TGrf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.Enabled := True;
  but_number := 0;
  Grf.Edit1.Enabled := True;
  Grf.CheckBox1.Enabled := True;
  Grf.SpeedButton1.Enabled := False;
  Grf.SpeedButton2.Enabled := False;
end;

procedure TGrf.SpeedButton3Click(Sender: TObject);
begin
  Grf.Close;
  Grf.SpeedButton2.Enabled := True;
  Grf.Edit1.Visible := True;
  Grf.Edit2.Visible := True;
  Grf.SpeedButton4.Visible := True;
  Grf.Edit1.Clear;
  Grf.Edit2.Clear;
  Grf.CheckBox1.Checked := False;
end;

procedure TGrf.SpeedButton1Click(Sender: TObject);
var Res, Params: Variant;
    op_id: Integer;
begin
  if but_number = 1 then
    begin
      if (Conn) and (Grf.Edit1.Text <> '') then
        if Grf.Edit1.Text <> '' then
          begin
            AddRoleGroup(1);
            Grf.Edit1.Clear;
          end;
    end
    else
    if but_number = 2 then
      begin
        if (Conn) and (Grf.DBGrid1.DataSource.DataSet.RecordCount > 0) then
          begin
            try
              Grid;
        DM.StartTrans;
        Params := VarArrayCreate([0,1], varVariant);
        Params[0] := VarArrayOf(['grid_id', 'get_gr_id']);
        Params[1] := VarArrayOf([StrToInt(grid_id), StrToInt(get_gr_id)]);
        Res := DM.RunSQL('Pav278', Params);
        if Res <> 0 then
          begin
            DM.BackTrans;
            MessageDlg('SQL уже состоит в этой группе!',mtError,[mbOk],0);
          end
          else
          begin
            DM.CommTrans;
            form1.CheckListBox1.Items.Add(get_gr_name);
            form1.CheckListBox1.Checked[form1.CheckListBox1.Count-1] := False;
            Groups;
          end;

            except
              DM.CommTrans;
              MessageDlg('SQL уже состоит в этой группе!',mtError,[mbOk],0);
            end;
      end;
    end
    else
    if but_number = 3 then
      begin
        if (Conn) then
        if Grf.Edit1.Text <> '' then
          begin
            AddRoleGroup(0);
            Grf.Edit1.Clear;
          end;
      end
      else
  if but_number = 4 then
    begin
      if (Conn) and (Grf.DBGrid1.DataSource.DataSet.RecordCount > 0) then
        begin
          try
            Grid;
            DM.StartTrans;
        Params := VarArrayCreate([0,1], varVariant);
        Params[0] := VarArrayOf(['CurUserID', 'get_gr_id']);
        Params[1] := VarArrayOf([CurUserID, StrToInt(get_gr_id)]);
        Res := DM.RunSQL('Pav279', Params);
        if Res <> 0 then
          begin
            DM.BackTrans;
            MessageDlg('Пользователь уже состоит в этой группе!',mtError,[mbOk],0);
          end
          else
          begin
            DM.CommTrans;
            Usf.CheckListBox1.Items.Add(get_gr_name);
            Usf.CheckListBox1.Checked[Usf.CheckListBox1.Count-1] := False;
          end;
          except
            MessageDlg('Пользователь уже состоит в этой группе!',mtError,[mbOk],0);
          end;
        end;
    end
    else
  if but_number = 5 then
    begin
      if (Conn) and (Grf.DBGrid1.DataSource.DataSet.RecordCount > 0) then
        begin
          try
            Grid;
            DM.StartTrans;
            Op_id := form1.CDSOperations.FieldByName('id').AsInteger;
        Params := VarArrayCreate([0,1], varVariant);
        Params[0] := VarArrayOf(['OPID', 'GID']);
        Params[1] := VarArrayOf([Op_id, StrToInt(get_gr_id)]);
        Res := DM.RunSQL('Pavel781', Params);
        if Res <> 0 then
          begin
            DM.BackTrans;
            MessageDlg('Операция уже состоит в этой группе!',mtError,[mbOk],0);
          end
          else
          begin
            DM.CommTrans;
            Opf.CheckListBox1.Items.Add(get_gr_name);
            Opf.CheckListBox1.Checked[Opf.CheckListBox1.Count-1] := False;
          end;
          except
            MessageDlg('Операция уже состоит в этой группе!',mtError,[mbOk],0);
          end;
        end;
    end;
  Grf.CheckBox1.Checked := False;
end;

procedure TGrf.SpeedButton2Click(Sender: TObject);
begin
  if (Conn) and
     (Grf.DBGrid1.DataSource.DataSet.RecordCount > 0) then
    begin
      if Grf.Caption <> 'Группы' then
        begin
          DeleteRoleGroup(0);
          Grf.Edit1.Clear;
          Grf.Edit2.Clear;
          Rules;
        end
        else
        begin
          DeleteRoleGroup(1);
          Grf.Edit1.Clear;
          Grf.Edit2.Clear;
        end;
     end;
Grf.CheckBox1.Checked := False;
end;

procedure TGrf.FormShow(Sender: TObject);
begin
  if but_number = 2 then Grf.Edit1.Enabled := False;
  form1.Enabled := False;
  editGrName := False;
  Grf.SpeedButton4.Enabled := False;
end;

procedure Grid;
begin
  get_gr_id := Grf.DBGrid1.DataSource.DataSet.FieldByName('id').AsString;
  get_gr_name := Grf.DBGrid1.DataSource.DataSet.FieldByName('name').AsString;
  Grf.Edit2.Text := get_gr_name;
  Grf.SpeedButton4.Enabled := False;
end;

procedure TGrf.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Conn then Grid;
end;

procedure TGrf.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Conn then Grid;
end;

procedure TGrf.SpeedButton4Click(Sender: TObject);
var SaveGridID: string;
    Res, Params: Variant;
begin
 SaveGridID := get_gr_id;
 if Grf.Edit2.Text <> '' then
   if editGrName = True then
     begin
      if (Conn) then
       if but_number <> 3 then
        begin
         try
           Params := VarArrayCreate([0,1], varVariant);
           Params[0] := VarArrayOf(['EDIT_TEXT', 'SaveGridID']);
           Params[1] := VarArrayOf([Grf.Edit2.Text, SaveGridID]);
           Res := DM.RunSQL('Pav285', Params);
           if Res <> 0 then
          begin
            DM.BackTrans;
            MessageDlg('Ошибка!', mtError, [mbOk],0);
          end
          else
          begin
            DM.CommTrans;
          end;
          ActiveGroup(form1.CDSGroups);
          form1.CDSGroups.Locate('ID', SaveGridID, [loCaseInsensitive]);
          Grf.Edit1.Clear;
          Rules;
          Groups;
         except
           MessageDlg('Ошибка!', mtError, [mbOk],0);
         end;
        end
        else
        begin
         try
           Params := VarArrayCreate([0,1], varVariant);
           Params[0] := VarArrayOf(['EDIT_TEXT', 'SaveGridID']);
           Params[1] := VarArrayOf([Grf.Edit2.Text, SaveGridID]);
           Res := DM.RunSQL('Pav286', Params);
           if Res <> 0 then
          begin
            DM.BackTrans;
            MessageDlg('Ошибка!', mtError, [mbOk],0);
          end
          else
          begin
            DM.CommTrans;
          end;
            ActiveRole(form1.CDSRoles);
          form1.CDSRoles.Locate('ID', SaveGridID, [loCaseInsensitive]);
          Grf.Edit1.Clear;
         except
           MessageDlg('Ошибка!', mtError, [mbOk],0);
         end;
        end;

   end;
  Grf.SpeedButton4.Enabled := False;
end;

procedure TGrf.Edit2Change(Sender: TObject);
begin
  editGrName := True;
  if (Grf.Edit2.Text <> '') and
     (Conn) then Grf.SpeedButton4.Enabled := True
            else Grf.SpeedButton4.Enabled := False;
end;

function AddRoleGroup(Tab: Integer): Boolean;
var Res, Params: Variant;
    CDS: TClientDataSet;
begin
     Result := False;

          if tab = 0 then
            begin
             try
        DM.StartTrans;
        Params := VarArrayCreate([0,1], varVariant);
        Params[0] := VarArrayOf(['NAME', 'STATE']);
        Params[1] := VarArrayOf([Grf.Edit1.Text, 3]);
        Res := DM.RunSQL('Pav282', Params);
        if Res <> 0 then
          begin
            DM.BackTrans;
            MessageDlg('Ошибка!', mtError, [mbOk],0);
          end
          else
          begin
            DM.CommTrans;
            Result := True;
          end;
          except
            MessageDlg('Ошибка!', mtError, [mbOk],0);
          end;
            end;

          if tab = 1 then
            begin
             Result := True;
             CDS := TClientDataSet.Create(nil);
             try

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
                  Params[0] := VarArrayOf(['IDPool', 'NAME', 'STATE', 'KN']);
                  Params[1] := VarArrayOf([IdPool, Grf.Edit1.Text, 3, form1.user_name.Text + IntToStr(IDPool)]);
                  Res := DM.RunSQL('Pav281', Params);
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
           end;


if Result then
 if tab = 0 then
  begin
   ActiveRole(form1.CDSRoles);
   //form1.Query8.Locate('ID', IDPool, [loCaseInsensitive]);
  end
  else
  if tab = 1 then
   begin
   ActiveGroup(form1.CDSGroups);
   //form1.CDSGroups.Locate('ID', IDPool, [loCaseInsensitive]);
   form1.StatusBar1.Panels[2].Text := 'Groups Count: ' + IntToStr(form1.CDSGroups.RecordCount);
   end;
end;

function DeleteRoleGroup(tab:integer):boolean;
var Res, Params: Variant;
begin
 Result := False;
    try

               Params := VarArrayCreate([0,1], varVariant);
               Params[0] := VarArrayOf(['ID', 'STATE']);
               Params[1] := VarArrayOf([Grf.DBGrid1.DataSource.DataSet.FieldByName('ID').AsInteger, -1]);


          if tab = 0 then
            begin
              Res := DM.RunSQL('Pav283', Params);
            end;

          if tab = 1 then
            begin
              Res := DM.RunSQL('Pav284', Params);
            end;
          if Res <> 0 then
          begin
            DM.BackTrans;
            MessageDlg('Ошибка!', mtError, [mbOk],0);
          end
          else
          begin
            DM.CommTrans;
            Result := True;
          end;
           

    except
       MessageDlg('Ошибка!', mtError, [mbOk],0);
    end;


if Result then
 begin
   Grf.Edit1.Clear;
   Grf.Edit2.Clear;
 if tab = 0 then
  begin
    ActiveRole(form1.CDSRoles);
  end;

  if tab = 1 then
   begin
    ActiveGroup(form1.CDSGroups);
    form1.StatusBar1.Panels[2].Text := 'Groups Count: ' + IntToStr(form1.CDSGroups.RecordCount);
   end;
 end;
end;

procedure TGrf.CheckBox1Click(Sender: TObject);
begin
 if Grf.CheckBox1.Checked then
    begin
      Grf.SpeedButton1.Enabled := True;
      Grf.SpeedButton2.Enabled := True;
    end
    else
    begin
      Grf.SpeedButton1.Enabled := False;
      Grf.SpeedButton2.Enabled := False;
    end;
end;

end.
