unit Unit1;

interface     

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, Menus, ComCtrls,
  Buttons, DB, DBClient, CheckLst, ToolWin, Mask,
  ImgList, ValEdit, AppEvnts, DBCtrls, DBTables, Provider, StrUtils;

type
  TNewStringGrid = class(TStringGrid)

    FEditList: TInplaceEditList;

  private
    FOnEditButtonClick: TNotifyEvent;
  protected
    function CreateEditor: TInplaceEdit; override;
    function GetEditStyle(ACol, ARow: Longint): TEditStyle; override;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure DoExit;
    procedure EditListGetItems(ACol, ARow: Integer; Items: TStrings);
    procedure EditButtonClick(Sender: TObject);
    function GetEditText(ACol, ARow: Longint): string; override;
  end;


type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Exit1: TMenuItem;
    cds_txt: TClientDataSet;
    Query1: TQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Splitter1: TSplitter;
    Panel1: TPanel;
    TreeView1: TTreeView;
    Panel2: TPanel;
    Panel3: TPanel;
    Query2: TQuery;
    DataSource1: TDataSource;
    ToolBar1: TToolBar;
    ToolButton4: TToolButton;
    DataSource2: TDataSource;
    StatusBar1: TStatusBar;
    DSViewUser: TDataSource;
    QViewUser: TQuery;
    Query5: TQuery;
    DataSource4: TDataSource;
    Panel6: TPanel;
    Splitter2: TSplitter;
    Panel7: TPanel;
    GroupBox1: TGroupBox;
    CheckListBox1: TCheckListBox;
    Panel5: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    GroupBox2: TGroupBox;
    DBLookupComboBox1: TDBLookupComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    qEx: TQuery;
    dsEx: TDataSource;
    panEx: TPanel;
    DBGrid2: TDBGrid;
    Splitter3: TSplitter;
    ed_sql_txt: TMemo;
    panBtEx: TPanel;
    Session1: TSession;
    ToolButton1: TToolButton;
    ImList: TImageList;
    panEnv: TPanel;
    SpeedButton12: TSpeedButton;
    Memo1: TMemo;
    SpeedButton13: TSpeedButton;
    Query6: TQuery;
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    Update1: TMenuItem;
    Send1: TMenuItem;
    Receive1: TMenuItem;
    q_last: TQuery;
    ds_last: TDataSource;
    pop_tree: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Query8: TQuery;
    ToolButton6: TToolButton;
    Query9: TQuery;
    DataSetProvider4: TDataSetProvider;
    ClientDataSet3: TClientDataSet;
    DataSource6: TDataSource;
    Query10: TQuery;
    ClientDataSet4: TClientDataSet;
    ClientDataSet5: TClientDataSet;
    DataSetProvider5: TDataSetProvider;
    Query11: TQuery;
    ApplicationEvents: TApplicationEvents;
    Memo2: TMemo;
    ToolButton8: TToolButton;
    QViewOperation: TQuery;
    DSViewOperation: TDataSource;
    QBlock: TQuery;
    QUser: TQuery;
    QViewRole: TQuery;
    DSViewRole: TDataSource;
    Edit2: TEdit;
    QCode: TQuery;
    Edit3: TEdit;
    QStack: TQuery;
    Edit4: TEdit;
    Label5: TLabel;
    QSQL: TQuery;
    DSSQL: TDataSource;
    Label7: TLabel;
    QOperation: TQuery;
    QGetGroup: TQuery;
    QRoleGroup: TQuery;
    QWhatBase: TQuery;
    QUpdate: TQuery;
    QValid: TQuery;
    CheckViewDel: TCheckBox;
    Pool1: TMenuItem;
    GetPool1: TMenuItem;
    SetPool1: TMenuItem;
    Panel12: TPanel;
    QPoolOperation: TQuery;
    Panel13: TPanel;
    SpeedButton18: TSpeedButton;
    PoolMask: TMaskEdit;
    SpeedButton19: TSpeedButton;
    Panel14: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    DSFindKN: TDataSource;
    QFindKN: TQuery;
    CDSSQLCode: TClientDataSet;
    DSSQLCode: TDataSource;
    CDSRules: TClientDataSet;
    CDSRoles: TClientDataSet;
    DSRoles: TDataSource;
    CDSGroups: TClientDataSet;
    DSGroups: TDataSource;
    CDSUsers: TClientDataSet;
    DSUsers: TDataSource;
    Panel16: TPanel;
    DBGrid1: TDBGrid;
    Panel8: TPanel;
    Panel9: TPanel;
    SpeedButton17: TSpeedButton;
    Edit1: TEdit;
    Panel11: TPanel;
    Label10: TLabel;
    SpeedButton20: TSpeedButton;
    Panel10: TPanel;
    Panel17: TPanel;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    CheckBox1: TCheckBox;
    FindEdit: TEdit;
    Memo3: TMemo;
    CDSOperations: TClientDataSet;
    DSOperations: TDataSource;
    CDSExplorer: TClientDataSet;
    DSExplorer: TDataSource;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    lab_flag: TLabel;
    user_name: TMaskEdit;
    user_pass: TMaskEdit;
    Panel18: TPanel;
    GroupBox4: TGroupBox;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton7: TSpeedButton;
    GroupBox3: TGroupBox;
    rbSQL: TRadioButton;
    rbDML: TRadioButton;
    CDSUpdate: TClientDataSet;
    CDSLoadUpdate: TClientDataSet;
    Timer2: TTimer;
    CDSOpRules: TClientDataSet;
    ToolButton2: TToolButton;
    procedure user_passKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton6Click(Sender: TObject);
    procedure DSSQLCodeDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure TreeView1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Exit1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure CheckListBox1Enter(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure ed_sql_txtChange(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure valEnvSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SpeedButton13Click(Sender: TObject);
    procedure Send1Click(Sender: TObject);
    procedure Receive1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ClientDataSet2AfterPost(DataSet: TDataSet);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure Tool3Click(Sender: TObject);
    procedure ClientDataSet2AfterInsert(DataSet: TDataSet);
    procedure ClientDataSet2AfterEdit(DataSet: TDataSet);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure user_nameKeyPress(Sender: TObject; var Key: Char);
    procedure ClientDataSet1AfterInsert(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure TabSheet2Show(Sender: TObject);
    procedure DSViewUserDataChange(Sender: TObject; Field: TField);
    procedure TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton14MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure SpeedButton16MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Panel11MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Memo3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TreeView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton15MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckViewDelClick(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure SetPool1Click(Sender: TObject);
    procedure GetPool1Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure SpeedButton20Click(Sender: TObject);
    procedure FindEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
    function Connect: Integer;
    function Disconnect: Integer;
    function GetExeInfo(Vers: Boolean): string;
    procedure RulesOp;
  end;

type  TEnv = record
         name:string;
         start:integer;
         length:integer;
         value:string;
         dtype:string;
      end;



var
  Form1: TForm1;

  mGr:TNewStringGrid;
  item,grid_id:string;
  item_index,level:integer;
  get_sql_list:TStrings;
  tabl:array[0..20,0..20] of integer;
  ind:array[0..50] of integer;
  ind_pos:integer;
  Node:TTreeNode;
  che_up: TCheckListBox;
  myNode:TTreeNode;
  but_number:integer;
  tabl_block_id:integer;
  pt:Pointer;
  ste:TStrings;
  exCon:boolean;
  mainCon:boolean;
  sqlCa:TStrings;
  indexCa:integer;
  editSQL:boolean;
  EnvSt:TStrings;
  XX,YY:integer;
  MyMemo:TMemo;
  BlobDown:boolean;
  BlobOne:boolean;
  tree_id:integer;
  KeyList:TSTringList;
  TypeList:TStringList;
  II:integer;
  Fill:boolean;

  CurUserID:integer;
  IDPool: Integer;
  RoleName:string;
  Central:boolean;
  PoolFile:string;
  PoolTable:TStringList;
  myPassword, myLogin: string;

  GlobalStatus: Boolean;
 
  
procedure InsertTree;
procedure InsertChe(CDS: TClientDataSet; Check: TCheckListBox; SQLID, Mode: Integer);
procedure GetSQL;
procedure Index;
procedure RefreshGrid(CDS: TClientDataSet; id, fl : integer );
procedure Rules;
procedure KeyPre;
function FillTree(Tree: TTreeView; CDS: TClientDataSet; idNode, idParent,
  cNodeName: string; Mode:boolean): Integer;
procedure AddSQLText(text:string; state:byte);
procedure GetSQLText(indka:integer; var text:string; var state:byte);
function GetEnvironList(BaseSql:string; delim: char):TStrings;
procedure AddValEnv;
function GetXLen(one:string):TEnv;
function RotateSQL(textsql:string):string;
procedure CreateMegaGrid;
procedure DoMemo;
procedure DoDateTime;
procedure DoTypeList;
function DeleteComment(sql,comen:variant):string;
function DeleteCommentAll(sql:variant):string;
function RunSQL(sqltext:string; oper:byte):boolean;
function TestEnvList:boolean;
function TinList(text:string):boolean;
procedure AfterModifTable(s:string; Quer:TQuery);
procedure ExportCo;
procedure ImportCo;
function SaveBackup(CDS: TClientDataSet; Q: TQuery; path, filedata: string; var RecordSum: Integer): Boolean;
function LoadBackup(CDS:TClientDataSet; CDSQ, CDSUp: TClientDataSet; path, filedata:string; var Vsego, UsedRecord:integer ):boolean;
procedure PrepareOutback(direc, filename:string);
function DateInFilename:string;
function GetTablename(s:string):string;
procedure RefreshAll;
procedure SQLCodeAction;
procedure ClearSQLCodeEdit;
function DeleteSQLCode(CDS: TClientDataSet; DeltaS: string): Boolean;
function AddSQLCode(CDS: TClientDataSet): Boolean;
function ChangeSQLCode(CDS: TClientDataSet): Boolean;
//function Prime(CDS: TClientDataSet; var Name: string): Integer;
function ValidNumber(fdname, finame:string; CDS: TClientDataSet; var DT:TDateTime; var UpdateNumber:integer):boolean;
procedure SetRegistryIcon;
procedure AddGroupClick(but:integer);
function GetPool(CDS: TClientDataSet): Integer;
function PutPool: Boolean;
procedure LoadPoolTable;
procedure SavePoolTable;
function UseOnePoolID:integer;

procedure FindCode(CDS: TClientDataSet; KN: string);
procedure ChangeCheck(CDS: TClientDataSet; CheckBox: TCheckListBox);
procedure ChangeCheckOp(CDS: TClientDataSet; CheckBox: TCheckListBox; ID: Integer);
procedure ActiveRole(CDS: TClientDataSet);
procedure ActiveGroup(CDS: TClientDataSet);
procedure ActiveUser(CDS: TClientDataSet);
procedure ActiveOperation(CDS: TClientDataSet);
procedure DoEnable;
procedure DoDisable;


implementation

uses Registry, unit2, unit3, unit4, unit5, unit6, unit8, DMmodel, unxcrypt, UpManagerUnit,
  Limit;

{$R *.dfm}

function TForm1.GetExeInfo(Vers: Boolean): string;
var
  loc_InfoBufSize : integer;
  loc_InfoBuf     : PChar;
  loc_VerBufSize  : integer;
  loc_VerBuf      : PChar;
  FLangID         :string;
  FExeName        :string;
begin
  Result := '';
  FExeName:=Application.ExeName;
  FLangID:='041904E3';
  loc_InfoBufSize := GetFileVersionInfoSize(PChar(FExeName),DWORD(loc_InfoBufSize));
  if loc_InfoBufSize > 0 then
  begin
    loc_InfoBuf := AllocMem(loc_InfoBufSize);
    GetFileVersionInfo(PChar(FExeName),0,loc_InfoBufSize,loc_InfoBuf);
    if Vers then
      begin
        VerQueryValue(loc_InfoBuf,PChar('StringFileInfo\'+FLangId+'\FileVersion'),Pointer(loc_VerBuf),DWORD(loc_VerBufSize));
        Result := loc_VerBuf;
      end
      else
      begin
        VerQueryValue(loc_InfoBuf,PChar('StringFileInfo\'+FLangId+'\ProductName'),Pointer(loc_VerBuf),DWORD(loc_VerBufSize));
        Result := loc_VerBuf;
      end;
     FreeMem(loc_InfoBuf, loc_InfoBufSize);
  end;
end;

function TForm1.Connect: Integer;
var si, i:integer;
    Name:string;
    Rs: Integer;
begin
  Result := -1;
  Name := '';
  myPassword := CreateInterbasePassword(form1.user_pass.Text);
  myLogin := form1.user_name.Text;
  if StartDM then
    begin
      Rs := DM.SockTo.AppServer.LogDB(myLogin, myPassword);
      if Rs = 0 then
        begin
          Conn := True;
          DoEnable;
          if (form1.user_name.Text<>'') then
            if (lab_flag.Color=clSilver)then
              begin
                try
                  if Prime(DM.cds_work, Name) = 1 then Central := True
                                                  else Central := False;
                  if Central then form1.MainMenu1.Items.Items[1].Enabled := True
                              else form1.MainMenu1.Items.Items[1].Enabled := False;

                  if not Central then
                    begin
                      LoadPoolTable;
                      form1.Panel14.Visible := True;
                      form1.Panel12.Visible := False;
                      try
                        for i := 0 to PoolTable.Count - 1 do
                          begin
                            form1.Label9.Caption := IntToStr(StrToInt(PoolTable.Strings[i]));
                          end;
                        form1.Label9.Caption := IntToStr(PoolTable.Count);
                      except
                        form1.Label9.Caption := '0';
                      end;
                    end;

                    if Name <> '' then form1.TabSheet2.Caption := form1.TabSheet2.Caption + ' - ' + Name;

                    //form1.StatusBar1.Panels[1].Text := 'Database2: ';
                    form1.StatusBar1.Panels[4].Text := 'Источник Пула: ' + 'БД';
                    form1.StatusBar1.Repaint;

                    ActiveRole(form1.CDSRoles);
                    ActiveGroup(form1.CDSGroups);
                    ActiveUser(form1.CDSUsers);
                    ActiveOperation(form1.CDSOperations);

                    form1.StatusBar1.Panels[2].Text := 'Групп: ' + IntToStr(form1.CDSGroups.RecordCount);

                    lab_flag.Color := clLime;

                    myNode := TTreeNode.Create(form1.TreeView1.Items);
                    Node := TTreeNode.Create(form1.TreeView1.Items);

                    GetSQL;

                    form1.StatusBar1.Panels[3].Text := 'Пользователей: ' + IntToStr(form1.CDSUsers.RecordCount);

                    Ste := TStringList.Create;

                    FillTree(TreeView1, DM.cds_work, 'id', 'hi_id', 'name', False);
                    if TreeView1.Items.Count > 1 then KeyPre;

                    form1.user_name.Enabled := False;
                    form1.user_pass.Enabled := False;
                    Application.ProcessMessages;
                    form1.StatusBar1.Repaint;

                    GlobalStatus := True;
                    form1.SpeedButton1.Caption := 'Отключить';

                    Timer2.Enabled := True;
                except on E:Exception do
                  begin
                    //form1.SpeedButton1.Down := False;
                    raise Exception.Create(E.Message);
                  end;
                end;
              end
              else
              begin
                  form1.TabSheet2.Caption := 'CODE';
                  form1.StatusBar1.Panels[1].Text := 'Database2: ';
                  treeview1.Items.Clear;
                  form1.CheckListBox1.Clear;
                  lab_flag.Color := clSilver;
                  form1.StatusBar1.Panels[2].Text := 'Groups Count: ' ;
                  form1.StatusBar1.Panels[3].Text := 'Users Count: ';
                  form1.Panel14.Visible := False;
                  form1.StatusBar1.Repaint;

                  form1.user_name.Enabled := True;
                  form1.user_pass.Enabled := True;
                  ClearSQLCodeEdit;
                  DoDisable;
              end;
        end;
    end
    else
    begin
      CloseDM;
    end;
end;

function TForm1.Disconnect: Integer;
begin
  Result := -1;
  CloseDM;

  form1.TabSheet2.Caption := 'SQL запросы';
  form1.StatusBar1.Panels[1].Text := 'Database2: ';
  treeview1.Items.Clear;
  form1.CheckListBox1.Clear;
  lab_flag.Color := clSilver;
  form1.StatusBar1.Panels[2].Text := 'Groups Count: ' ;
  form1.StatusBar1.Panels[3].Text := 'Users Count: ';
  form1.Panel14.Visible := False;
  form1.StatusBar1.Repaint;

  form1.user_name.Enabled := True;
  form1.user_pass.Enabled := True;
  ClearSQLCodeEdit;
  DoDisable;

  GlobalStatus := False;
  form1.SpeedButton1.Caption := 'Соединить';
  Timer2.Enabled := False;
end;

procedure InsertTree;
begin
    form1.Query1.Active:=true;
    form1.Query1.First;
    form1.TreeView1.Items.BeginUpdate;
while not form1.Query1.Eof do
  begin
    Node:=form1.TreeView1.Items.AddObject(nil,  form1.Query1.FieldByName('Name').AsString,
                                          Pointer(form1.Query1.FieldByName('ID').AsInteger));
    Node.HasChildren:=true;
    form1.Query1.Next;
  end;
   form1.TreeView1.Items.EndUpdate;
end;

procedure InsertChe(CDS: TClientDataSet; Check: TCheckListBox; SQLID, Mode: Integer);
var i: Integer;
    Res, Params: Variant;
begin

  try
    Check.Clear;
    CDS.Active := False;
    Params := VarArrayCreate([0, 1], varVariant);
    Params[0] := VarArrayOf(['sql_id']);
    Params[1] := VarArrayOf([SQLID]);
    if Mode = 0 then Res := DM.GetData('Pav246', Params);
    if Mode = 1 then Res := DM.GetData('Pav280', Params);
    if Mode = 2 then Res := DM.GetData('Pavel782', Params);

    if not VarIsNull(res) then
      begin
        CDS.Data := Res;
        while not CDS.Eof do
          begin
            Check.Items.Add(CDS.FieldByName('NAME').AsString);
            if CDS.FieldByName('STATE').AsInteger = 1 then Check.Checked[Check.Count-1] := True;
            if CDS.FieldByName('STATE').AsInteger = 0 then Check.Checked[Check.Count-1] := False;
            CDS.Next;
          end;
      end;
  except

  end;

che_up := Check;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 but_number := 0;
 indexCa := -1;

 get_sql_list := TStringList.Create;
 che_up := TCheckListBox.Create(form1);
 sqlCa := TStringList.Create;
 EnvSt := TStringList.Create;
 KeyList := TStringList.Create;
 PoolTable := TStringList.Create;

 TypeList := TStringList.Create;
 DoTypeList;

 CreateMegaGrid;

 BlobDown := false;

 II:=0;
 Fill := false;

 PoolFile := getcurrentdir+'\poolfile.cdp';

 SetRegistryIcon;

 GlobalStatus := False;
 form1.Caption := 'SQL Creator ' + GetExeInfo(True);
 Application.Title := 'SQL Creator ' + GetExeInfo(True)
end;


procedure GetSQL;
var Op_id: Integer;
begin
  Op_id := form1.CDSOperations.FieldByName('id').AsInteger;
  get_sql_list.Clear;
{0}  get_sql_list.Add('select * from SQL_CODES where SQL_BLOKS_ID = (select id from SQL_BLOKS where name= '+#39+item+#39+')');
     get_sql_list.Add('select * from SQL_BLOKS where HI_ID=0');
 // get_sql_list.Add('SELECT * FROM S_RULES INNER JOIN USER_GROUPS ON (S_RULES.USER_GROUPS_ID = USER_GROUPS.ID AND S_RULES.SQL_CODES_ID='+#39+grid_id+#39+')');
     get_sql_list.Add('SELECT * FROM S_RULES INNER JOIN USER_GROUPS ON (USER_GROUPS.STATE > 0 AND S_RULES.USER_GROUPS_ID = USER_GROUPS.ID AND S_RULES.SQL_CODES_ID='+#39+grid_id+#39+')');
 // get_sql_list.Add('select * from user_groups inner join s_rules on (USER_GROUPS.STATE > 0 AND S_RULES.USER_GROUPS_ID = USER_GROUPS.ID AND S_RULES.SQL_CODES_ID ='+#39+grid_id+#39+')');
     get_sql_list.Add('select * from SQL_BLOKS where HI_ID='+#39+item+'''');
     get_sql_list.Add('select * from SQL_BLOKS where HI_ID='+#39+inttostr(tabl[level,item_index])+'''');
{5}  get_sql_list.Add('SELECT * FROM USERS_IN_GROUP INNER JOIN USER_GROUPS ON (USER_GROUPS.STATE > 0 AND USERS_IN_GROUP.USER_GROUPS_ID = USER_GROUPS.ID AND USERS_IN_GROUP.USERS_ID='+#39+IntToStr(CurUserID)+#39+')');
     get_sql_list.Add('SELECT * FROM o_rules INNER JOIN USER_GROUPS ON (USER_GROUPS.STATE > 0 AND o_rules.USER_GROUPS_ID = USER_GROUPS.ID AND o_rules.operations_ID='+#39+IntToStr(Op_id)+#39+')');
end;

procedure Index;
begin

end;

procedure RefreshGrid(CDS: TClientDataSet; id, fl : integer );
var Res, Params: Variant;
begin

   try
     CDS.Active := False;
     if fl = 0 then
       begin
         Params := VarArrayCreate([0,1], varVariant);
         Params[0] := VarArrayOf(['id']);
         Params[1] := VarArrayOf([id]);
         Res := DM.GetData('Pav244', Params);
       end;

     if fl = 1 then
       begin
         Params := Null;
         Res := DM.GetData('Pav242', Params);
       end;
     if fl = 2 then
       begin
         Params := Null;
         Res := DM.GetData('Pav243', Params);
       end;

     if not VarIsNull(Res) then
      begin
        CDS.Data := Res;
      end;

     Rules;
   except

   end;
end;

procedure TForm1.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if form1.DBGrid1.FieldCount > 0 then
    begin
      SQLCodeAction;
      Rules;
    end;
end;

procedure Rules;
begin
   form1.CheckListBox1.Clear;
   grid_id := IntToStr(form1.CDSSQLCode.FieldByName('ID').AsInteger);
    tabl_block_id := form1.CDSSQLCode.FieldByName('SQL_BLOKS_ID').AsInteger;
        if grid_id <> '' then
          begin
           GetSQL;
           InsertChe(form1.CDSRules, form1.CheckListBox1, StrToInt(grid_id), 0);
           if form1.CheckListBox1.Count > 0 then form1.CheckListBox1.Selected[0] := True;
          end
          else form1.CheckListBox1.Clear;
end;

procedure TForm1.RulesOp;
var ID: Integer;
begin
   Opf.CheckListBox1.Clear;
   ID := form1.CDSOperations.FieldByName('ID').AsInteger;
        if ID <> 0 then
          begin
           GetSQL;
           InsertChe(form1.CDSOpRules, Opf.CheckListBox1, ID, 2);
           if Opf.CheckListBox1.Count > 0 then Opf.CheckListBox1.Selected[0] := True;
          end
          else Opf.CheckListBox1.Clear;
end;

procedure KeyPre;
var
    b:Boolean;
    pt:Pointer;
    h:integer;
begin
  h := Integer(form1.TreeView1.Selected.Data);
  tree_id := h;
    if h<>0 then
      begin
        RefreshGrid(Form1.CDSSQLCode, h, 0);
        SQLCodeAction;
        form1.CheckListBox1.Enabled := True;
        form1.Panel5.Enabled := True;
        form1.Panel10.Enabled := True;
        form1.GroupBox2.Enabled := True;
      end
      else
      begin
        if form1.CheckViewDel.Checked = True then RefreshGrid(Form1.CDSSQLCode, h, 1)
                                             else RefreshGrid(Form1.CDSSQLCode, h, 2);
        SQLCodeAction;
        form1.CheckListBox1.Enabled := False;
        form1.Panel5.Enabled := False;
        form1.Panel10.Enabled := False;
        form1.GroupBox2.Enabled := False;
      end;
    Rules;
end;

procedure TForm1.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if form1.DBGrid1.FieldCount > 0 then
    begin
      SQLCodeAction;
      Rules;
    end;
end;

procedure TForm1.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
 if (button=nbFirst) or
    (button=nbPrior) or
    (button=nbNext)  or
    (button=nbLast)  then Rules;
end;

procedure TForm1.TreeView1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if form1.TreeView1.Items.Count>0 then KeyPre;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  form1.ToolButton1.Click;
end;

procedure TForm1.CheckListBox1ClickCheck(Sender: TObject);
begin
  ChangeCheck(DM.cds_work, form1.CheckListBox1);
end;

procedure ChangeCheck(CDS: TClientDataSet; CheckBox: TCheckListBox);
var tCheck: string;
    Sta: Integer;
    Res, Params: Variant;
begin
  tCheck := form1.CheckListBox1.Items.Strings[form1.CheckListBox1.ItemIndex];
  if form1.CheckListBox1.Checked[form1.CheckListBox1.ItemIndex] then Sta := 1
                                                                else Sta := 0;
  try
    Params:=VarArrayCreate([0, 1], varVariant);
    Params[0]:=VarArrayOf(['sta','grid_id','tCheck']);
    Params[1]:=VarArrayOf([sta, grid_id, tCheck]);
    DM.StartTrans;
    Res := DM.RunSQL('Pav248', Params);
    if Res <> 0 then
      begin
        DM.BackTrans;
        Exit;
      end;
    DM.CommTrans;
  except

  end;
end;

procedure ChangeCheckOp(CDS: TClientDataSet; CheckBox: TCheckListBox; ID: Integer);
var tCheck: string;
    Sta: Integer;
    Res, Params: Variant;
begin
  tCheck := CheckBox.Items.Strings[CheckBox.ItemIndex];
  if CheckBox.Checked[CheckBox.ItemIndex] then Sta := 1
                                          else Sta := 0;
  try
    Params:=VarArrayCreate([0, 1], varVariant);
    Params[0]:=VarArrayOf(['sta','grid_id','tCheck']);
    Params[1]:=VarArrayOf([sta, ID, tCheck]);
    DM.StartTrans;
    Res := DM.RunSQL('Pavel784', Params);
    if Res <> 0 then
      begin
        DM.BackTrans;
        Exit;
      end;
    DM.CommTrans;
  except

  end;
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  if Conn then
    begin
      Usf.Show;
      form1.Enabled := False;
      ActiveUser(form1.CDSUsers);
      ActiveRole(form1.CDSRoles);
      InsertChe(form1.CDSRules, Usf.CheckListBox1, Usf.DBGrid1.DataSource.DataSet.FieldByName('id').AsInteger, 1);
      UserAction;
    end;
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
  if Conn then
    begin
      form1.Enabled := False;
      but_number := 3;
      Grf.Caption := 'Роли';
      Grf.DBGrid1.Columns.Items[0].Title.Caption := 'Роль';
      ActiveRole(form1.CDSRoles);
      Grf.DBGrid1.DataSource := form1.DSRoles;
      Grf.SpeedButton1.Enabled := False;
      Grf.SpeedButton2.Enabled := False;
      Grf.Show;
    end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var V: Variant;
begin
  V := DM.TestStatus;
  if VarIsNull(V )then
    begin
      Disconnect;
      Timer2.Enabled := False;
      MessageDlg('Соединение разорвано.', mtError, [mbOk], 0);
    end;
end;

procedure TForm1.CheckListBox1Enter(Sender: TObject);
begin
  if form1.CheckListBox1.Count > 0 then form1.CheckListBox1.Selected[0] := True;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  form1.ToolButton4.Click;
end;

function FillTree(Tree: TTreeView; CDS: TClientDataSet; idNode, idParent,
  cNodeName: string; Mode:boolean): Integer;
var
  i:integer;
  Params, Res: Variant;
begin
  // Корневой узел, должен быть первым в выборке Query
  Result := -1;
    try
      CDS.Active := False;
      Params := Null;
      Res := DM.GetData('Pav241', Params);
      if not VarIsNull(Res) then
        begin
          CDS.Data := Res;
        end;
if CDS.RecordCount > 0 then
  begin
  CDS.First;
  Tree.Realign;
  Tree.Items.Clear;
  Tree.Items.AddObject(nil, 'Блоки:', Ptr(0));
while not CDS.Eof do
  begin
    i := 0;
    while i < Tree.Items.Count do
      begin

      if Integer(Tree.Items.Item[i].Data) = CDS.FieldByName(idParent).asInteger then
        begin
          Tree.Items.AddChildObject(Tree.Items.Item[i],
          CDS.FieldByName(cNodeName).AsString,
          Pointer(CDS.FieldByName(idNode).asInteger));
          Break;
        end
        else Inc(i);
      end;
      CDS.Next;
  end;

Tree.Items.Item[0].Expand(Mode);
Tree.Items.Item[0].Selected := True;
Result := 1;
  end;
    except
      Result := -1;
    end;
end;

procedure TForm1.TreeView1Click(Sender: TObject);
begin
  if form1.TreeView1.Items.Count > 0 then KeyPre;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
var sSQL : Boolean;
begin
  sSQL := False;
  if Conn then
    begin
      if (ed_sql_txt.Text > '') and (TestEnvList) then
        begin
          if rbSQL.Checked then
            begin
              if (copy(AnsiUppercase(TrimLeft(ed_sql_txt.Text)),1,1) = 'S') then
                begin
                  sSQL := RunSQL(form1.ed_sql_txt.Text, 0);
                  if sSQL then
                    if (editSQL) then AddSQLText(form1.ed_sql_txt.Text, 0);
                end;
            end
            else
            begin
              if (copy(AnsiUppercase(TrimLeft(ed_sql_txt.Text)), 1, 1) <> 'S') then
                begin
                  sSQL := RunSQL(form1.ed_sql_txt.Text, 1);
                  if sSQL then
                    begin
                      if (editSQL) then AddSQLText(form1.ed_sql_txt.Text, 1);
                      form1.SpeedButton10.Enabled := True;
                      form1.SpeedButton11.Enabled := True;
                    end;
                end;

            end;

            if (editSQL) and (sSQL) then
              begin
                Inc(indexCa);
                if indexCa >= 1 then
                  begin
                    form1.SpeedButton8.Enabled := True;
                  end;
              end;
        end;
    end;
end;

procedure TForm1.SpeedButton10Click(Sender: TObject);
begin
  DM.CommTrans;
  //AfterModifTable(form1.qEx.SQL.Text, form1.qEx);
  form1.SpeedButton10.Enabled := False;
  form1.SpeedButton11.Enabled := False;
end;

procedure TForm1.ed_sql_txtChange(Sender: TObject);
begin
 if ed_sql_txt.Text <> '' then form1.SpeedButton7.Enabled := True
                          else form1.SpeedButton7.Enabled := False;
 editSql := True;
 AddValEnv;
end;

procedure TForm1.SpeedButton11Click(Sender: TObject);
begin
  DM.BackTrans;
  //AfterModifTable(form1.qEx.SQL.Text, form1.qEx);
  form1.SpeedButton10.Enabled := False;
  form1.SpeedButton11.Enabled := False;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  if Conn then
    begin
      form1.Enabled := False;
      but_number := 1;
      Grf.Caption := 'Группы';
      Grf.DBGrid1.Columns.Items[0].Title.Caption := 'Группа';
      ActiveGroup(form1.CDSGroups);
      Grf.DBGrid1.DataSource := form1.DSGroups;
      Grf.SpeedButton1.Enabled := False;
      Grf.SpeedButton2.Enabled := False;
      Grf.Show;
    end;
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
  {if Conn then
    begin}
      Application.CreateForm(TLimitForm, LimitForm);
      LimitForm.ShowModal;
      LimitForm.Free;
    //end;
end;

procedure AddSQLText(text:string; state:byte);
begin
 sqlCa.Add(inttostr(state)+text);
end;

procedure GetSQLText(indka:integer; var text:string; var state:byte);
begin
 text:=copy(sqlCa.Strings[indka],2,length(sqlCa.Strings[indka])-1);
 state:=strtoint(copy(sqlCa.Strings[indka],1,1));
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
var state: Byte;
     text: string;
begin
  Dec(indexCa);
  GetSQLText(indexCa, text, state);

  form1.ed_sql_txt.Text := text;

  if state = 0 then form1.rbSQL.Checked := True
             else form1.rbDML.Checked := True;
  if indexCa < SqlCa.Count then form1.SpeedButton9.Enabled := True;
  if indexCa = 0 then form1.SpeedButton8.Enabled := False;

  editSQL := False;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
var state: Byte;
     text: string;
begin
 Inc(indexCa);
 GetSQLText(indexCa,text,state);

 form1.ed_sql_txt.Text := text;

 if state = 0 then form1.rbSQL.Checked := True
            else form1.rbDML.Checked := True;
 if indexCa = sqlCa.Count - 1 then form1.SpeedButton9.Enabled := False;
 if indexCa < sqlCa.Count then form1.SpeedButton8.Enabled := True;

 editSQL := False;
end;

function GetEnvironList(BaseSql:string; delim: char):TStrings;
var len,i,envStart,envLen:integer;
                        b:integer;
                   s, env:string;
          comOpen,comStop:boolean;
begin

  len:=length(BaseSql);
  b:=0;
  env:='';

  comOpen:=false;
  comStop:=true;

  KeyList.Clear;

  for i:=0 to len do
    begin
     s:=copy(BaseSql,i,1);
      if s='/' then
      if (copy(BaseSql,i+1,1)='*')  then
        begin
         comOpen:=true;
         comStop:=false;
        end;
      if s='/' then
      if (copy(BaseSql,i-1,1)='*') then
        begin
         comStop:=true;
        end;
      if (s=delim)       and
         (b=0)           and
         (comOpen<>true) and
         (comStop=true)  then
         begin
          envStart:=i;
          b:=1;
         end
         else
      if (s=delim)       and
         (b=1)           and
         (comOpen<>true) and
         (comStop=true)  then
         begin
          envLen:=i-envStart+1;
          b:=2;
         end;
      if b<>0 then
         begin
          env:=env+s;
         end;
      if b=2 then
         begin
          KeyList.Add(env+'='+'|'+inttostr(envStart)+'|'+inttostr(envLen)+'|');
          b:=0;
          env:='';
         end;
      if comOpen=true then
        if s='!' then
         begin
          comOpen:=false;
        //  form1.Caption:='hgjj';
         end;


    end;

  Result:=KeyList;
end;

procedure AddValEnv;
var     i,k,g,s:integer;
              p:TEnv;
begin
    EnvSt:=GetEnvironList(form1.ed_sql_txt.Text,'!');
    i:=EnvSt.Count;
    EnvSt.Clear;
    k:=mGr.RowCount-1;

     for g:=0 to k do
        begin
         mGr.Cells[1,g]:='';
         mGr.Cells[0,g]:='';
         mGr.Cells[2,g]:='';
        end;

     for g:=0 to k do
        begin
         mGr.DeleteRow(g);
        end;

 if form1.ed_sql_txt.Text<>'' then
    begin
     EnvSt:=GetEnvironList(form1.ed_sql_txt.Text,'!');
     i:=EnvSt.Count;
      if i<>0 then
       for k:=0 to i-1 do
        begin
          p:=GetXLen(EnvSt.Strings[k]);
          mGr.RowCount:=k+1;
          mGr.Cells[0,k]:=p.name;
        end;
    end;
    
end;

function GetXLen(one:string):TEnv;
var i,k,g,st:integer;
          po:integer;
        s,s2:string;
      oneEnv:TEnv;
begin
 s:='';
 st:=0;
 
 po:=pos('=', one);
 oneEnv.name:=copy(one,1,po-1);

 g:=length(one);
 one:=copy(one,po+1,g);
 g:=length(one);

          for k:=1 to g do
             begin
               s2:=copy(one,k,1);
               if s2='|' then
                   begin
                     inc(st);
                        if st=2 then
                          begin
                           oneEnv.start:=strtoint(s);
                          end
                          else
                        if st=3 then
                          begin
                           oneEnv.length:=strtoint(s);
                          end;

                       {   else
                        if st=4 then
                          begin
                           oneEnv.length:=s;
                          end ;    }

                      {    else
                        if st=5 then
                          begin
                           relt.time:=s;
                          end
                          else
                        if st=6 then
                          begin
                           relt.msg:=s;
                          end;   }

                     s:='';

                   end
                   else s:=s+copy(one,k,1);
             end;
             
 Result:=oneEnv;
end;

procedure TForm1.SpeedButton12Click(Sender: TObject);
var    p:TEnv;
       i:integer;
       m:TMemo;
    rect:TRect;
    ARect:TRect;
    NewComboBox: TComboBox;

begin
exportco;
// testtype;
// RotateSQL ;
// RunSQL(form1.ed_sql_txt.Text,0);
// mGr.Cells[xx,yy]:='wetrwt';
// form1.ed_sql_txt.Text:= DeleteCommentAll(form1.ed_sql_txt.Text);

end;

procedure TForm1.valEnvSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var p:TEnv;
begin
  p:=GetXLen(EnvSt.Strings[ARow-1]);
  
  form1.ed_sql_txt.SelStart:=p.start-1;
  form1.ed_sql_txt.SelLength:=p.length;
end;

function RotateSQL(textsql:string):string;
var     s: string;
        m: TMemo;
     i,rs: integer;
        p: TEnv;
    delta: integer;
begin
  form1.memo1.Text := textsql;
  delta := 0;
    for i := 0 to mGr.RowCount-1 do
      begin
        p := GetXLen(EnvSt.Strings[i]);
         if mGr.Cells[2,i] = 'Replace' then
          begin
           s := mGr.Cells[1,i];


        form1.memo1.SelStart := p.start + delta - 1;
        form1.memo1.SelLength := p.length;
        form1.memo1.SelText := s;
        if p.length > length(s) then rs := length(s) - p.length
                               else rs := p.length - length(s);

        delta := delta + rs;
          end;

      end;

 Result := form1.Memo1.Text;
end;

procedure TNewStringGrid.DoExit;
begin

end;

function TNewStringGrid.CreateEditor: TInplaceEdit;

begin
  FEditList := TInplaceEditList.Create(Self);
  FEditList.DropDownRows := 10;
  FEditList.OnGetPickListitems := EditListGetItems;
  FEditList.OnEditButtonClick := EditButtonClick;
  Result := FEditList;
end;

procedure TNewStringGrid.EditButtonClick(Sender: TObject);
begin
  if (BlobDown = false) and
     (mGr.Cells[xx+1,yy] = 'Blob') then
    if not BlobDown then
      begin
       DoMemo;
       form1.Enabled := False;
      end
      else
      begin
       mGr.Cells[xx,yy] := MyMemo.Text;
       BlobDown:=false;
       Blobf.Visible := False;
      end;

  if (mGr.Cells[xx+1,yy] = 'Date') then
     begin
       DoDateTime;
       form1.Enabled := False;
     end;

end;

procedure TNewStringGrid.EditListGetItems(ACol, ARow: Integer; Items: TStrings);

begin
  Items.Clear;
  Items.AddStrings(TypeList);
end;

function TNewStringGrid.GetEditStyle(ACol, ARow: Integer): TEditStyle;
begin
 if ACol=1 then Result := esEllipsis;
 if ACol=2 then Result := esPickList;
end;

function TNewStringGrid.SelectCell(ACol, ARow: Longint): Boolean;
var p:TEnv;
begin

 XX:=ACol;
 YY:=ARow;

 if EnvSt.Count<>0 then
  begin
   p:=GetXLen(EnvSt.Strings[ARow]);
   form1.ed_sql_txt.SelStart:=p.start-1;
   form1.ed_sql_txt.SelLength:=p.length;
  end;

 Result:=true;
end;

function TNewStringGrid.GetEditText(ACol, ARow: Longint): string;
begin
 Result:=mGr.Cells[ACol, ARow];
end;

procedure CreateMegaGrid;
begin
   mGr:=TNewStringGrid.Create(form1.panEnv);
 with mGr do
    begin
    Parent := Form1.panEnv;
    Align:=alClient;
    BorderStyle:=bsSingle;
    Ctl3D:=false;
    ColCount:=3;
    FixedRows:=0;
    RowCount:=1;
    DefaultRowHeight:=15;
    Options := Options + [goEditing]+ [goDrawFocusSelected];
    end;
end;

procedure DoDateTime;
begin
  Datef.Visible:=true;
end;

procedure DoMemo;
begin
 BlobDown:=true;
 Blobf.Show;
 MyMemo.Text:=mGr.Cells[xx,yy];
end;

procedure TNewStringGrid.KeyUp(var Key: Word; Shift: TShiftState);
begin
 if Key=13 then DoMemo
           else MyMemo.Text:=mGr.Cells[xx,yy];
end;

function DeleteComment(sql,comen:variant):string;
begin
 sql:=AnsiReplaceStr(sql,'/*'+comen+'!','');
 sql:=AnsiReplaceStr(sql,'!'+comen+'*/','');
 Result:=sql;
end;

function DeleteCommentAll(sql:variant):string;
var      i:integer;
      s,s2:string;
begin

  i:=pos('/',sql);
  s:='';
  s2:='';
  
 while i<>0 do
   begin
     if copy(sql,i+1,1)='*' then
      begin
       Inc(i);
       Inc(i);
       s:=copy(sql,i,1);
       while s<>' ' do
         begin
           s2:=s2+copy(sql,i,1);
           Inc(i);
           s:=copy(sql,i,1);
         end;
       sql:=AnsiReplaceStr(sql,'/*'+s2,'');
     end
     else
     if copy(sql,i-1,1)='*' then
      begin
       Dec(i);
       Dec(i);
       s:=copy(sql,i,1);
       while s<>' ' do
         begin
           s2:=s2+copy(sql,i,1);
           Dec(i);
           s:=copy(sql,i,1);
         end;
       sql:=AnsiReplaceStr(sql,ReverseString(s2)+'*/','');
      end;

      s2:='';
      i:=pos('/',sql);
   end;

Result:=sql;
end;

function RunSQL(sqltext: string; oper: Byte): Boolean;
var
 EnvCount, i, EnvCountNoReplace: Integer;
        bool: Boolean;
       sname: string;
    text_sql: string;
 Res, Params: Variant;
 Value1, Value2: Variant;
  RepCorrect: Integer;
begin
  Result := True;
  if (EnvSt.Count = 0) then text_sql := form1.ed_sql_txt.Text
                     else text_sql := form1.memo1.text;
  if TestEnvList then
    begin
      if EnvSt.Count > 0 then
        begin
          text_sql := RotateSQL(form1.ed_sql_txt.Text);
          EnvCount := mGr.RowCount;
          EnvCountNoReplace := 0;
          RepCorrect := 0;
          for i := 0 to EnvCount - 1 do
            begin
              if mGr.Cells[2,i]='Replace' then Inc(EnvCountNoReplace);
            end;
          if EnvCountNoReplace > 0 then EnvCountNoReplace := EnvCount - EnvCountNoReplace
                                   else EnvCountNoReplace := EnvCount;

          //text_sql := form1.ed_sql_txt.Text;
        end;

      if (oper = 0) then
        begin
          try
            form1.CDSExplorer.Active := False;

            Params := VarArrayCreate([0,1], varVariant);

            Value1 := VarArrayCreate([0,EnvCountNoReplace], varVariant);
            Value2 := VarArrayCreate([0,EnvCountNoReplace], varVariant);

            Value1[0] := '!TEXT_SQL';
            Value2[0] := text_sql;

            for i := 0 to EnvCount - 1 do
              begin
                if mGr.Cells[2,i]='Integer' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    Value2[i+1-RepCorrect] := StrToInt(mGr.Cells[1,i]);
                  end
                  else

                if mGr.Cells[2,i]='String' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    Value2[i+1-RepCorrect] := mGr.Cells[1,i];
                  end
                  else

                if mGr.Cells[2,i]='Blob' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    Value2[i+1-RepCorrect] := mGr.Cells[1,i];
                  end
                  else

                if mGr.Cells[2,i]='Date' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    Value2[i+1-RepCorrect] := StrToDateTime(mGr.Cells[1,i]);;
                  end
                  else

                if mGr.Cells[2,i]='Boolean' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    if mGr.Cells[1,i]='true' then Value2[i+1-RepCorrect] := True;
                    if mGr.Cells[1,i]='false'then Value2[i+1-RepCorrect] := False;
                  end
                  else

                if mGr.Cells[2,i]='Float' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    Value2[i+1-RepCorrect] := StrToFloat(mGr.Cells[1,i]);
                  end
                  else

                if mGr.Cells[2,i]='Null' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    Value2[i+1-RepCorrect] := Null;
                  end
                  else
                    Inc(RepCorrect);
              end;



            Params[0] := Value1;
            Params[1] := Value2;

           // Params[0] := VarArrayOf(['!TEXT_SQL', 'id']);
           // Params[1] := VarArrayOf([TEXT_SQL, 40]);

            Res := DM.GetData('Pavel258', Params);
            if not VarIsNull(Res) then
              begin
                form1.CDSExplorer.Data := Res;
              end;
          except
            MessageBox(form1.Handle,'[Open] Проверить синтаксис запроса','Ошибка', mb_ok);
            Result := False;
          end;
        end;

      if oper = 1 then
        begin
          try

            form1.CDSExplorer.Active := False;

            Params := VarArrayCreate([0,1], varVariant);

            Value1 := VarArrayCreate([0,EnvCountNoReplace], varVariant);
            Value2 := VarArrayCreate([0,EnvCountNoReplace], varVariant);

            Value1[0] := '!TEXT_SQL';
            Value2[0] := text_sql;

            for i := 0 to EnvCount - 1 do
              begin
                if mGr.Cells[2,i]='Integer' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    Value2[i+1-RepCorrect] := StrToInt(mGr.Cells[1,i]);
                  end
                  else

                if mGr.Cells[2,i]='String' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    Value2[i+1-RepCorrect] := mGr.Cells[1,i];
                  end
                  else

                if mGr.Cells[2,i]='Blob' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    Value2[i+1-RepCorrect] := mGr.Cells[1,i];
                  end
                  else

                if mGr.Cells[2,i]='Date' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    Value2[i+1-RepCorrect] := StrToDateTime(mGr.Cells[1,i]);
                  end
                  else

                if mGr.Cells[2,i]='Boolean' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    if mGr.Cells[1,i]='true' then Value2[i+1-RepCorrect] := True;
                    if mGr.Cells[1,i]='false'then Value2[i+1-RepCorrect] := False;
                  end
                  else

                if mGr.Cells[2,i]='Float' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    Value2[i+1-RepCorrect] := StrToFloat(mGr.Cells[1,i]);
                  end
                  else

                if mGr.Cells[2,i]='Null' then
                  begin
                    Value1[i+1-RepCorrect] := Copy(mGr.Cells[0,i],2,length(mGr.Cells[0,i])-2);
                    Value2[i+1-RepCorrect] := Null;
                  end
                  else
                    Inc(RepCorrect);
              end;

            Params[0] := Value1;
            Params[1] := Value2;

            Res := DM.GetData('Pavel258', Params);
            if not VarIsNull(Res) then
              begin
                form1.CDSExplorer.Data := Res;
              end;


            //AfterModifTable(form1.qEx.SQL.Text, form1.qEx);
            Result := True;
          except
            MessageBox(form1.Handle,'[Execute] Проверить синтаксис запроса','Ошибка', mb_ok);
            Result := False;
          end;
        end;
    end;
end;

procedure TForm1.SpeedButton13Click(Sender: TObject);
begin
  if form1.Memo3.Text <> '' then
    begin
      form1.ed_sql_txt.Text := form1.Memo3.Text;
      form1.PageControl1.ActivePageIndex := 1;
    end;
end;

procedure DoTypeList;
begin
 TypeList.Add('Integer');
 TypeList.Add('String');
 TypeList.Add('Blob');
 TypeList.Add('Date');
 TypeList.Add('Boolean');
 TypeList.Add('Float');
 TypeList.Add('Null');
 TypeList.Add('Replace');
 TypeList.Sort;
end;

function TestEnvList:boolean;
var    te:set of Char;
    i,k,g:integer;
begin
  Result:=true;

  for i:=0 to mGr.RowCount-1 do
   begin
     if not TinList(mGr.Cells[2,i]) or
                (mGr.Cells[1,i]='') then Result:=false;
   end;

  if mGr.Cells[0,0]='' then Result:=true; 

end;

function TinList(text:string):boolean;
var k:integer;
begin
   Result:=false;

    for k:=0 to TypeList.Count-1 do
   begin
     if text=TypeList.Strings[k] then Result:=true;
   end;
end;

procedure AfterModifTable(s:string; Quer:TQuery);
begin
  if GetTablename(s)<>'' then
     begin
      Quer.SQL.Clear;
      Quer.SQL.Text:='select * from '+GetTablename(s);
      try
       Quer.Open;
      except
       MessageBox(form1.Handle,'[Open] Не могу вывести редакцию таблицы','Ошибка', mb_ok);
      end;
     end;
end;

procedure ImportCo;
var Vsego, UsedRecord: Integer;
    ms1, ms2: string;
    DT: TDateTime;
    UpdateNumber: Integer;
    Res, Params: Variant;
begin
  Vsego := 0;
  UsedRecord := 0;
  ms1 := 'Количество записей в пакете обновления: ';
  ms2 := 'Использовано из них: ';
  if Conn then
    begin
      if form1.OpenDlg.Execute then
        if (form1.OpenDlg.FileName='')or(form1.OpenDlg.FileName='*.cds') then
          begin
            Exit;
          end
          else
          begin
            DM.StartTrans;
            if not Central then
              begin
                if (ValidNumber(Copy(form1.OpenDlg.FileName, 1, Length(form1.OpenDlg.FileName) - 4) + '.cds',
                           Copy(form1.OpenDlg.FileName, 1, Length(form1.OpenDlg.FileName) - 4) + '.cdi',
                           Dm.cds_work, DT, UpdateNumber)) then
                  begin
                    if LoadBackup(form1.CDSLoadUpdate, DM.cds_work, form1.CDSUpdate, form1.OpenDlg.GetNamePath, form1.OpenDlg.FileName, Vsego, UsedRecord) then
                      begin

                        if not Central then
                          begin
                            try

                              Params := VarArrayCreate([0,1], varVariant);
                              Params[0] := VarArrayOf(['ID', 'DAT']);
                              Params[1] := VarArrayOf([UpdateNumber, Now]);
                              Res := DM.RunSQL('Pav289', Params);
                              if Res <> 0 then
                                begin
                                  DM.BackTrans;
                                end
                                else
                                begin
                                  DM.CommTrans;
                                  MessageDlg(ms1 + IntToStr(Vsego) + #13 + ms2 + IntToStr(UsedRecord), mtInformation, [mbOK], 0);
                                end;
                            except
                              DM.BackTrans;
                              MessageDlg('Нельзя установить это обновление!', mtError, [mbOK], 0);
                            end;
                          end;
                        RefreshAll;
                      end
                      else
                      begin
                        DM.BackTrans;
                        MessageDlg('Данные не обновлены!!!', mtError, [mbOK], 0);
                      end;
                  end
                  else MessageDlg('Нумерация не совпадает.' + #13 + 'Пакет обновления №' + IntToStr(UpdateNumber) + ' не может быть установлен!', mtError, [mbOK], 0);
            end
            else
              if LoadBackup(form1.CDSLoadUpdate, DM.cds_work, form1.CDSUpdate, form1.OpenDlg.GetNamePath, form1.OpenDlg.FileName, Vsego, UsedRecord) then
                begin
                  DM.CommTrans;
                  MessageDlg(ms1 + IntToStr(Vsego) + #13 + ms2 + IntToStr(UsedRecord), mtInformation, [mbOK], 0);
                  RefreshAll;
                end
                else
                  begin
                    DM.BackTrans;
                    MessageDlg('Данные не обновлены!!!', mtError, [mbOK], 0);
                  end;
        end;
    end;
end;

procedure ExportCo;
begin
  if Conn then
    begin
      if form1.SaveDlg.Execute then
        if (form1.SaveDlg.FileName = '') or (form1.SaveDlg.FileName = '*.cds') then
          begin
            MessageBox(form1.Handle, 'Данные не сохранены!', 'Предупреждение', mb_ok);
            Exit;
          end
          else
            PrepareOutback(form1.SaveDlg.GetNamePath, form1.SaveDlg.FileName);
     
    end;
end;

procedure TForm1.Send1Click(Sender: TObject);
begin
  if Conn then ExportCo;
end;

procedure TForm1.Receive1Click(Sender: TObject);
begin
  if Conn then CreateUpManager;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
 if Conn then
   begin
    mH := 0;
    ClearEdit;
    form6.Show;
    form1.Enabled := False;
   end;
end;

procedure TForm1.ClientDataSet2AfterPost(DataSet: TDataSet);
begin


  Query1.Close;
  Query1.Open;
  form1.q_last.Close;
  form1.q_last.Open;
  ////// FillTree(TreeView1, Query1, 'id', 'hi_id', 'name', false);
  ////// FillTree(form6.TreeView1,form1.q_last, 'id', 'hi_id', 'name', false);

end;

procedure TForm1.N2Click(Sender: TObject);
begin
  if Conn then FillTree(TreeView1, DM.cds_work, 'id', 'hi_id', 'name', True);
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  if Conn then FillTree(TreeView1, DM.cds_work, 'id', 'hi_id', 'name', False);
end;

procedure TForm1.SpeedButton15Click(Sender: TObject);
begin
  if Conn then
    if form1.CDSSQLCode.Active then
      if (form1.CDSSQLCode.RecordCount > 0) and
          (form1.TreeView1.Selected.Text <> 'Блоки:') then
        begin
          DeleteSQLCode(DM.cds_work, form1.CDSSQLCode.FieldByName('COMMENT').AsString +
                        ' (' + DateToStr(Date) + ' ' + TimeToStr(Time) + ')');
        end;
  form1.CheckBox1.Checked := False;
end;

procedure TForm1.Tool3Click(Sender: TObject);
begin
  begin
    but_number := 3;
    form1.Enabled := False;
    Grf.Caption := 'Роли';
    Grf.DBGrid1.Columns.Items[0].Title.Caption := 'Роль';
    form1.Query8.Active := False;
    form1.Query8.SQL.Text := ' select * FROM ROLES where state > 0 order by id';
    form1.Query8.Active := True;
    Grf.SpeedButton1.Enabled := False;
    Grf.SpeedButton2.Enabled := False;
    Grf.Show;
  end;
end;

procedure TForm1.ClientDataSet2AfterInsert(DataSet: TDataSet);
var s:string;
    i:integer;
begin

end;

procedure TForm1.ClientDataSet2AfterEdit(DataSet: TDataSet);
begin
 //  form1.ClientDataSet2.FieldByName('STATE').AsInteger:=2;
end;

function SaveBackup(CDS: TClientDataSet; Q: TQuery; path, FileData: string; var RecordSum: Integer): Boolean;
var Stream1, Stream2: TMemoryStream;
    Buf: Char;
    s, ss: string;
    i, k, Size, po, gi: Integer;
    f: TextFile;
    Flag: Integer;
    SaveDate: string;
    Buffer: Char;
    UpdateNumber: string;
    Dat, Tim, Number: string;
    Res, Params: Variant;

begin
  Result := True;
  Flag := 0;
  RecordSum := 0;
  try
    DM.StartTrans;
    Stream1 := TMemoryStream.Create;
    Stream2 := TMemoryStream.Create;
    SaveDate := DateInFileName;
    AssignFile(f, FileData + SaveDate + '.cdi');
    Rewrite(f);
    WriteLn(f, '0');
    try
      CDS.Active := False;
      Params := Null;
      Res := DM.GetData('Pav290', Params);
      if not VarIsNull(Res) then
        begin
          CDS.Data := Res;
          RecordSum := RecordSum + CDS.RecordCount;
          CDS.SaveToStream(Stream1, dfBinary);
          Size := Stream1.Size;
          WriteLn(f, IntToStr(Size));
          if Central then
            begin
              Params := Null;
              Res := DM.RunSQL('Pav293', Params);
              if Res <> 0 then
                begin
                  Result := False;
                end;
              Params := Null;
              Res := DM.RunSQL('Pav294', Params);
              if Res <> 0 then
                begin
                  Result := False;
                end;
            end;
        end;
    except
      Result := False;
    end;

    try
      CDS.Active := False;
      Params := Null;
      Res := DM.GetData('Pav291', Params);
      if not VarIsNull(Res) then
        begin
          CDS.Data := Res;
          RecordSum := RecordSum + CDS.RecordCount;
          CDS.SaveToStream(Stream1, dfBinary);
          Size := Stream1.Size;
          WriteLn(f, IntToStr(Size));
          if Central then
            begin
              Params := Null;
              Res := DM.RunSQL('Pav297', Params);
              if Res <> 0 then
                begin
                  Result := False;
                end;
              Params := Null;
              Res := DM.RunSQL('Pav298', Params);
              if Res <> 0 then
                begin
                  Result := False;
                end;
            end;
        end;
    except
      Result := False;
    end;

    try
      CDS.Active := False;
      Params := Null;
      Res := DM.GetData('Pav292', Params);
      if not VarIsNull(Res) then
        begin
          CDS.Data := Res;
          RecordSum := RecordSum + CDS.RecordCount;
          CDS.SaveToStream(Stream1, dfBinary);
          Size := Stream1.Size;
          WriteLn(f, IntToStr(Size));
          if Central then
            begin
              Params := Null;
              Res := DM.RunSQL('Pav295', Params);
              if Res <> 0 then
                begin
                  Result := False;
                end;
              Params := Null;
              Res := DM.RunSQL('Pav296', Params);
              if Res <> 0 then
                begin
                  Result := False;
                end;
            end;
        end;
    except
      Result := False;
    end;

    try
      CDS.Active := False;
      Params := Null;
      Res := DM.GetData('Pavel1122', Params);
      if not VarIsNull(Res) then
        begin
          CDS.Data := Res;
          RecordSum := RecordSum + CDS.RecordCount;
          CDS.SaveToStream(Stream1, dfBinary);
          Size := Stream1.Size;
          WriteLn(f, IntToStr(Size));
          if Central then
            begin
              Params := Null;
              Res := DM.RunSQL('Pavel1123', Params);
              if Res <> 0 then
                begin
                  Result := False;
                end;
              Params := Null;
              Res := DM.RunSQL('Pavel1124', Params);
              if Res <> 0 then
                begin
                  Result := False;
                end;
            end;
        end;
    except
      Result := False;
    end;

    try
      CDS.Active := False;
      Params := Null;
      Res := DM.GetData('Pavel1125', Params);
      if not VarIsNull(Res) then
        begin
          CDS.Data := Res;
          RecordSum := RecordSum + CDS.RecordCount;
          CDS.SaveToStream(Stream1, dfBinary);
          Size := Stream1.Size;
          WriteLn(f, IntToStr(Size));
        end;
    except
      Result := False;
    end;

    try
      CDS.Active := False;
      Params := Null;
      Res := DM.GetData('Pavel1128', Params);
      if not VarIsNull(Res) then
        begin
          CDS.Data := Res;
          RecordSum := RecordSum + CDS.RecordCount;
          CDS.SaveToStream(Stream1, dfBinary);
          Size := Stream1.Size;
          WriteLn(f, IntToStr(Size));
        end;
    except
      Result := False;
    end;

    if Central then
      begin
        Dat := DateToStr(Date);
        Size := Size + Length(Dat);
        WriteLn(f, IntToStr(Size));
        for gi := 1 to Length(Dat) do
          begin
            Buffer := Dat[gi];
            Stream1.Write(Buffer, 1);
          end;

        Tim := TimeToStr(Time);
        Size := Size + Length(Tim);
        WriteLn(f, IntToStr(Size));
        for gi := 1 to Length(Tim) do
          begin
            Buffer := Tim[gi];
            Stream1.Write(Buffer, 1);
          end;

        CDS.Active := False;
        Params := Null;
        Res := DM.GetData('Pav288', Params);
        if not VarIsNull(Res) then
          begin
            CDS.Data := Res;
            UpdateNumber := IntToStr(CDS.FieldByName('MAX').AsInteger + 1);
          end
          else
            UpdateNumber := '1';

        Size := Size + Length(UpdateNumber);
        WriteLn(f, IntToStr(Size));
        for gi := 1 to Length(UpdateNumber) do
          begin
            Buffer := UpdateNumber[gi];
            Stream1.Write(Buffer, 1);
          end;

        Params := VarArrayCreate([0,1], varVariant);
        Params[0] := VarArrayOf(['ID', 'DAT']);
        Params[1] := VarArrayOf([StrToInt(UpdateNumber), Now]);
        Res := DM.RunSQL('Pav289', Params);
        if Res <> 0 then
          begin
            Result := False;
          end;
      end;

    CloseFile(f);
    Stream1.SaveToFile(FileData + SaveDate + '.cds');

    Stream1.Free;

  except
    Result := False;
  end;

  if Result then
    begin
      DM.CommTrans;
    end
    else
    begin
      RecordSum := 0;
      DeleteFile(FileData + SaveDate + '.cdi');
      DM.BackTrans;
    end;

end;

function LoadBackup(CDS: TClientDataSet; CDSQ, CDSUp: TClientDataSet; path, filedata:string; var Vsego, UsedRecord:integer ): Boolean;
var Stream1, Stream2: TMemoryStream;
    f: TextFile;
    s1,s2: string;
    tr: TStringList;
    i: Integer;
    r: Integer;
    VCount, UCount: Integer;
    A,B: Integer;
    Res, Params: Variant;
begin
  Result := False;
  try
    Stream1 := TMemoryStream.Create;
    Stream2 := TMemoryStream.Create;
    VCount := 0;
    UCount := 0;
    Stream1.LoadFromFile(FileData);
    AssignFile(f, Copy(FileData, 1, Length(FileData) - 4) + '.cdi');

    Reset(f);
    ReadLn(f, s1);

    for i := 1 to 3 do
      begin
        ReadLn(f, s2);
        Stream1.Position := StrToInt(s1);
        Stream2.CopyFrom(Stream1, StrToInt(s2) - StrToInt(s1));

        s1 := s2;

        Stream2.Position := 0;
        CDS.LoadFromStream(Stream2);
        Application.ProcessMessages;
        Vsego := Vsego + CDS.RecordCount;

        case i of
          1: begin    // для SQL_BLOKS
                CDS.First;
                CDSQ.Active := False;
                Params := Null;
                Res := DM.GetData('Pav299', Params);
                if not VarIsNull(Res) then
                  begin
                    CDSQ.Data := Res;
                  end;
                while not CDS.EOF do
                  begin
                    if Central then
                      begin
                        A := CDS.FieldByName('STATE').AsInteger;
                        B := A;
                      end
                      else
                      begin
                        A := 1;
                        B := -2;
                      end;
                    try
                      if  CDSQ.Locate('KN', CDS.FieldByName('KN').Value, [loCaseInsensitive]) then
                        begin
                          if (CDS.FieldByName('STATE').AsInteger = 2) then
                            begin
                              Inc(UsedRecord);
                              CDSUp.Active := False;
                              Params := VarArrayCreate([0,1], varVariant);
                              Params[0] := VarArrayOf(['NAME', 'STATE', 'HI_ID', 'KN']);
                              Params[1] := VarArrayOf([CDS.FieldByName('NAME').Value, A, CDS.FieldByName('HI_ID').AsInteger, CDS.FieldByName('KN').Value]);
                              Res := DM.RunSQL('Pav302', Params);
                              if Res <> 0 then
                                begin
                                  Result := False;
                                end;
                            end;

                          if (CDS.FieldByName('STATE').AsInteger = -1) then
                            begin
                              Inc(UsedRecord);
                              CDSUp.Active := False;
                              Params := VarArrayCreate([0,1], varVariant);
                              Params[0] := VarArrayOf(['STATE', 'KN']);
                              Params[1] := VarArrayOf([B, CDS.FieldByName('KN').Value]);
                              Res := DM.RunSQL('Pav303', Params);
                              if Res <> 0 then
                                begin
                                  Result := False;
                                end;
                            end;

                           if (CDS.FieldByName('STATE').AsInteger = 3) then
                              begin
                                Inc(UsedRecord);
                              CDSUp.Active := False;
                              Params := VarArrayCreate([0,1], varVariant);
                              Params[0] := VarArrayOf(['STATE', 'KN']);
                              Params[1] := VarArrayOf([A, CDS.FieldByName('KN').Value]);
                              Res := DM.RunSQL('Pav303', Params);
                              if Res <> 0 then
                                begin
                                  Result := False;
                                end;
                              end;

                         end
                         else
                         begin
                           if (CDS.FieldByName('STATE').AsInteger = 3) or (CDS.FieldByName('STATE').AsInteger = 2) then
                              begin
                                Inc(UsedRecord);
                              CDSUp.Active := False;
                              Params := VarArrayCreate([0,1], varVariant);
                              Params[0] := VarArrayOf(['ID', 'NAME', 'STATE', 'HI_ID', 'KN']);
                              Params[1] := VarArrayOf([CDS.FieldByName('ID').AsInteger, CDS.FieldByName('NAME').Value, A, CDS.FieldByName('HI_ID').AsInteger, CDS.FieldByName('KN').Value]);
                              Res := DM.RunSQL('Pav304', Params);
                              if Res <> 0 then
                                begin
                                  Result := False;
                                end;
                              end;

                          end;

                         except
                          Result := False;
                         end;
                          CDS.Next;
                       end;

                   end;


               2: begin    // для   OPERATIONS
                      CDS.First;
                      CDSQ.Active := False;
                      Params := Null;
                      Res := DM.GetData('Pav300', Params);
                      if not VarIsNull(Res) then
                        begin
                          CDSQ.Data := Res;
                        end;
                      while not CDS.EOF do
                       begin
                             if Central then
                                     begin
                                      A := CDS.FieldByName('STATE').AsInteger;
                                      B := A;
                                     end
                                     else
                                     begin
                                      A := 1;
                                      B := -2;
                                     end;
                         try
                         if  CDSQ.Locate('KN', CDS.FieldByName('KN').Value, [loCaseInsensitive]) then
                          begin

                            if (CDS.FieldByName('STATE').AsInteger = 2) then
                              begin
                                Inc(UsedRecord);
                                CDSUp.Active := False;
                                Params := VarArrayCreate([0,1], varVariant);
                                Params[0] := VarArrayOf(['NAME', 'STATE', 'COMMENT', 'ROLES_ID', 'KN']);
                                Params[1] := VarArrayOf([CDS.FieldByName('NAME').Value, A, CDS.FieldByName('COMMENT').Value, CDS.FieldByName('ROLES_ID').AsInteger, CDS.FieldByName('KN').Value]);
                                Res := DM.RunSQL('Pav305', Params);
                                if Res <> 0 then
                                  begin
                                    Result := False;
                                  end;
                              end;

                            if (CDS.FieldByName('STATE').AsInteger = -1) then
                              begin
                                Inc(UsedRecord);
                                CDSUp.Active := False;
                                Params := VarArrayCreate([0,1], varVariant);
                                Params[0] := VarArrayOf(['STATE', 'KN']);
                                Params[1] := VarArrayOf([B, CDS.FieldByName('KN').Value]);
                                Res := DM.RunSQL('Pav306', Params);
                                if Res <> 0 then
                                  begin
                                    Result := False;
                                  end;
                              end;

                            if (CDS.FieldByName('STATE').AsInteger = 3) then
                              begin
                                Inc(UsedRecord);
                                CDSUp.Active := False;
                                Params := VarArrayCreate([0,1], varVariant);
                                Params[0] := VarArrayOf(['STATE', 'KN']);
                                Params[1] := VarArrayOf([A, CDS.FieldByName('KN').Value]);
                                Res := DM.RunSQL('Pav306', Params);
                                if Res <> 0 then
                                  begin
                                    Result := False;
                                  end;
                              end;

                         end
                         else
                         begin
                           if (CDS.FieldByName('STATE').AsInteger = 3) or (CDS.FieldByName('STATE').AsInteger = 2) then
                              begin
                                Inc(UsedRecord);
                                CDSUp.Active := False;
                                Params := VarArrayCreate([0,1], varVariant);
                                Params[0] := VarArrayOf(['ID', 'NAME', 'STATE', 'COMMENT', 'ROLES_ID', 'KN']);
                                Params[1] := VarArrayOf([CDS.FieldByName('ID').AsInteger, CDS.FieldByName('NAME').Value, A, CDS.FieldByName('COMMENT').Value, CDS.FieldByName('ROLES_ID').AsInteger, CDS.FieldByName('KN').Value]);
                                Res := DM.RunSQL('Pav307', Params);
                                if Res <> 0 then
                                  begin
                                    Result := False;
                                  end;
                              end;
                         end;
                        except
                         Result := False;
                        end;
                       CDS.Next;
                      end;

                   end;



                3: begin    // для  SQL_CODES
                      CDS.First;
                      CDSQ.Active := False;
                      Params := Null;
                      Res := DM.GetData('Pav301', Params);
                      if not VarIsNull(Res) then
                        begin
                          CDSQ.Data := Res;
                        end;
                      while not CDS.EOF do
                       begin
                               if Central then
                                     begin
                                      A := CDS.FieldByName('STATE').AsInteger;
                                      B := A;
                                     end
                                     else
                                     begin
                                      A := 1;
                                      B := -2;
                                     end;
                        try
                        if CDSQ.Locate('KN',CDS.FieldByName('KN').Value,[loCaseInsensitive]) then
                         begin

                            if (CDS.FieldByName('STATE').AsInteger = 2) then
                               begin
                                Inc(UsedRecord);
                                CDSUp.Active := False;
                                Params := VarArrayCreate([0,1], varVariant);
                                Params[0] := VarArrayOf(['ROLES_ID', 'CHANGE_DATE', 'VERSIA', 'COMMENT', 'SQL', 'STATE', 'SQL_BLOKS_ID', 'KN']);
                                Params[1] := VarArrayOf([CDS.FieldByName('ROLES_ID').AsInteger, CDS.FieldByName('CHANGE_DATE').AsDateTime,
                                                         CDS.FieldByName('VERSIA').AsInteger, CDS.FieldByName('COMMENT').Value,
                                                         CDS.FieldByName('SQL').Value, A, CDS.FieldByName('SQL_BLOKS_ID').AsInteger,
                                                         CDS.FieldByName('KN').Value]);
                                Res := DM.RunSQL('Pav308', Params);
                                if Res <> 0 then
                                  begin
                                    Result := False;
                                  end;
                               end;

                            if (CDS.FieldByName('STATE').AsInteger = -1) then
                               begin
                                Inc(UsedRecord);
                                CDSUp.Active := False;
                                Params := VarArrayCreate([0,1], varVariant);
                                Params[0] := VarArrayOf(['STATE', 'KN']);
                                Params[1] := VarArrayOf([B, CDS.FieldByName('KN').Value]);
                                Res := DM.RunSQL('Pav309', Params);
                                if Res <> 0 then
                                  begin
                                    Result := False;
                                  end;
                               end;

                            if (CDS.FieldByName('STATE').AsInteger = 3) then
                               begin
                                Inc(UsedRecord);
                                CDSUp.Active := False;
                                Params := VarArrayCreate([0,1], varVariant);
                                Params[0] := VarArrayOf(['STATE', 'KN']);
                                Params[1] := VarArrayOf([A, CDS.FieldByName('KN').Value]);
                                Res := DM.RunSQL('Pav309', Params);
                                if Res <> 0 then
                                  begin
                                    Result := False;
                                  end;
                               end;

                         end
                         else
                         begin
                            if (CDS.FieldByName('STATE').AsInteger = 3) or (CDS.FieldByName('STATE').AsInteger = 2) then
                               begin
                                Inc(UsedRecord);
                                CDSUp.Active := False;
                                Params := VarArrayCreate([0,1], varVariant);
                                Params[0] := VarArrayOf(['ID', 'ROLES_ID', 'CHANGE_DATE', 'VERSIA', 'COMMENT', 'SQL', 'STATE', 'SQL_BLOKS_ID', 'KN']);
                                Params[1] := VarArrayOf([CDS.FieldByName('ID').AsInteger, CDS.FieldByName('ROLES_ID').AsInteger,
                                                         CDS.FieldByName('CHANGE_DATE').AsDateTime, CDS.FieldByName('VERSIA').AsInteger,
                                                         CDS.FieldByName('COMMENT').Value, CDS.FieldByName('SQL').Value, A,
                                                         CDS.FieldByName('SQL_BLOKS_ID').AsInteger, CDS.FieldByName('KN').Value]);
                                Res := DM.RunSQL('Pav310', Params);
                                if Res <> 0 then
                                  begin
                                    Result := False;
                                  end;
                               end;
                         end;
                        
                         except
                           Result := False;
                         end;
                         CDS.Next;
                       end;

                   end;


             end;

         Stream2.Clear;

        end;
Result := True;
except
Result := False;
end;

  if Result then
    begin
      //DM.CommTrans;
    end
    else
    begin
      Vsego := 0;
      UsedRecord := 0;
      //DM.BackTrans;
    end;

Stream1.Free;
Stream2.Free;

end;

procedure PrepareOutback(direc, filename: string);
var Vsego: integer;
begin
  Vsego := 0;
  if SaveBackup( form1.ClientDataSet3, form1.Query9, direc, filename, Vsego) then
     begin
      MessageDlg('Количество изменений: ' + IntToStr(Vsego), mtInformation, [mbOK], 0);
      RefreshAll;
     end
     else
      MessageDlg('Данные не сохранены!!!', mtError, [mbOK], 0);
end;

function DateInFilename: string;
var s,s1,s2,ss: string;
    i: Integer;
begin
  ss := '_';
  s1 := DateToStr(Date);

  for i:=1 to length(s1) do
    begin
      s := Copy(DateToStr(Date), i, 1);
      if s <> '.' then ss := ss + s;
    end;
  ss := ss + '_';
  s2 := TimeToStr(Time);

  for i := 1 to Length(s2) do
    begin
      s := Copy(TimeToStr(Time), i, 1);
      if s <> ':' then ss := ss + s;
    end;

  Result := ss;
end;

function GetTablename(s:string):string;
var len,i,posit: integer;
        sa, ss : string;
begin
   len:=length(s);
   posit:=-1;
   ss:='';

   for i:=1 to len do
     begin
       sa:=copy(s,i,4);
         if (sa='from') or
            (sa='into') and
            (posit<>0)  then
            begin
              posit:=i+4;
              if posit>len then posit:=0;
              break;
            end;

       sa:=copy(s,i,6);

          if (sa='update') and (posit<>0)then
            begin
              posit:=i+6;
              if posit>len then posit:=0;
              break;
            end;
     end;

   while (sa<>' ') and (posit<len) do
     begin
        Inc(posit);
        sa:=copy(s,posit,1);
        ss:=ss+trimleft(sa);
     end;
Result:=ss;
end;

procedure TForm1.ApplicationEventsHint(Sender: TObject);
begin
{  with form1.DBEdit3 do
  begin
    if form1.DB_SQLTXT.Connected then
    Hint:='0- Active = false'+#13#10+'1- Active = true'+#13#10+'3- Delete'+#13#10+'2- Edited'+#13#10+'4- Inserted'+#13#10+'5- Deleted'
    else
    Hint:='';
  end; }
end;

procedure TForm1.user_nameKeyPress(Sender: TObject; var Key: Char);
begin
if (Key = #13) and (form1.user_name.Text<>'') then
 begin
  form1.SpeedButton1.Click;
  if form1.SpeedButton1.Down then SpeedButton1.Down:=false
                             else SpeedButton1.Down:=true;


 end;
end;

procedure TForm1.user_passKeyPress(Sender: TObject; var Key: Char);
begin
if (Key = #13) and (form1.user_name.Text<>'') then
 begin
  form1.SpeedButton1.Click;
  if form1.SpeedButton1.Down then SpeedButton1.Down:=false
                             else SpeedButton1.Down:=true;


 end;
end;

procedure TForm1.ClientDataSet1AfterInsert(DataSet: TDataSet);
var s:string;
    i:integer;
begin

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  DoDisable;
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
  if Conn then
    begin
      form1.Enabled := False;
      Opf.Show;
      OperationAction;
    end;
end;

procedure RefreshAll;
begin
  ActiveOperation(form1.CDSOperations);
  FillTree(form1.TreeView1, DM.cds_work, 'id', 'hi_id', 'name', False);
  FillTree(form6.TreeView1, DM.cds_work, 'id', 'hi_id', 'name', True);
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
holdColor: TColor;
i:integer;
begin
holdColor := DBGrid1.Canvas.Brush.Color;
i:=DBGrid1.DataSource.DataSet.FieldByName('state').AsInteger;
if (i<0) then
  begin
    DBGrid1.Canvas.Brush.Color := $005C5CFC;
  end
  else
    DBGrid1.Canvas.Brush.Color := holdcolor;

if  gdSelected   in State then
   begin
      TDBGrid(Sender).Canvas.Brush.Color:= clHighLight;
      TDBGrid(Sender).Canvas.Font.Color := clHighLightText;
   end;

DBGrid1.DefaultDrawColumnCell(Rect,DataCol,Column,State);

end;

procedure TForm1.TabSheet2Show(Sender: TObject);
begin
 if form1.user_name.Text='' then form1.user_name.SetFocus;
end;

procedure TForm1.DSViewUserDataChange(Sender: TObject; Field: TField);
begin
  UserAction;
 if form1.QViewUser.RecordCount>0 then Groups;

end;

procedure TForm1.TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex:=1;
end;

function AddSQLCode(CDS: TClientDataSet): Boolean;
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
           Params[0] := VarArrayOf(['IDPool', 'ROLES_ID', 'VERSIA', 'CHANGE_DATE', 'COMMENT',
                                    'SQL', 'STATE', 'SQL_BLOKS_ID', 'KN']);
           Params[1] := VarArrayOf([IdPool, form1.DBLookupComboBox1.KeyValue,
                                StrToInt(form1.Edit2.Text),
                                Now, form1.Edit1.Text, form1.Memo3.Text, 3,
                                tree_id,
                                form1.user_name.Text + IntToStr(IDPool)]);
             Res := DM.RunSQL('Pav254', Params);
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

    MemID := IDPool;
    RefreshGrid(Form1.CDSSQLCode, Integer(form1.TreeView1.Selected.Data), 0);
    form1.CDSSQLCode.Locate('ID', MemID, [loCaseInsensitive]);
  end;

end;

function DeleteSQLCode(CDS: TClientDataSet; DeltaS: string): Boolean;
var Res, Params: Variant;
begin
  Result := True;
  try
    DM.StartTrans;
    Params := VarArrayCreate([0,1], varVariant);
    Params[0] := VarArrayOf(['STATE', 'COMMENT', 'ID']);
    Params[1] := VarArrayOf([-1, DeltaS, StrToInt(grid_id)]);
    Res := DM.RunSQL('Pav260', Params);
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
    ClearSQLCodeEdit;
    RefreshGrid(Form1.CDSSQLCode, Integer(form1.TreeView1.Selected.Data), 0);
  end;

end;

function ChangeSQLCode(CDS: TClientDataSet): Boolean;
var Res, Params: Variant;
    MemID: string;
begin
 Result := True;
    try
      DM.StartTrans;
     Params := VarArrayCreate([0,1], varVariant);
     Params[0] := VarArrayOf(['ROLES_ID', 'VERSIA', 'CHANGE_DATE', 'COMMENT',
                                    'SQL', 'STATE', 'ID']);
     Params[1] := VarArrayOf([form1.DBLookupComboBox1.KeyValue,
                                StrToInt(form1.Edit2.Text),
                                Now, form1.Edit1.Text, form1.Memo3.Text, 2,
                                StrToInt(grid_id)]);
             Res := DM.RunSQL('Pav259', Params);
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
    MemID := grid_id;
    RefreshGrid(Form1.CDSSQLCode, Integer(form1.TreeView1.Selected.Data), 0);
    form1.CDSSQLCode.Locate('ID', StrToInt(MemID), [loCaseInsensitive]);
  end; 
end;

procedure TForm1.SpeedButton14Click(Sender: TObject);
begin
  if Conn then
    if (form1.Edit1.Text <> '') and
        (form1.Edit2.Text <> '') and
        (form1.DBLookupComboBox1.KeyValue <> 0) and
        (form1.Memo3.Text <> '') and
        (form1.TreeView1.Selected.Text <> 'Блоки:') and
        (form1.CDSSQLCode.Active) then
      begin
        AddSQLCode(DM.cds_work);
      end;
  form1.CheckBox1.Checked := False;
end;

procedure ClearSQLCodeEdit;
begin
 form1.Edit1.Clear;
 form1.Edit2.Clear;
 form1.Edit3.Clear;
 form1.Edit4.Clear;
 form1.Memo3.Clear;
 form1.DBLookupComboBox1.KeyValue := 0;
 form1.CheckListBox1.Clear;
end;

procedure SQLCodeAction;
begin
ClearSQLCodeEdit;
if form1.CDSSQLCode.Active then
  if form1.CDSSQLCode.RecordCount > 0 then
    begin
      form1.DBLookupComboBox1.KeyValue := form1.CDSSQLCode.FieldByName('ROLES_ID').AsInteger;
      form1.Edit2.Text := IntToStr(form1.CDSSQLCode.FieldByName('VERSIA').AsInteger);
      form1.Edit4.Text := DateToStr(form1.CDSSQLCode.FieldByName('CHANGE_DATE').AsDateTime) + ' ' + TimeToStr(form1.CDSSQLCode.FieldByName('CHANGE_DATE').AsDateTime);
      form1.Edit1.Text := form1.CDSSQLCode.FieldByName('COMMENT').AsString;
      form1.Memo3.Text := form1.CDSSQLCode.FieldByName('SQL').Value;
      form1.Edit3.Text := IntToStr(form1.CDSSQLCode.FieldByName('STATE').AsInteger);
      RoleName := form1.DBLookupComboBox1.Text;
      grid_id := form1.CDSSQLCode.FieldByName('ID').AsString;
 end;
end;

procedure TForm1.SpeedButton17Click(Sender: TObject);
begin
  ClearSQLCodeEdit;
end;

procedure TForm1.DSSQLCodeDataChange(Sender: TObject; Field: TField);
begin
  SQLCodeAction;
end;

procedure TForm1.SpeedButton16Click(Sender: TObject);
begin
  if Conn then
    if (form1.CDSSQLCode.RecordCount > 0) and
        (form1.TreeView1.Selected.Text <> 'Блоки:') then
      begin
        ChangeSQLCode(DM.cds_work);
      end;
  form1.CheckBox1.Checked := False;
end;

procedure TForm1.SpeedButton14MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  form1.Label7.Caption := '';
  if (form1.Edit1.Text <> '') and
     (form1.Edit2.Text <> '') and
     (form1.DBLookupComboBox1.KeyValue <> 0) and
     (form1.Memo3.Text <> '') and
     (form1.TreeView1.Selected.Text <> 'Блоки:')then
    begin
      form1.Label7.Caption := 'Добавить:' + #13 +
      form1.Edit1.Text + #13 +
      'в блок' + #13 + form1.TreeView1.Selected.Text;
    end;
end;

procedure TForm1.SpeedButton16MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  form1.Label7.Caption := '';
  if (form1.Edit1.Text <> '') and
     (form1.Edit2.Text <> '') and
     (form1.DBLookupComboBox1.KeyValue <> 0) and
     (form1.Memo3.Text <> '') and
     (form1.TreeView1.Selected.Text <> 'Блоки:') and
     (form1.CDSSQLCode.RecordCount > 0) then
    begin
      form1.Label7.Caption := 'Изменить:' + #13 +
      form1.CDSSQLCode.FieldByName('COMMENT').AsString + ' на ' + form1.Edit1.Text + #13 +
      IntToStr(form1.CDSSQLCode.FieldByName('VERSIA').asInteger) + ' на ' + form1.Edit2.Text + #13 +
      RoleName + ' на ' + form1.DBLookupComboBox1.Text;
    end;
end;

procedure TForm1.Panel11MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 form1.Label7.Caption:='';
end;

procedure TForm1.Memo3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 form1.Label7.Caption:='';
end;

procedure TForm1.Panel3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 form1.Label7.Caption:='';
end;

procedure TForm1.TreeView1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  form1.Label7.Caption:='';
end;

procedure TForm1.GroupBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 form1.Label7.Caption:='';
end;

procedure TForm1.DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  form1.Label7.Caption := '';
end;

procedure TForm1.SpeedButton15MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  form1.Label7.Caption := '';
  if form1.CDSSQLCode.Active then
    if (form1.CDSSQLCode.RecordCount > 0) and
       (form1.TreeView1.Selected.Text <> 'Блоки:') then
      begin
        form1.Label7.Caption := 'Удалить:' + #13 + form1.Edit1.Text;
      end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  AddGroupClick(2);
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var Res, Params: Variant;
begin
  if (form1.CheckListBox1.Count > 0) then
    begin
       try
        DM.StartTrans;
        Params := VarArrayCreate([0,1], varVariant);
        Params[0] := VarArrayOf(['grid_id', 'ITEM_TEXT']);
        Params[1] := VarArrayOf([grid_id, form1.CheckListBox1.Items.Strings[form1.CheckListBox1.ItemIndex]]);
        Res := DM.RunSQL('Pav277', Params);
        if Res <> 0 then
          begin
            DM.BackTrans;
          end
          else
          begin
            DM.CommTrans;
            form1.CheckListBox1.DeleteSelected;
            Rules;
          end;
       except
       end;
    end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if form1.CheckBox1.Checked then
    begin
      form1.SpeedButton14.Enabled := True;
      form1.SpeedButton15.Enabled := True;
      form1.SpeedButton16.Enabled := True;
    end
    else
    begin
      form1.SpeedButton14.Enabled := False;
      form1.SpeedButton15.Enabled := False;
      form1.SpeedButton16.Enabled := False;
    end;
end;

function ValidNumber(fdname, finame: string; CDS: TClientDataSet; var DT: TDateTime; var UpdateNumber: Integer): Boolean;
var List: TStrings;
    Buffer: Char;
    StartDat, CountDat, StartTim, CountTim, StartID, CountID: Integer;
    Stream: TMemoryStream;
    i: Integer;
    Dat, Tim, Number:string;
    LastNumber: Integer;
    Res, Params: Variant;
begin
  Result := False;
  Stream := TMemoryStream.Create;
  List := TStringList.Create;
  Stream.LoadFromFile(fdname);
  List.LoadFromFile(finame);

  try
    Stream.Position := StrToInt(List.Strings[List.Count - 4]);
    CountDat := StrToInt(List.Strings[List.Count - 3]) - StrToInt(List.Strings[List.Count - 4]);
    for i := 1 to CountDat do
      begin
        Stream.Read(Buffer, 1);
        Dat := Dat + Buffer;
      end;

    Stream.Position:=StrToInt(List.Strings[List.Count-3]);
    CountTim:=StrToInt(List.Strings[List.Count-2]) - StrToInt(List.Strings[List.Count-3]);
    for i := 1 to CountTim do
      begin
        Stream.Read(Buffer, 1);
        Tim := Tim + Buffer;
      end;

    DT := StrToDate(Dat) + StrToTime(Tim);

    Stream.Position := StrToInt(List.Strings[List.Count - 2]);
    CountID := StrToInt(List.Strings[List.Count - 1]) - StrToInt(List.Strings[List.Count - 2]);
    for i := 1 to CountID do
      begin
        Stream.Read(Buffer, 1);
        Number := Number + Buffer;
      end;
    UpdateNumber := StrToInt(Number);
    try
      CDS.Active := False;
      Params := Null;
      Res := Dm.GetData('Pav288', Params);
      if not VarIsNull(Res) then
        begin
          CDS.Data := Res;
          LastNumber := CDS.FieldByName('MAX').AsInteger;
          if LastNumber + 1 = UpdateNumber then Result := True;
        end
        else
        begin
          LastNumber := 0;
          if LastNumber + 1 = UpdateNumber then Result := True;
        end;
    except
      Result := False;
    end;
  except
    Result := False;
  end;
  if List.Count < 5 then Result := False;
  Stream.Free;
  List.Free;
end;

procedure SetRegistryIcon;
var Registry:TRegistry;
begin
    Registry:=TRegistry.Create;
    Registry.RootKey:=HKEY_CLASSES_ROOT;
    with Registry do
      begin
       try
       OpenKey('.cds', true);
       WriteString('', 'CreatorCDS');
       CloseKey;
       OpenKey('CreatorCDS', true);
       WriteString('', 'CreatorSQL Backup File');
       CloseKey;
       OpenKey('CreatorCDS\DefaultIcon', true);
       WriteString('', 'C:\WINDOWS\system32\shell32.dll,43');
       CloseKey;

       OpenKey('.cdi', true);
       WriteString('', 'CreatorCDI');
       CloseKey;
       OpenKey('CreatorCDI', true);
       WriteString('', 'CreatorSQL Backup Index File');
       CloseKey;
       OpenKey('CreatorCDI\DefaultIcon', true);
       WriteString('', 'C:\WINDOWS\system32\shell32.dll,208');
       CloseKey;

       OpenKey('.cdp', true);
       WriteString('', 'CreatorCDP');
       CloseKey;
       OpenKey('CreatorCDP', true);
       WriteString('', 'CreatorSQL PoolID File');
       CloseKey;
       OpenKey('CreatorCDP\DefaultIcon', true);
       WriteString('', 'C:\WINDOWS\system32\shell32.dll,104');
       CloseKey;
       except

       end;
      end;

Registry.Free;
end;

procedure AddGroupClick(but:integer);
begin
 if (Conn) and
   (form1.DBGrid1.DataSource.DataSet.RecordCount > 0) then
     begin
       but_number := but;
       Grid;
       Grf.Show;
       Grf.Caption := 'Группы';
       Grf.DBGrid1.Columns.Items[0].Title.Caption := 'Группа';

       ActiveGroup(form1.CDSGroups);

       Grf.Edit1.Visible := False;
       Grf.Edit2.Visible := False;
       Grf.SpeedButton4.Visible := False;
       Grf.CheckBox1.Enabled := False;
       Grf.SpeedButton1.Enabled := True;
       Grf.SpeedButton2.Enabled := False;
     end;
end;


procedure TForm1.CheckViewDelClick(Sender: TObject);
begin
  KeyPre;
end;

function GetPool(CDS: TClientDataSet): Integer;
var Res, Params: Variant;
begin
  Result := 0;
  try
    DM.StartTrans;
    Params := Null;
    Res := DM.GetData('Pav250', Params);
    if not VarIsNull(Res) then
      begin
        CDS.Data := Res;
         if not VarIsNull(CDS.FieldByName('IDPOOL').AsInteger) then
          begin
            Result := CDS.FieldByName('IDPOOL').AsInteger;
            DM.CommTrans;
          end
          else DM.BackTrans;
      end
      else DM.BackTrans;
  except
    Result := 0;
    MessageDlg('Ошибка при получении!', mtError, [mbOK], 0);
 end;
end;

function PutPool: Boolean;
var i: Integer;
    PList: TStringList;
    Save: Integer;
    Res, Params: Variant;
begin
  Result := True;
  PList := TStringList.Create;
  PList.Clear;
  if FileExists(PoolFile) then
    begin
      PList.Sorted := False;
      PList.LoadFromFile(PoolFile);
      DM.StartTrans;

      if PList.Count<>0 then
        for i := 0 to PList.Count - 1 do
          begin
            try
              Save := StrToInt(PList.Strings[i]);
              Params := VarArrayCreate([0, 1], varVariant);
              Params[0] := VarArrayOf(['tSave']);
              Params[1] := VarArrayOf([Save]);
              Res := DM.RunSQL('Pav251', Params);
              if Res <> 0 then Result := False;
            except
              Result := False;
            end;
          end;
    end;
  if Result then
    begin
      DM.CommTrans;
      DeleteFile(PoolFile);
    end
    else DM.BackTrans;

  PList.Free;
end;

function GeneratePoolFile(CountID:integer):boolean;
var i, Save:integer;
    PList:TStringList;
begin
 Result:=true;
  PList:=TStringList.Create;
  PList.Clear;
  if FileExists(PoolFile) then Plist.LoadFromFile(PoolFile);
  for i:= 0 to CountID-1 do
    begin
      Save := GetPool(DM.cds_work);
      if Save<>0 then Plist.Add(IntToStr(Save))
                 else Result:=false;
    end;
 if Result then PList.SaveToFile(PoolFile);
 PList.Free;   
end;

procedure TForm1.SpeedButton18Click(Sender: TObject);
var i:integer;
begin
 try
  i:=StrToInt(form1.PoolMask.Text);
 except
  MessageDlg('Ключи не сохранены!', mtError, [mbOK], 0);
  Exit;
 end;
 if (form1.PoolMask.Text<>'') and (i<>0) then
 if GeneratePoolFile(i) then
  begin
    MessageDlg('Ключи сохранены', mtInformation, [mbOK], 0);
  end
  else
    MessageDlg('Ключи не сохранены!', mtError, [mbOK], 0);

end;

procedure TForm1.SetPool1Click(Sender: TObject);
begin
  if FileExists(PoolFile) then
    begin
      if PutPool = True then MessageDlg('Пул возвращен в базу', mtInformation, [mbOK], 0)
                        else MessageDlg('Невозможно вернуть пул в базу!', mtError, [mbOK], 0);
    end
    else MessageDlg('Пул не выгружен - файл пула не найден.', mtError, [mbOK], 0);
end;

procedure TForm1.GetPool1Click(Sender: TObject);
begin
  form1.Panel12.Visible := True;
end;

procedure TForm1.SpeedButton19Click(Sender: TObject);
begin
  form1.Panel12.Visible := False;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if not GlobalStatus then Connect
                      else Disconnect;
end;

procedure TForm1.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var HoldColor:TColor;
begin

  HoldColor := StatusBar.Canvas.Brush.Color;
  if (form1.SpeedButton1.Down=true) then
  begin
    if Central then form1.StatusBar1.Panels[4].Text:='Источник Пула: '+'БД'
               else
               begin
                if FileExists(PoolFile) then
                 begin
                  LoadPoolTable;
                  form1.StatusBar1.Panels[4].Text:='Источник Пула: '+PoolFile;
                 end
                else
                begin
                 StatusBar.Canvas.Brush.Color := $005C5CFC;
                 LoadPoolTable;
                 form1.StatusBar1.Panels[4].Text:='Источник Пула: '+'Файл не найден!';
                end;
               end;
  end
  else
  begin
     StatusBar.Canvas.Brush.Color := HoldColor;
     form1.StatusBar1.Panels[4].Text:='Источник Пула: ';
  end;

  StatusBar.Canvas.TextOut(Rect.left,Rect.Top,Panel.Text);
end;

procedure LoadPoolTable;
begin
  if FileExists(PoolFile) then
    begin
      PoolTable.LoadFromFile(PoolFile);
      form1.Label9.Caption := IntToStr(PoolTable.Count);
    end
    else
      form1.Label9.Caption := '0';
end;

procedure SavePoolTable;
begin
 PoolTable.SaveToFile(PoolFile);
end;

function UseOnePoolID:integer;
begin
 PoolTable.Clear;
 LoadPoolTable;
 if PoolTable.Count > 0 then
   begin
     Result := StrToInt(PoolTable.Strings[0]);
   end
   else
     Result := 0;
end;

procedure TForm1.SpeedButton20Click(Sender: TObject);
begin
  if Conn then FindCode(DM.cds_work, Form1.FindEdit.Text);
end;

procedure FindCode(CDS: TClientDataSet; KN: string);
var i: Integer;  Res, Params: Variant;
begin
if Length(KN) > 0 then
if form1.TreeView1.Items.Count > 1 then
  begin
    try
      CDS.Active := False;
      Params := VarArrayCreate([0, 1], varVariant);
      Params[0] := VarArrayOf(['kn']);
      Params[1] := VarArrayOf([KN]);
      Res := DM.GetData('Pav247', Params);
      if not VarIsNull(Res) then
        begin
          CDS.Data := Res;
          if CDS.RecordCount > 0 then

                for i := 0 to Form1.TreeView1.Items.Count -1 do
                  begin
                    if Integer(Form1.TreeView1.Items.Item[i].Data) = CDS.FieldByName('sql_bloks_id').AsInteger then
                      begin
                        if CDS.FieldByName('state').AsInteger > 0 then
                          begin
                            form1.CheckViewDel.Checked := False;
                            Form1.TreeView1.Items.Item[i].Selected := True;
                            KeyPre;
                            Form1.CDSSQLCode.Locate('KN', Form1.FindEdit.Text, [loCaseInsensitive]);
                            Rules;
                            Break;
                          end
                          else
                          begin
                            form1.CheckViewDel.Checked := True;
                            Form1.TreeView1.Items.Item[0].Selected := True;
                            KeyPre;
                            Form1.CDSSQLCode.Locate('KN', Form1.FindEdit.Text, [loCaseInsensitive]);
                            Rules;
                            Break;
                          end;

                      end;
                  end;
              end
              else
                MessageDlg('SQL c KN = ' + KN + ' не найден.', mtInformation, [mbOk], 0);

    except
    end;
  end;
end;

procedure TForm1.FindEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Conn then
    if Key = VK_RETURN then FindCode(DM.cds_work, Form1.FindEdit.Text);
end;

procedure ActiveRole(CDS: TClientDataSet);
var Res, Params: Variant;
begin
  try
    CDS.Active := False;
    Params := Null;
    Res := DM.GetData('Pav249', Params);
    if not VarIsNull(Res) then
      begin
        CDS.Data := Res;
      end;
  except

  end;
end;

procedure ActiveGroup(CDS: TClientDataSet);
var Res, Params: Variant;
begin
  try
      CDS.Active := False;
      Params := Null;
      Res := DM.GetData('Pav252', Params);
      if not VarIsNull(Res) then
        begin
          CDS.Data := Res;
        end;
  except

  end;
end;

procedure ActiveUser(CDS: TClientDataSet);
var Res, Params: Variant;
begin
  try
      CDS.Active := False;
      Params := Null;
      Res := DM.GetData('Pav253', Params);
      if not VarIsNull(Res) then
        begin
          CDS.Data := Res;
        end;
  except

  end;
end;

procedure ActiveOperation(CDS: TClientDataSet);
var Res, Params: Variant;
begin
  try
    CDS.Active := False;
    Params := Null;
    Res := DM.GetData('Pav266', Params);
    if not VarIsNull(Res) then
      begin
        CDS.Data := Res;
      end;
  except

  end;
end;

procedure DoEnable;
begin
  form1.MainMenu1.Items.Items[0].Enabled := True;
  form1.ToolButton1.Enabled := True;
  form1.ToolButton4.Enabled := True;
  form1.ToolButton6.Enabled := True;
  form1.ToolButton8.Enabled := True;
  form1.ToolButton2.Enabled := True;
  form1.TabSheet1.Enabled := True;
  form1.PoolMask.Enabled := True;
  form1.SpeedButton18.Enabled := True;
  form1.SpeedButton2.Enabled := True;
  form1.SpeedButton3.Enabled := True;
  form1.SpeedButton4.Enabled := True;
  form1.SpeedButton5.Enabled := True;
  form1.Edit2.Enabled := True;
  form1.FindEdit.Enabled := True;
  form1.SpeedButton20.Enabled := True;
  form1.Memo3.Enabled := True;
  form1.SpeedButton17.Enabled := True;
  form1.SpeedButton13.Enabled := True;
  form1.Edit1.Enabled := True;
  form1.CheckBox1.Enabled := True;
  form1.CheckViewDel.Enabled := True;
  form1.DBLookupComboBox1.Enabled := True;
  form1.TreeView1.Enabled := True;
  form1.DBGrid1.Enabled := True;
end;

procedure DoDisable;
begin
  form1.MainMenu1.Items.Items[0].Enabled := False;
  form1.ToolButton1.Enabled := False;
  form1.ToolButton4.Enabled := False;
  form1.ToolButton6.Enabled := False;
  form1.ToolButton8.Enabled := False;
  form1.ToolButton2.Enabled := False;
  form1.TabSheet1.Enabled := False;
  form1.PoolMask.Enabled := False;
  form1.SpeedButton18.Enabled := False;
  form1.SpeedButton2.Enabled := False;
  form1.SpeedButton3.Enabled := False;
  form1.SpeedButton4.Enabled := False;
  form1.SpeedButton5.Enabled := False;
  form1.Edit2.Enabled := False;
  form1.FindEdit.Enabled := False;
  form1.SpeedButton20.Enabled := False;
  form1.Memo3.Enabled := False;
  form1.SpeedButton17.Enabled := False;
  form1.SpeedButton13.Enabled := False;
  form1.Edit1.Enabled := False;
  form1.CheckBox1.Enabled := False;
  form1.CheckViewDel.Enabled := False;
  form1.DBLookupComboBox1.Enabled := False;
  form1.TreeView1.Enabled := False;
  form1.DBGrid1.Enabled := False;
  form1.CDSSQLCode.Close;
  form1.CDSRules.Close;
  form1.CDSRoles.Close;
  form1.CDSGroups.Close;
  form1.CDSUsers.Close;
  form1.CDSOperations.Close;
  form1.CDSExplorer.Close;
  form1.MainMenu1.Items.Items[1].Enabled := False;
end;


end.
