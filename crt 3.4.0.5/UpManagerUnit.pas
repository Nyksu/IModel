unit UpManagerUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, ImgList, DB, DBClient;

type
  TUpManagerForm = class(TForm)
    BasePanel: TPanel;
    Report: TListView;
    ButPanel: TPanel;
    OpenButton: TSpeedButton;
    MemoLog: TMemo;
    HomeImage: TImage;
    LocalImage: TImage;
    StartButton: TSpeedButton;
    ExitButton: TSpeedButton;
    LocLabel: TLabel;
    CurLabel: TLabel;
    Progress: TProgressBar;
    GroupBox1: TGroupBox;
    PanelColour: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog: TOpenDialog;
    procedure OpenButtonClick(Sender: TObject);
    procedure ReportColumnClick(Sender: TObject; Column: TListColumn);
    procedure ExitButtonClick(Sender: TObject);
    procedure ReportCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure StartButtonClick(Sender: TObject);
    procedure ReportClick(Sender: TObject);
    procedure ReportDblClick(Sender: TObject);
    procedure ReportMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    procedure AddToReport(Number, FName, Routine, RecCount: string);
  public
    { Public declarations }

  end;

var
  UpManagerForm: TUpManagerForm;
  AllChecked: Boolean;
  MaxProgress: Integer;
  LastNumber: Integer;
  PrimeState: Byte;
  procedure CreateUpManager;
  function Prime(CDS: TClientDataSet; var Name: string): Integer;
  function LastUpdateNumber: Integer;
  function PacketSource(FullName: string): string;
  function PacketSize(FullName: string): Integer;
  function PacketNumber(FullName: string): string;
  function GetMaxProgress: Integer;
  function Recur(Number: Integer): Integer;
  function ExecuteImport: Integer;
//  function NewImport: Integer;
  function NewLoadBackup(FullName: string): Integer;
  function GetNeedItemIndex(Number: Integer): Integer;
  function SetNewLastNumber(Number: Integer): Integer;
  procedure CorrectionExecute;
  function SeriesTrue(Number: Integer): Boolean;
  function HaveLink(Number: Integer): Boolean;
  function DeleteAllRulesS: Integer;
  function DeleteAllRulesO: Integer;

implementation

uses DMmodel;

{$R *.dfm}

procedure CreateUpManager;
var s: string;
begin
  Application.CreateForm(TUpManagerForm, UpManagerForm);
  AllChecked := False;
  s := '';
  PrimeState := Prime(DM.cds_work, s);
  if PrimeState = 1 then
    begin
      UpManagerForm.HomeImage.Visible := True;
      UpManagerForm.LocLabel.Caption := 'Центральная БД';
    end
    else
    begin
      UpManagerForm.LocalImage.Visible := True;
      UpManagerForm.LocLabel.Caption := 'Локальная БД';
    end;
  LastNumber := LastUpdateNumber;
  UpManagerForm.CurLabel.Caption := 'Последний пакет - ' + IntToStr(LastNumber);
  UpManagerForm.ShowModal;
  UpManagerForm.Free;
end;

procedure TUpManagerForm.ExitButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TUpManagerForm.OpenButtonClick(Sender: TObject);
var i: Integer;
    FullName: string;
    Number: string;
    Routine: string;
    RecCount: Integer;
begin
  Report.Clear;
  MaxProgress := 0;
  if OpenDialog.Execute then
    begin
      if OpenDialog.Files.Count > 0 then
        begin
          AllChecked := False;
          for i := 0 to OpenDialog.Files.Count - 1 do
            begin
              FullName := OpenDialog.Files.Strings[i];
              RecCount := PacketSize(FullName);
              MaxProgress := MaxProgress + RecCount;
              AddToReport(PacketNumber(FullName), FullName, PacketSource(FullName), IntToStr(RecCount));
            end;
          Progress.Max := MaxProgress;
        end;
    end;
  CorrectionExecute;
end;

function GetMaxProgress: Integer;
var i: Integer;
begin
  Result := 0;
  try
    for i := 0 to UpManagerForm.Report.Items.Count - 1 do
      begin
        if UpManagerForm.Report.Items.Item[i].Checked then
          begin
            Result := Result + StrToInt(UpManagerForm.Report.Items.Item[i].SubItems[3]);
          end;
      end;
  except
    Result := 0;
  end;
end;

function Recur(Number: Integer): Integer;
var i: Integer;
    Yes: Boolean;
