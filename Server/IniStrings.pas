
{*******************************************************}
{                                                       }
{       NYK Visual Component Library                    }
{                                                       }
{       Copyright (c) 2000 NYK Corporation              }
{                                                       }
{*******************************************************}

unit IniStrings;

{$R-,T-,H+,X+}

interface

uses Windows, SysUtils, Classes, IniFiles, Variants;

type


  { TMemIni - ini file in memory and allows all
    operations to be performed on the memory .  }

  TMemIni = class(TCustomIniFile)
  private
    FSections: TStringList;
    function AddSection(const Section: string): TStrings;
    procedure LoadValues(IniStr : string);
  public
    constructor Create(IniStr : string);
    destructor Destroy; override;
    procedure Clear;
    procedure DeleteKey(const Section, Ident: String); override;
    procedure EraseSection(const Section: string); override;
    procedure GetStrings(List: TStrings);
    procedure ReadSection(const Section: string; Strings: TStrings); override;
    procedure ReadSections(Strings: TStrings); override;
    procedure ReadSectionValues(const Section: string; Strings: TStrings); override;
    function ReadString(const Section, Ident, Default: string): string; override;
    procedure SetStrings(List: TStrings);
    procedure WriteString(const Section, Ident, Value: String); override;
    function GetKeyCount(const Section: string) : integer;
    function GetSectionsCount : integer;
    function GetFullArrayValues : variant;
  end;

implementation

uses Consts;



{ TMemIni }

constructor TMemIni.Create(IniStr: string);
begin
  inherited Create('');
  FSections := TStringList.Create;
  LoadValues(IniStr);
end;

destructor TMemIni.Destroy;
begin
  if FSections <> nil then Clear;
  FSections.Free;
  inherited;
end;

function TMemIni.AddSection(const Section: string): TStrings;
begin
  Result := TStringList.Create;
  try
    FSections.AddObject(Section, Result);
  except
    Result.Free;
  end;
end;

procedure TMemIni.Clear;
var
  I: Integer;
begin
  for I := 0 to FSections.Count - 1 do
    TStrings(FSections.Objects[I]).Free;
  FSections.Clear;
end;

procedure TMemIni.DeleteKey(const Section, Ident: String);
var
  I, J: Integer;
  Strings: TStrings;
begin
  I := FSections.IndexOf(Section);
  if I >= 0 then
  begin
    Strings := TStrings(FSections.Objects[I]);
    J := Strings.IndexOfName(Ident);
    if J >= 0 then Strings.Delete(J);
  end;
end;

procedure TMemIni.EraseSection(const Section: string);
var
  I: Integer;
begin
  I := FSections.IndexOf(Section);
  if I >= 0 then
  begin
    TStrings(FSections.Objects[I]).Free;
    FSections.Delete(I);
  end;
end;

procedure TMemIni.GetStrings(List: TStrings);
var
  I, J: Integer;
  Strings: TStrings;
begin
  List.BeginUpdate;
  try
    for I := 0 to FSections.Count - 1 do
    begin
      List.Add('[' + FSections[I] + ']');
      Strings := TStrings(FSections.Objects[I]);
      for J := 0 to Strings.Count - 1 do List.Add(Strings[J]);
      List.Add('');
    end;
  finally
    List.EndUpdate;
  end;
end;

procedure TMemIni.LoadValues(IniStr : string);
var
  List: TStringList;
begin
  if IniStr <> '' then
  begin
    List := TStringList.Create;
    try
      List.text:=IniStr;
      SetStrings(List);
    finally
      List.Free;
    end;
  end else Clear;
end;

procedure TMemIni.ReadSection(const Section: string;
  Strings: TStrings);
var
  I, J: Integer;
  SectionStrings: TStrings;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    I := FSections.IndexOf(Section);
    if I >= 0 then
    begin
      SectionStrings := TStrings(FSections.Objects[I]);
      for J := 0 to SectionStrings.Count - 1 do
        Strings.Add(SectionStrings.Names[J]);
    end;
  finally
    Strings.EndUpdate;
  end;
end;

procedure TMemIni.ReadSections(Strings: TStrings);
begin
  Strings.Assign(FSections);
end;

procedure TMemIni.ReadSectionValues(const Section: string;
  Strings: TStrings);
var
  I: Integer;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    I := FSections.IndexOf(Section);
    if I >= 0 then Strings.Assign(TStrings(FSections.Objects[I]));
  finally
    Strings.EndUpdate;
  end;
end;

function TMemIni.ReadString(const Section, Ident,
  Default: string): string;
var
  I: Integer;
  Strings: TStrings;
begin
  I := FSections.IndexOf(Section);
  if I >= 0 then
  begin
    Strings := TStrings(FSections.Objects[I]);
    I := Strings.IndexOfName(Ident);
    if I >= 0 then
    begin
      Result := Copy(Strings[I], Length(Ident) + 2, Maxint);
      Exit;
    end;
  end;
  Result := Default;
end;

procedure TMemIni.SetStrings(List: TStrings);
var
  I: Integer;
  S: string;
  Strings: TStrings;
begin
  Clear;
  Strings := nil;
  for I := 0 to List.Count - 1 do
  begin
    S := List[I];
    if (S <> '') and (S[1] <> ';') then
      if (S[1] = '[') and (S[Length(S)] = ']') then
        Strings := AddSection(Copy(S, 2, Length(S) - 2))
      else
        if Strings <> nil then Strings.Add(S);
  end;
end;

procedure TMemIni.WriteString(const Section, Ident, Value: String);
var
  I: Integer;
  S: string;
  Strings: TStrings;
begin
  I := FSections.IndexOf(Section);
  if I >= 0 then
    Strings := TStrings(FSections.Objects[I]) else
    Strings := AddSection(Section);
  S := Ident + '=' + Value;
  I := Strings.IndexOfName(Ident);
  if I >= 0 then Strings[I] := S else Strings.Add(S);
end;

function TMemIni.GetKeyCount(const Section: string) : integer;
var
  ii : integer;
Begin
  Result:=0;
  ii:=FSections.IndexOf(Section);
  if ii<0 then Exit;
  Result:=TStringList(FSections.Objects[ii]).Count;
end;

function TMemIni.GetSectionsCount : integer;
Begin
  Result:=FSections.Count;
end;

function TMemIni.GetFullArrayValues : variant;
var
  co, coi, ii, jj : integer;
Begin
  Result:=null;
  co:=GetSectionsCount;
  if co=0 then Exit;
  coi:=0;
  for ii := 0 to co - 1 do
    coi:=coi+GetKeyCount(FSections.Strings[ii]);
  if coi=0 then Exit;
  Result:=VarArrayCreate([0, coi-1], varVariant);
  for ii := 0 to co - 1 do
      for jj := 0 to GetKeyCount(FSections.Strings[ii]) - 1 do Begin
         Dec(coi);
         Result[coi]:=VarArrayOf([FSections.Strings[ii],TStringList(FSections.Objects[ii]).Names[jj], TStringList(FSections.Objects[ii]).ValueFromIndex[jj]]);
      end;
end;


end.
