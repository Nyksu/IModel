unit Limit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, DBClient, CheckLst;

type  TMes = record
         UserCount: string;
         SummPower: string;
    ExcelItemCount: string;
          MapCount: string;
TemplateInMapCount: string;
         CalcUnits: string;
      end;

type
  TLimitForm = class(TForm)
    BasePanel: TPanel;
    OriginalEdit: TEdit;
    OriginLabel: TLabel;
    LimitCheckBox: TCheckBox;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Label5: TLabel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    SaveBt: TButton;
    CheckList: TCheckListBox;
    Label6: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LimitCheckBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveBtClick(Sender: TObject);
  private
    { Private declarations }
    function TestEdits: Integer;
    function SaveEdits: Integer;
    function GetEdits: Integer;
    procedure FillEdits;
    function GenerateLim: string;
    function get_one(one:string):TMes;
    function LimitTrue(M: TMes): Boolean;
  public
    { Public declarations }
  end;

var
  LimitForm: TLimitForm;
  OCDS: TClientDataSet;

implementation
uses DCPMain, DMmodel;
{$R *.dfm}

function TLimitForm.TestEdits: Integer;
var TestInt: Integer;
          i: Integer;
begin
  Result := 1;
  try
    if LimitCheckBox.Checked then
      begin
        TestInt := StrToInt(Edit1.Text);
        TestInt := StrToInt(Edit2.Text);
        TestInt := StrToInt(Edit3.Text);
        TestInt := StrToInt(Edit4.Text);
        TestInt := StrToInt(Edit5.Text);
        if StrToInt(Edit1.Text) < 0 then Result := -1;
        if StrToInt(Edit2.Text) < 0 then Result := -1;
        if StrToInt(Edit3.Text) < 0 then Result := -1;
        if StrToInt(Edit4.Text) < 0 then Result := -1;
        if StrToInt(Edit5.Text) < 0 then Result := -1;
      end;
    if OriginalEdit.Text = '' then
      begin
        Result := -1;
      end;
  except
    Result := -1;
  end;
end;

function TLimitForm.GenerateLim: string;
var Lim, M: string;
      i: Integer;
begin
  if LimitCheckBox.Checked then
    begin
      M := '';
      for i := 0 to CheckList.Count - 1 do
        begin
          if CheckList.Checked[i] then M := M + '1'
                                  else M := M + '0';
        end;
      Lim := '|'+Edit1.Text+'|'+Edit2.Text+'|'+Edit3.Text+
             '|'+Edit4.Text+'|'+Edit5.Text+'|'+M+'|';

    end
    else
    begin
      Lim := '|0|0|0|0|0|0|';
    end;
  Result := EncryptString(Lim, OriginalEdit.Text);
end;

procedure TLimitForm.SaveBtClick(Sender: TObject);
begin
  DM.StartTrans;
  if TestEdits = 1 then
    begin
      if SaveEdits = 1 then
        begin
          DM.CommTrans;
          ModalResult := mrOk;
        end
        else DM.BackTrans;
    end
    else
    begin
      DM.BackTrans;
      MessageDlg('Не пройден тест полей.', mtError, [mbOk], 0);
    end;
end;

function TLimitForm.SaveEdits: Integer;
var Params, Res: Variant;
begin
  Result := -1;
  try
    Params := VarArrayCreate([0,1], varVariant);
    Params[0] := VarArrayOf(['NAME', 'LIM']);
    Params[1] := VarArrayOf([OriginalEdit.Text, GenerateLim]);
    Res := DM.RunSQL('Pavel1699', Params);
    if Res = 0 then
      begin
        Result := 1;
      end;
  except
    Result := -1;
  end;
end;

function TLimitForm.GetEdits: Integer;
var Params, Res: Variant;
begin
  Result := -1;
  try
    Params := Null;
    Res := DM.GetData('Pavel1700', Params);
    if not VarIsNull(Res) then
      begin
        OCDS.Data := Res;
        Result := 1;
      end;
  except
    Result := -1;
  end;
end;

function TLimitForm.LimitTrue(M: TMes): Boolean;
var i: Integer;
begin
  Result := False;
  if M.UserCount <> '0' then Result := True;
  if M.SummPower <> '0' then Result := True;
  if M.ExcelItemCount <> '0' then Result := True;
  if M.MapCount <> '0' then Result := True;
  if M.TemplateInMapCount <> '0' then Result := True;
  if M.CalcUnits <> '0' then Result := True;
end;

procedure TLimitForm.FillEdits;
var Lim: string;
     Me: TMes;
      i: Integer;
begin
  OriginalEdit.Text := OCDS.FieldByName('orgrite').AsString;
  Lim := DecryptString(OCDS.FieldByName('keylist').AsString, OriginalEdit.Text);
  Me := get_one(Lim);
  if LimitTrue(Me) then
    begin
      LimitCheckBox.Checked := True;
      Panel1.Enabled := True;
    end
    else
    begin
      LimitCheckBox.Checked := False;
      Panel1.Enabled := False;
    end;
  
  Edit1.Text := Me.UserCount;
  Edit2.Text := Me.SummPower;
  Edit3.Text := Me.ExcelItemCount;
  Edit4.Text := Me.MapCount;
  Edit5.Text := Me.TemplateInMapCount;
  for i := 0 to Length(Me.CalcUnits) - 1 do
    begin
      if Me.CalcUnits[i+1] = '1' then CheckList.Checked[i] := True
                               else CheckList.Checked[i] := False;
    end;
end;

procedure TLimitForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ModalResult := mrOk;
end;

procedure TLimitForm.FormCreate(Sender: TObject);
begin
  OCDS := TClientDataSet.Create(nil);
end;

procedure TLimitForm.FormShow(Sender: TObject);
begin
  if GetEdits = 1 then
    begin
      FillEdits;
    end;
end;

procedure TLimitForm.LimitCheckBoxClick(Sender: TObject);
begin
  if Panel1.Enabled then Panel1.Enabled := False
                    else Panel1.Enabled := True;
end;

function TLimitForm.get_one(one:string):TMes;
var k,g,st:integer;
    po:integer;
    s,s2:string;
    relt:TMes;
begin

 s:='';
 po:=pos('=', one);
 g:=length(one);
 one:=copy(one,po+1,g);
 g:=length(one);
 st:=0;

          for k:=1 to g do
             begin
               s2:=copy(one,k,1);
               if s2='|' then
                   begin
                     inc(st);
                        if st=2 then
                          begin
                           relt.UserCount:=s;
                          end
                          else
                        if st=3 then
                          begin
                           relt.SummPower:=s;
                          end
                          else
                        if st=4 then
                          begin
                           relt.ExcelItemCount:=s;
                          end
                          else
                        if st=5 then
                          begin
                           relt.MapCount:=s;
                          end
                          else
                        if st=6 then
                          begin
                           relt.TemplateInMapCount:=s;
                          end;
                        if st=7 then
                          begin
                           relt.CalcUnits:=s;
                          end;
                     s:='';

                   end
                   else s:=s+copy(one,k,1);
          end;

 Result:=relt;
end;

end.