begin
  Yes := False;
  try
    for i := 0 to UpManagerForm.Report.Items.Count - 1 do
      begin
        if UpManagerForm.Report.Items.Item[i].SubItems[0] = IntToStr(Number) then
          begin
            Yes := True;
            Break;
          end;
      end;
    if Yes then
      begin
        Number := Number - 1;
        Result := Recur(Number)
      end
      else
      begin
        Result := Number;
      end;
  except

  end;
end;

procedure CorrectionExecute;
var Index: Integer;
begin
  Application.ProcessMessages;
  Index := GetNeedItemIndex(LastNumber + 1);
  if (Index <> -1) and (UpManagerForm.Report.Items.Item[Index].Checked) then
    begin
      UpManagerForm.StartButton.Visible := True;
    end
    else UpManagerForm.StartButton.Visible := False;
end;

procedure TUpManagerForm.ReportClick(Sender: TObject);
begin
  Application.ProcessMessages;
  CorrectionExecute;
end;

procedure TUpManagerForm.ReportColumnClick(Sender: TObject;
  Column: TListColumn);
var i: Integer;
begin
  if Column.Index = 0 then
    begin
      for i := 0 to OpenDialog.Files.Count - 1 do
        begin
          if not AllChecked then
            begin
              Report.Items.Item[i].Checked := True;
            end
            else
            begin
              Report.Items.Item[i].Checked := False;
            end;
        end;
      if not AllChecked then
        begin
          AllChecked := True;
        end
        else
        begin
          AllChecked := False;
        end;
    end;
  CorrectionExecute;
end;

function SeriesTrue(Number: Integer): Boolean;
begin
  Result := False;
  if Number <= LastNumber then
    begin
      Result := False;
      Exit;
    end
    else
    begin
      if Number = LastNumber + 1  then
        begin
          Result := True;
          Exit;
        end
        else
        begin
          Result := HaveLink(Number);
        end;
    end;
end;

function HaveLink(Number: Integer): Boolean;
var i: Integer;
    LastN: Integer;
    Ext: Boolean;
begin
  Result := False;
  LastN := LastNumber;
  Ext := False;
  while Ext <> True do
    begin
      Inc(LastN);
      Ext := True;
      for i := 0 to UpManagerForm.Report.Items.Count - 1 do
        begin
          if UpManagerForm.Report.Items.Item[i].SubItems[0] = IntToStr(LastN) then
            begin
              Ext := False;
              Break;
            end;
        end;
      if LastN = Number then
        begin
          Result := True; 
          Ext := True;
        end;
    end;
end;

procedure TUpManagerForm.ReportCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var HoldColor: TColor;
begin
  if PrimeState = 0 then
    begin
      HoldColor := Report.Canvas.Brush.Color;
      if Item.SubItems[0] <> 'Нет' then
        begin
          if SeriesTrue(StrToInt(Item.SubItems[0])) then
          //if Recur(StrToInt(Item.SubItems[0])) = LastNumber+1 then
            begin
              Report.Canvas.Brush.Color := 12581586;
              Item.Checked := True;
            end
            else
            begin
              Report.Canvas.Brush.Color := HoldColor;
              Item.Checked := False;
            end;
          if StrToInt(Item.SubItems[0]) <= LastNumber then
            begin
              Report.Canvas.Brush.Color := 14796729;
            end;
        end
        else
        begin
          Report.Canvas.Brush.Color := HoldColor;
          Item.Checked := False;
        end;
    end;
  if PrimeState = 1 then
    begin
      HoldColor := Report.Canvas.Brush.Color;
      if Item.SubItems[0] = 'Нет' then
        begin
          Report.Canvas.Brush.Color := 12581586;
        end
        else
        begin
          Report.Canvas.Brush.Color := HoldColor;
        end;
    end;
end;

procedure TUpManagerForm.ReportDblClick(Sender: TObject);
begin
  Application.ProcessMessages;
  CorrectionExecute;
end;

procedure TUpManagerForm.ReportMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Application.ProcessMessages;
  CorrectionExecute;
end;

procedure TUpManagerForm.StartButtonClick(Sender: TObject);
begin
  ExecuteImport;
  CorrectionExecute;
end;

function ExecuteImport: Integer;
var Checked: Boolean;
    Index: Integer;
    FullName: string;
    TotalRes: Integer;
    i: Integer;
begin
  Result := -1;
  UpManagerForm.Report.Enabled := False;
  UpManagerForm.MemoLog.Lines.Clear;
  if PrimeState = 0 then
    begin
      Checked := True;
      MaxProgress := GetMaxProgress;
      UpManagerForm.Progress.Max := MaxProgress;
      UpManagerForm.MemoLog.Lines.Add('Процесс запущен.');
      TotalRes := 1;
      while Checked do
        begin
          Index := GetNeedItemIndex(LastNumber + 1);
          if Index <> -1 then
            begin
              FullName := TstringList(UpManagerForm.Report.Items.Item[Index].Data).Strings[0];
              DM.StartTrans;
              if NewLoadBackup(FullName) = 1 then
                begin
                  Inc(LastNumber);
                  SetNewLastNumber(LastNumber);
                  DM.CommTrans;
                  LastNumber := LastUpdateNumber;
                  UpManagerForm.CurLabel.Caption := 'Последний пакет - ' + IntToStr(LastNumber);
                  UpManagerForm.MemoLog.Lines.Add('Пакет ' + IntToStr(LastNumber) + ' успешно установлен.');
                end
                else
                begin
                  DM.BackTrans;
                  UpManagerForm.MemoLog.Lines.Add('[Ошибка] Пакет ' + IntToStr(LastNumber+1) + ' не установлен.');
                  UpManagerForm.MemoLog.Lines.Add('Процесс остановлен.');
                  Checked := False;
                  TotalRes := -1;
                  Break;
                end;
            end
            else Checked := False;
        end;
      UpManagerForm.Progress.Position := 0;
      UpManagerForm.Progress.Max := 0;
      UpManagerForm.MemoLog.Lines.Add('Процесс закончен.');
    end;

  if PrimeState = 1 then
    begin

      MaxProgress := GetMaxProgress;
      UpManagerForm.Progress.Max := MaxProgress;
      TotalRes := 1;
      UpManagerForm.MemoLog.Lines.Add('Процесс запущен.');

          for i := 0 to UpManagerForm.Report.Items.Count - 1 do
            begin
              if (UpManagerForm.Report.Items.Item[i].Checked) then
                begin
                  if (UpManagerForm.Report.Items.Item[i].SubItems[0] = 'Нет') then
                    begin
                      FullName := TstringList(UpManagerForm.Report.Items.Item[i].Data).Strings[0];
                      DM.StartTrans;
                      if NewLoadBackup(FullName) = 1 then
                        begin
                          DM.CommTrans;
                          UpManagerForm.MemoLog.Lines.Add('Пакет ' + UpManagerForm.Report.Items.Item[i].SubItems[1] + ' успешно установлен.');
                          UpManagerForm.Report.Items.Item[i].Checked := False;
                        end
                        else
                        begin
                          DM.BackTrans;
                          UpManagerForm.MemoLog.Lines.Add('[Ошибка] Пакет ' + UpManagerForm.Report.Items.Item[i].SubItems[1] + ' не установлен.');
                          TotalRes := -1;
                        end;
                    end
                    else
                    begin
                      UpManagerForm.MemoLog.Lines.Add('[Информация] Пакет ' + UpManagerForm.Report.Items.Item[i].SubItems[1] + ' не обработан.');
                      UpManagerForm.Report.Items.Item[i].Checked := False;
                    end;
                end;
            end;
      UpManagerForm.Progress.Position := 0;
      UpManagerForm.Progress.Max := 0;
      UpManagerForm.MemoLog.Lines.Add('Процесс закончен.');
    end;

  UpManagerForm.Report.Enabled := True;
end;

function SetNewLastNumber(Number: Integer): Integer;
var Res, Params: Variant;
begin
  Result := -1;
  try
    Params := VarArrayCreate([0,1], varVariant);
    Params[0] := VarArrayOf(['ID', 'DAT']);
    Params[1] := VarArrayOf([Number, Now]);
    Res := DM.RunSQL('Pav289', Params);
    if Res <> 0 then
      begin
        Result := -1;
      end
      else
      begin
        Result := 1;
      end;
  except
    Result := -1;
  end;
end;

function GetNeedItemIndex(Number: Integer): Integer;
var i: Integer;
begin
  Result := -1;
  if PrimeState = 0 then
    begin
      for i := 0 to UpManagerForm.Report.Items.Count - 1 do
        begin
          if UpManagerForm.Report.Items.Item[i].SubItems[0] = IntToStr(Number) then
            begin
              if UpManagerForm.Report.Items.Item[i].Checked then
                begin
                  Result := i;
                end;
              Break;
            end;
        end;
    end;
  if PrimeState = 1 then
    begin
      for i := 0 to UpManagerForm.Report.Items.Count - 1 do
        begin
          if (UpManagerForm.Report.Items.Item[i].SubItems[0] = 'Нет') and
             (UpManagerForm.Report.Items.Item[i].Checked) then
            begin
              Result := i;
              Break;
            end;
        end;
    end;
end;

procedure TUpManagerForm.AddToReport(Number, FName, Routine, RecCount: string);
var ShortName: string;
    s: TStringList;
begin
  s := TStringList.Create;
  s.Add(FName);
  ShortName := ExtractFileName(FName);
  Report.AddItem('', s);
  Report.Items.Item[Report.Items.Count-1].SubItems.Add(Number);
  Report.Items.Item[Report.Items.Count-1].SubItems.Add(ShortName);
  Report.Items.Item[Report.Items.Count-1].SubItems.Add(Routine);
  Report.Items.Item[Report.Items.Count-1].SubItems.Add(RecCount);
end;

function Prime(CDS: TClientDataSet; var Name: string): Integer;
var Res, Params: Variant;
begin
  Result := -1;
  Name := '';
    try
      CDS.Active := False;
      Params := Null;
      Res := DM.GetData('Pav240', Params);
      if not VarIsNull(Res) then
        begin
          CDS.Data := Res;
        end;
      if CDS.FieldByName('PRIME').AsInteger = 1 then Result := 1
                                                else Result := 0;
      Name:=CDS.FieldByName('NAME').AsString;
    except
      Result := -1;
    end;
end;

function LastUpdateNumber: Integer;
var Res, Params: Variant;
    CDS: TClientDataSet;
begin
  Result := -1;
  CDS := TClientDataSet.Create(nil);
  try
    Params := Null;
    Res := Dm.GetData('Pav288', Params);
    if not VarIsNull(Res) then
      begin
        CDS.Data := Res;
        Result := CDS.FieldByName('MAX').AsInteger;
      end;
  except
    Result := -1;
  end;
  CDS.Free;
end;

function PacketSource(FullName: string): string;
var IndexFile: string;
    List: TStrings;
begin
  Result := '';
  List := TStringList.Create;
  try
    IndexFile := Copy(FullName, 1, Length(FullName) - 4) + '.cdi';
    List.LoadFromFile(IndexFile);
    if List.Count < 5 then
      begin
        Result := 'Локальная БД';
      end
      else
      begin
        Result := 'Центральная БД';
      end;
  except

  end;
  List.Free;
end;

function PacketSize(FullName: string): Integer;
var Stream1, Stream2: TMemoryStream;
    i: Integer;
    f: TextFile;
    s1, s2: string;
    CDS: TClientDataSet;
begin
  Result := 0;
  Stream1 := TMemoryStream.Create;
  Stream2 := TMemoryStream.Create;
  CDS := TClientDataSet.Create(nil);
  try
    Stream1.LoadFromFile(FullName);
    AssignFile(f, Copy(FullName, 1, Length(FullName) - 4) + '.cdi');

    Reset(f);
    ReadLn(f, s1);

    for i := 1 to 6 do
      begin
        ReadLn(f, s2);
        Stream1.Position := StrToInt(s1);
        Stream2.CopyFrom(Stream1, StrToInt(s2) - StrToInt(s1));

        s1 := s2;

        Stream2.Position := 0;
        CDS.LoadFromStream(Stream2);
        Result := Result + CDS.RecordCount;
        Stream2.Clear;
      end;
  except
    Result := 0;
  end;
  Stream1.Free;
  Stream2.Free;
  CDS.Free;
end;

function PacketNumber(FullName: string): string;
var IndexFile: string;
    List: TStrings;
    Stream: TMemoryStream;
    CountID: Integer;
    i: Integer;
    Buffer: Char;
    Number: string;
begin
  Result := 'Ошибка';
  List := TStringList.Create;
  Stream := TMemoryStream.Create;
  try
    IndexFile := Copy(FullName, 1, Length(FullName) - 4) + '.cdi';
    List.LoadFromFile(IndexFile);
    if List.Count >= 5 then
      begin
        Stream.LoadFromFile(FullName);
        Stream.Position := StrToInt(List.Strings[List.Count - 2]);
        CountID := StrToInt(List.Strings[List.Count - 1]) - StrToInt(List.Strings[List.Count - 2]);
        for i := 1 to CountID do
          begin
            Stream.Read(Buffer, 1);
            Number := Number + Buffer;
          end;
        if Number <> '' then
          begin
            Result := Number;
          end;
      end
      else
      begin
        Result := 'Нет';
      end;
  except
    Result := 'Ошибка';
  end;
  List.Free;
  Stream.Free;
end;

function NewLoadBackup(FullName: string): Integer;
var Stream1, Stream2: TMemoryStream;
    f: TextFile;
    s1,s2: string;
    tr: TStringList;
    i: Integer;
    r: Integer;
    VCount, UCount: Integer;
    A,B: Integer;
    Res, Params: Variant;
    CDS, CDSQ,  CDSUp: TClientDataSet;
    Sql_Codes, Sql_Groups, Sql_Operations: TClientDataSet;
    ID1, ID2, STATE: Integer;
begin
  Result := 1;
  try
    Stream1 := TMemoryStream.Create;
    Stream2 := TMemoryStream.Create;

    CDS := TClientDataSet.Create(nil);
    CDSQ := TClientDataSet.Create(nil);
    CDSUp := TClientDataSet.Create(nil);

    Sql_Codes := TClientDataSet.Create(nil);
    Sql_Groups := TClientDataSet.Create(nil);
    Sql_Operations := TClientDataSet.Create(nil);

    VCount := 0;
    UCount := 0;
    Stream1.LoadFromFile(FullName);
    AssignFile(f, Copy(FullName, 1, Length(FullName) - 4) + '.cdi');

    Reset(f);
    ReadLn(f, s1);

    for i := 1 to 6 do
      begin
        ReadLn(f, s2);
        Stream1.Position := StrToInt(s1);
        Stream2.CopyFrom(Stream1, StrToInt(s2) - StrToInt(s1));

        s1 := s2;

        Stream2.Position := 0;
        CDS.LoadFromStream(Stream2);
        Application.ProcessMessages;

        case i of
             // для SQL_BLOKS
          1:  begin
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
                    if PrimeState = 1 then
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
                      UpManagerForm.Progress.Position := UpManagerForm.Progress.Position + 1;
                      if  CDSQ.Locate('KN', CDS.FieldByName('KN').Value, [loCaseInsensitive]) then
                        begin
                          if (CDS.FieldByName('STATE').AsInteger = 2) then
                            begin
                              CDSUp.Active := False;
                              Params := VarArrayCreate([0,1], varVariant);
                              Params[0] := VarArrayOf(['NAME', 'STATE', 'HI_ID', 'KN']);
                              Params[1] := VarArrayOf([CDS.FieldByName('NAME').Value, A, CDS.FieldByName('HI_ID').AsInteger, CDS.FieldByName('KN').Value]);
                              Res := DM.RunSQL('Pav302', Params);
                              if Res <> 0 then
                                begin
                                  Result := -1;
                                end;
                            end;
                          if (CDS.FieldByName('STATE').AsInteger = -1) then
                            begin
                              CDSUp.Active := False;
                              Params := VarArrayCreate([0,1], varVariant);
                              Params[0] := VarArrayOf(['STATE', 'KN']);
                              Params[1] := VarArrayOf([B, CDS.FieldByName('KN').Value]);
                              Res := DM.RunSQL('Pav303', Params);
                              if Res <> 0 then
                                begin
                                  Result := -1;
                                end;
                            end;
                           if (CDS.FieldByName('STATE').AsInteger = 3) then
                              begin
                              CDSUp.Active := False;
                              Params := VarArrayCreate([0,1], varVariant);
                              Params[0] := VarArrayOf(['STATE', 'KN']);
                              Params[1] := VarArrayOf([A, CDS.FieldByName('KN').Value]);
                              Res := DM.RunSQL('Pav303', Params);
                              if Res <> 0 then
                                begin
                                  Result := -1;
                                end;
                              end;
                         end
                         else
                         begin
                           if (CDS.FieldByName('STATE').AsInteger = 3) or (CDS.FieldByName('STATE').AsInteger = 2) then
                              begin
                              CDSUp.Active := False;
                              Params := VarArrayCreate([0,1], varVariant);
                              Params[0] := VarArrayOf(['ID', 'NAME', 'STATE', 'HI_ID', 'KN']);
                              Params[1] := VarArrayOf([CDS.FieldByName('ID').AsInteger, CDS.FieldByName('NAME').Value, A, CDS.FieldByName('HI_ID').AsInteger, CDS.FieldByName('KN').Value]);
                              Res := DM.RunSQL('Pav304', Params);
                              if Res <> 0 then
                                begin
                                  Result := -1;
                                end;
                              end;
                           end;
                        except
                          Result := -1;
                        end;
                        CDS.Next;
                      end;
                   end;
                  // для   OPERATIONS
               2:   begin
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
                          if PrimeState = 1 then
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
                            UpManagerForm.Progress.Position := UpManagerForm.Progress.Position + 1;
                            if  CDSQ.Locate('KN', CDS.FieldByName('KN').Value, [loCaseInsensitive]) then
                              begin
                                if (CDS.FieldByName('STATE').AsInteger = 2) then
                                  begin
                                    CDSUp.Active := False;
                                    Params := VarArrayCreate([0,1], varVariant);
                                    Params[0] := VarArrayOf(['NAME', 'STATE', 'COMMENT', 'ROLES_ID', 'KN']);
                                    Params[1] := VarArrayOf([CDS.FieldByName('NAME').Value, A, CDS.FieldByName('COMMENT').Value, CDS.FieldByName('ROLES_ID').AsInteger, CDS.FieldByName('KN').Value]);
                                    Res := DM.RunSQL('Pav305', Params);
                                    if Res <> 0 then
                                      begin
                                        Result := -1;
                                      end;
                                  end;
                                if (CDS.FieldByName('STATE').AsInteger = -1) then
                                  begin
                                    CDSUp.Active := False;
                                    Params := VarArrayCreate([0,1], varVariant);
                                    Params[0] := VarArrayOf(['STATE', 'KN']);
                                    Params[1] := VarArrayOf([B, CDS.FieldByName('KN').Value]);
                                    Res := DM.RunSQL('Pav306', Params);
                                    if Res <> 0 then
                                      begin
                                        Result := -1;
                                      end;
                                  end;
                                if (CDS.FieldByName('STATE').AsInteger = 3) then
                                  begin
                                    CDSUp.Active := False;
                                    Params := VarArrayCreate([0,1], varVariant);
                                    Params[0] := VarArrayOf(['STATE', 'KN']);
                                    Params[1] := VarArrayOf([A, CDS.FieldByName('KN').Value]);
                                    Res := DM.RunSQL('Pav306', Params);
                                    if Res <> 0 then
                                      begin
                                        Result := -1;
                                      end;
                                  end;
                            end
                            else
                            begin
                              if (CDS.FieldByName('STATE').AsInteger = 3) or (CDS.FieldByName('STATE').AsInteger = 2) then
                                begin
                                  CDSUp.Active := False;
                                  Params := VarArrayCreate([0,1], varVariant);
                                  Params[0] := VarArrayOf(['ID', 'NAME', 'STATE', 'COMMENT', 'ROLES_ID', 'KN']);
                                  Params[1] := VarArrayOf([CDS.FieldByName('ID').AsInteger, CDS.FieldByName('NAME').Value, A, CDS.FieldByName('COMMENT').Value, CDS.FieldByName('ROLES_ID').AsInteger, CDS.FieldByName('KN').Value]);
                                  Res := DM.RunSQL('Pav307', Params);
                                  if Res <> 0 then
                                    begin
                                      Result := -1;
                                    end;
                                end;
                            end;
                      except
                        Result := -1;
                      end;
                      CDS.Next;
                  end;
               end;

                    // для  SQL_CODES
                3:  begin
                      CDS.First;
                      CDSQ.Active := False;
                      Params := Null;
                      Res := DM.GetData('Pav301', Params);
                      if not VarIsNull(Res) then
                        begin
                          CDSQ.Data := Res;
                          Sql_Codes.Data := Res;
                        end;
                      while not CDS.EOF do
                        begin
                          if PrimeState = 1 then
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
                            UpManagerForm.Progress.Position := UpManagerForm.Progress.Position + 1;
                            if CDSQ.Locate('KN',CDS.FieldByName('KN').Value,[loCaseInsensitive]) then
                              begin
                                if (CDS.FieldByName('STATE').AsInteger = 2) then
                                  begin
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
                                        Result := -1;
                                      end;
                                  end;
                                if (CDS.FieldByName('STATE').AsInteger = -1) then
                                  begin
                                    CDSUp.Active := False;
                                    Params := VarArrayCreate([0,1], varVariant);
                                    Params[0] := VarArrayOf(['STATE', 'KN']);
                                    Params[1] := VarArrayOf([B, CDS.FieldByName('KN').Value]);
                                    Res := DM.RunSQL('Pav309', Params);
                                    if Res <> 0 then
                                      begin
                                        Result := -1;
                                      end;
                                  end;
                                if (CDS.FieldByName('STATE').AsInteger = 3) then
                                  begin
                                    CDSUp.Active := False;
                                    Params := VarArrayCreate([0,1], varVariant);
                                    Params[0] := VarArrayOf(['STATE', 'KN']);
                                    Params[1] := VarArrayOf([A, CDS.FieldByName('KN').Value]);
                                    Res := DM.RunSQL('Pav309', Params);
                                    if Res <> 0 then
                                      begin
                                        Result := -1;
                                      end;
                                  end;
                            end
                            else
                            begin
                              if (CDS.FieldByName('STATE').AsInteger = 3) or (CDS.FieldByName('STATE').AsInteger = 2) then
                                begin
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
                                      Result := -1;
                                    end;
                                end;
                           end;
                         except
                           Result := -1;
                         end;
                         CDS.Next;
                       end;
                   end;
                   
                    // для   USER_GROUPS
                4:  begin
                      CDS.First;
                      CDSQ.Active := False;
                      Params := Null;
                      Res := DM.GetData('Pavel1126', Params);
                      if not VarIsNull(Res) then
                        begin
                          CDSQ.Data := Res;
                          Sql_Groups.Data := Res;
                        end;
                      while not CDS.EOF do
                        begin
                          if PrimeState = 1 then
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
                            UpManagerForm.Progress.Position := UpManagerForm.Progress.Position + 1;
                            if CDSQ.Locate('KN',CDS.FieldByName('KN').Value,[loCaseInsensitive]) then
                              begin
                                if (CDS.FieldByName('STATE').AsInteger = 2) then
                                  begin
                                    CDSUp.Active := False;
                                    Params := VarArrayCreate([0,1], varVariant);
                                    Params[0] := VarArrayOf(['NAME', 'STATE', 'KN']);
                                    Params[1] := VarArrayOf([CDS.FieldByName('NAME').AsString, A, CDS.FieldByName('KN').Value]);
                                    Res := DM.RunSQL('Pavel1127', Params);
                                    if Res <> 0 then
                                      begin
                                        Result := -1;
                                      end;
                                  end;
                                if (CDS.FieldByName('STATE').AsInteger = -1) then
                                  begin
                                    CDSUp.Active := False;
                                    Params := VarArrayCreate([0,1], varVariant);
                                    Params[0] := VarArrayOf(['STATE', 'KN']);
                                    Params[1] := VarArrayOf([B, CDS.FieldByName('KN').Value]);
                                    Res := DM.RunSQL('Pavel1129', Params);
                                    if Res <> 0 then
                                      begin
                                        Result := -1;
                                      end;
                                  end;
                                if (CDS.FieldByName('STATE').AsInteger = 3) then
                                  begin
                                    CDSUp.Active := False;
                                    Params := VarArrayCreate([0,1], varVariant);
                                    Params[0] := VarArrayOf(['STATE', 'KN']);
                                    Params[1] := VarArrayOf([A, CDS.FieldByName('KN').Value]);
                                    Res := DM.RunSQL('Pavel1129', Params);
                                    if Res <> 0 then
                                      begin
                                        Result := -1;
                                      end;
                                  end;
                            end
                            else
                            begin
                              if (CDS.FieldByName('STATE').AsInteger = 3) or (CDS.FieldByName('STATE').AsInteger = 2) then
                                begin
                                  CDSUp.Active := False;
                                  Params := VarArrayCreate([0,1], varVariant);
                                  Params[0] := VarArrayOf(['ID', 'NAME', 'STATE', 'KN']);
                                  Params[1] := VarArrayOf([CDS.FieldByName('ID').AsInteger, CDS.FieldByName('NAME').AsString, A,
                                                           CDS.FieldByName('KN').Value]);
                                  Res := DM.RunSQL('Pavel1131', Params);
                                  if Res <> 0 then
                                    begin
                                      Result := -1;
                                    end;
                                end;
                           end;
                         except
                           Result := -1;
                         end;
                         CDS.Next;
                       end;
                   end;

                    // для   S_RULES
                5:  begin
                      CDS.First;
                      if PrimeState = 0 then
                        begin
                          if DeleteAllRulesS = 1 then
                            begin
                              Params := Null;
                              Res := DM.GetData('Pavel1133', Params);
                              if not VarIsNull(Res) then
                                begin
                                  Sql_Codes.Data := Res;
                                end;
                              Params := Null;
                              Res := DM.GetData('Pavel1134', Params);
                              if not VarIsNull(Res) then
                                begin
                                  Sql_Groups.Data := Res;
                                end;
                              while not CDS.EOF do
                                begin
                                  try
                                    UpManagerForm.Progress.Position := UpManagerForm.Progress.Position + 1;
                                    if Sql_Codes.Locate('KN',CDS.FieldByName('SQL_CODES_KN').Value,[loCaseInsensitive]) then
                                      if Sql_Groups.Locate('KN',CDS.FieldByName('user_groups_KN').Value,[loCaseInsensitive]) then
                                        begin
                                          ID1 := Sql_Codes.FieldByName('ID').AsInteger;
                                          ID2 := Sql_Groups.FieldByName('ID').AsInteger;
                                          STATE := CDS.FieldByName('STATE').AsInteger;
                                          CDSUp.Active := False;
                                          Params := VarArrayCreate([0,1], varVariant);
                                          Params[0] := VarArrayOf(['SQLID', 'GRID', 'STATE']);
                                          Params[1] := VarArrayOf([ID1, ID2, STATE]);
                                          Res := DM.RunSQL('Pavel1135', Params);
                                          if Res <> 0 then
                                            begin
                                              Result := -1;
                                            end;
                                        end;
                                  except
                                    Result := -1;
                                  end;
                                  CDS.Next;
                                end;
                            end;
                        end;
                    end;

                    // для   O_RULES
                6:  begin
                      CDS.First;
                      if PrimeState = 0 then
                        begin
                          if DeleteAllRulesO = 1 then
                            begin
                              Params := Null;
                              Res := DM.GetData('Pavel1137', Params);
                              if not VarIsNull(Res) then
                                begin
                                  Sql_Operations.Data := Res;
                                end;
                              Params := Null;
                              Res := DM.GetData('Pavel1134', Params);
                              if not VarIsNull(Res) then
                                begin
                                  Sql_Groups.Data := Res;
                                end;
                              while not CDS.EOF do
                                begin
                                  try
                                    UpManagerForm.Progress.Position := UpManagerForm.Progress.Position + 1;
                                    if Sql_Operations.Locate('KN',CDS.FieldByName('OP_CODES_KN').Value,[loCaseInsensitive]) then
                                      if Sql_Groups.Locate('KN',CDS.FieldByName('user_groups_KN').Value,[loCaseInsensitive]) then
                                        begin
                                          ID1 := Sql_Operations.FieldByName('ID').AsInteger;
                                          ID2 := Sql_Groups.FieldByName('ID').AsInteger;
                                          STATE := CDS.FieldByName('STATE').AsInteger;
                                          CDSUp.Active := False;
                                          Params := VarArrayCreate([0,1], varVariant);
                                          Params[0] := VarArrayOf(['OPID', 'GID', 'STATE']);
                                          Params[1] := VarArrayOf([ID1, ID2, STATE]);
                                          Res := DM.RunSQL('Pavel1138', Params);
                                          if Res <> 0 then
                                            begin
                                              Result := -1;
                                            end;
                                        end;
                                  except
                                    Result := -1;
                                  end;
                                  CDS.Next;
                                end;
                            end;
                        end;
                    end;
             end;
         Stream2.Clear;
        end;
    except
      Result := -1;
    end;

Stream1.Free;
Stream2.Free;

CDS.Free;
CDSQ.Free;
CDSUp.Free;

    Sql_Codes.Free;
    Sql_Groups.Free;
    Sql_Operations.Free;

end;

function DeleteAllRulesS: Integer;
var Res, Params: Variant;
begin
  Result := -1;
  try
    Params := Null;
    Res := DM.RunSQL('Pavel1132', Params);
    if Res = 0 then
      begin
        Result := 1;
      end;
  except
    Result := -1;
  end;
end;

function DeleteAllRulesO: Integer;
var Res, Params: Variant;
begin
  Result := -1;
  try
    Params := Null;
    Res := DM.RunSQL('Pavel1136', Params);
    if Res = 0 then
      begin
        Result := 1;
      end;
  except
    Result := -1;
  end;
end;

end.
