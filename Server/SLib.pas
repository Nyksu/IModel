unit SLib;

interface

uses Classes, Variants, StrUtils1, SysUtils, DBTables, IBQuery, DBClient, formula;

Type

 TNykSQL = class(TObject)
 private
   FID : Integer;
   FKN : string;
   FSQL : TStringList;
   FParam : TStringList;
   FValues : Variant;
   FClearComents : TStringList;
   FRulesID : Integer;
   FCanDoIt : boolean;
   FGenerator : string;
   FSysVar : TStringList;
   FSysVal : Variant;
   procedure ClearParam;
   procedure ClearValues;
   procedure ClearComentsClear;
   procedure AddParam(nam : string);
   function SysVarFind(nam : string) : integer;
 public
   constructor Create(idd,rul :integer; knn : string);
   destructor Destroy; override;
   property SQL : TStringList read FSQL;
   property id : integer read FID;
   property kn : string read FKN;
   property CanDoIt : boolean read FCanDoIt;
   property Values : variant read FValues;
   property Params : TStringList read FParam;
   property Generator : string read FGenerator;
   property SysVar : TStringList read FSysVar;
   property SysVal : Variant read FSysVal;
   property RulesId : integer read FRulesID;
   Procedure ReActivate;
   Procedure AddStrToSQL(str : string);
   procedure AddSQLtxt(txt : variant);
   Procedure AddClrComent(nam : string);
   Procedure SetSysParVal(nampar : string; vvl : variant);
   Procedure AddValue(nam:string; vvl : variant);
   Procedure SetDoIt(can : boolean);
   Procedure ParceSistemVal;
   Function TestParams : boolean;
   Function TestRules(rul : integer) : boolean;
   Function IsNeedParam : boolean;
   Function GetTransSQL : string;
 end;

 TNykSQLField = class(TObject)
 private
   FSQLs : TList;
   FSQLKNList : TStringList;
   FSqlNames : TStringList;
 public
   constructor Create;
   destructor Destroy; override;
   Function AddSQL(id, rul : integer; knn, name : string) : TNykSQL;
   Function SQLByKN(knn : string) : TNykSQL;
   Function SQLByIndex(index : integer) : TNykSQL;
   Function GetTransSQL(knn : string) : string;
   Function TestRules(knn : string; rul : integer) : boolean;
   Function TestSQLPresent(knn : string; var index : integer) : boolean;
   Procedure ReActivate(knn : string);
   Procedure AddStrToSQL(knn,str : string);
   procedure AddSQLtxt(knn : string; txt : variant);
   Procedure AddClrComent(knn,nam : string);
   Procedure AddValue(knn, nam:string; vvl : variant);
   Function RunIBSQL(knn : string; rul : integer; DS : TIBQuery; var er : string) : integer;
   Function RunIBSQL_LE(asql : pointer; DS : TIBQuery) : integer;
   Function RunIBSQL_LEex(asql : pointer; DS : TIBQuery; var er : string) : integer;
   Function RunSQL(knn : string; rul : integer; DS : TQuery; var er : string) : integer;
 end;


implementation

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  TNykSQL  begin declaration
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

uses DM;

{Var
  temp : variant;}

constructor TNykSQL.Create(idd,rul :integer; knn : string);
Begin
  inherited Create;
  FID:=idd;
  FRulesID:=rul;
  FKN:=knn;
  FCanDoIt:=false;
  FSQL:=TStringList.create;
  FParam:=TStringList.create;
  FClearComents:=TStringList.create;
  FGenerator:='';
  FSysVar:=TStringList.create;
  FSysVal:=null;
end;

destructor TNykSQL.Destroy;
Begin
  FSQL.Free;
  FParam.Free;
  FClearComents.Free;
  FSysVar.free;
  inherited Destroy;
end;

procedure TNykSQL.SetDoIt(can : boolean);
Begin
  FCanDoIt:=can;
end;

procedure TNykSQL.ClearParam;
Begin
  FParam.Clear;
end;

procedure TNykSQL.ClearValues;
Begin
  FValues:=null;
end;

procedure TNykSQL.ClearComentsClear;
Begin
  FClearComents.Clear;
end;

Procedure TNykSQL.ReActivate;
Begin
  ClearParam;
  ClearValues;
  ClearComentsClear;
  FSysVal:=null;
  if FSysVar.Count>0 then
     FSysVal:=VarArrayCreate([0, FSysVar.Count-1], varVariant);
end;

Procedure TNykSQL.ParceSistemVal;
Begin
  if FSQL.text='' then Exit;
  If Pos('!id!',FSQL.text)<>0 Then Begin
     FGenerator:=GetFirstIncludStr(FSQL.text,'#GEN#','$GEN$');
     if FGenerator<>'' then FSysVar.Add('id');
  end;
  if Pos('!user!',FSQL.text)<>0 then FSysVar.Add('user');
  if Pos('!rol!',FSQL.text)<>0 then FSysVar.Add('rol');
  FSysVal:=VarArrayCreate([0, FSysVar.Count-1], varVariant);
end;

function TNykSQL.SysVarFind(nam : string) : integer;
var
  ii : integer;
Begin
  Result:=-1;
  ii:=0;
  if FSysVar.Count>0 then
     while ii<=FSysVar.Count-1 do Begin
        if FSysVar.Strings[ii]=nam then Begin
           Result:=ii;
           Break;
        end;
        ii:=ii+1;
     end;
end;

Procedure TNykSQL.SetSysParVal(nampar : string; vvl : variant);
var
  ii : integer;
Begin
  //If FSysVar.Find(nampar,ii) Then Begin
  ii:=SysVarFind(nampar);
  if ii>=0 then Begin
     FSysVal[ii]:=vvl;
     SDM.WriteLogFile(1,'SetSysParVal','Загружаем SysPar: '+nampar+' = '+String(vvl)+' ('+String(FSysVal[ii])+') '+IntToStr(ii));
  end
  Else if FSysVar.Count>0 then Begin
     SDM.WriteLogFile(1,'SetSysParVal','Не найден SysPar: '+nampar+' = '+String(vvl));
     SDM.WriteLogFile(1,'SetSysParVal','Среди объектов SQL: '+kn+' ----- '+FSysVar.Text);
  end;

end;

procedure TNykSQL.AddSQLtxt(txt : variant);
Begin
  If not VarIsNull(txt) Then Begin
     FSQL.text:=txt;
     ParceSistemVal;
  end;
end;

Procedure TNykSQL.AddStrToSQL(str : string);
Begin
  FSQL.Add(str);
end;

Procedure TNykSQL.AddParam(nam : string);
Begin
  FParam.Add(nam);
end;

Procedure TNykSQL.AddValue(nam:string; vvl : variant);
Begin
  AddParam(nam);
  If VarIsNull(FValues) Then Begin
     FValues:=VarArrayCreate([0, 0], varVariant);
     FValues[0]:=vvl;
  end
  Else Begin
     VarArrayRedim(FValues,VarArrayHighBound(FValues,1)+1);
     FValues[VarArrayHighBound(FValues,1)]:=vvl;
  end;
  //temp:=Values[0];
end;

Procedure TNykSQL.AddClrComent(nam : string);
Begin
  FClearComents.Add(nam);
end;

Function TNykSQL.TestParams : boolean;
var
 ii,co : integer;
 str, ss : string;
Begin
  Result:=false;
  str:=FSQL.Text;
  if str='' Then Exit;
  if Pos('/*TRANS*/',str)<>0 then Begin
    Result:=true;
    Exit;
  end;

  co:=FParam.Count;
  If co>0 Then
    For ii:=0 to co-1 Do Begin
      ss:=FParam.Strings[ii];
      SDM.WriteLogFile(1,'TestParams','Проверяем параметр: '+ss+' '+IntToStr(ii+1)+' из '+IntToStr(co));
      If Pos(ss,str)=0 Then Begin
         SDM.WriteLogFile(0,'TestParams','Проверка не прошла в SQL: '+ss+' - '+IntToStr(ii+1)+' из '+IntToStr(co));
         SDM.WriteLogFile(0,'TestParams',str);
         Exit;
      end;
    end;
  Result:=true;
end;

Function TNykSQL.TestRules(rul : integer) : boolean;
Begin
  Result:= FRulesID>=rul;
end;

Function TNykSQL.IsNeedParam : boolean;
Begin
  Result:=Pos('!',FSQL.Text)<>0;
end;

Function TNykSQL.GetTransSQL : string;
Var
  sqltxt : variant;
  ii : integer;
Begin
  sqltxt:=FSQL.Text;
  Result:='';
//  WriteLogFile(4,'GetTransSQL','enter '+kn);
  If not TestParams Then Exit;
  If IsNeedParam Then Begin
//    WriteLogFile(4,'GetTransSQL','need params '+kn);
  //Удаление коментариев
    For ii:=0 To FClearComents.Count-1 Do Begin
      sqltxt:=ReplaceStr(sqltxt,'/*'+FClearComents.Strings[ii]+'!','');
      sqltxt:=ReplaceStr(sqltxt,'!'+FClearComents.Strings[ii]+'*/','');
    end;
//    if kn='Nyk669' Then WriteLogFile(4,'GetTransSQL','1 '+kn);
  //Подстановка параметров в текст SQL
    If VarArrayHighBound(FValues,1)<>FParam.Count-1 Then Exit;
//    if kn='Nyk669' Then WriteLogFile(4,'GetTransSQL','2 '+kn);
    For ii:=0 to FParam.Count-1 Do Begin
//      if kn='Nyk669' Then WriteLogFile(4,'GetTransSQL','3 '+kn+' - '+IntToStr(ii));
      If Pos(FParam.Strings[ii]+'!',sqltxt)=0 Then Begin
         SDM.WriteLogFile(0,'GetTransSQL','Лишний параметр!!  Имя параметра: '+FParam.Strings[ii]+' - '+kn);
         Raise EMathError.Create('Лишний параметр!!  Имя параметра: '+FParam.Strings[ii])
      end;
//      if kn='Nyk669' Then WriteLogFile(4,'GetTransSQL','4 '+kn);
      if String(FParam.Strings[ii])[1]='!' then Begin
//         if kn='Nyk669' Then WriteLogFile(4,'GetTransSQL','5 '+kn+' - '+IntToStr(ii)+' ! '+FValues[ii]);
         sqltxt:=ReplaceStr(sqltxt,FParam.Strings[ii]+'!',FValues[ii])
      end
      Else Begin
        sqltxt:=ReplaceStr(sqltxt,'!'+FParam.Strings[ii]+'!',':'+FParam.Strings[ii]);
//        if kn='Nyk669' Then WriteLogFile(4,'GetTransSQL','6 '+kn+' ** '+FParam.Strings[ii]);
      end;
    end;
    //Проверка наличия стандартных переменных
//    if kn='Nyk669' Then WriteLogFile(4,'GetTransSQL','7 '+kn);
    For ii:=0 to FSysVar.Count-1 Do
     While Pos('!'+FSysVar.Strings[ii]+'!',sqltxt)>0 Do
       sqltxt:=ReplaceStr(sqltxt,'!'+FSysVar.Strings[ii]+'!',':'+FSysVar.Strings[ii]);
//    if kn='Nyk669' Then WriteLogFile(4,'GetTransSQL','8 '+kn);
    sqltxt:=DelRSpace(sqltxt);
    Result:=sqltxt;
  end
  Else Result:=sqltxt;
//  WriteLogFile(4,'GetTransSQL','exit '+kn);
end;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  TNykSQL  end declaration
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  TNykSQLField begin declaration
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

constructor TNykSQLField.Create;
Begin
  inherited Create;
  FSQLs:=TList.Create;
  FSQLKNList:=TStringList.Create;
  FSqlNames:=TStringList.Create;
end;

destructor TNykSQLField.Destroy;
var
  ii, co : integer;
  sm : TNykSQL;
Begin
  co:=FSQLs.Count;
  For ii:=0 To co-1 Do Begin
    sm:=FSQLs.Items[ii];
    sm.Free;
  end;
  FSQLs.Free;
  FSQLKNList.Free;
  FSqlNames.Free;
  inherited Destroy;
end;

Function TNykSQLField.AddSQL(id, rul : integer; knn, name : string) : TNykSQL;
Begin
  Result:=nil;
  Result:=TNykSQL.Create(id, rul, knn);
  If Result<>nil Then Begin
     FSQLs.Add(Result);
     FSQLKNList.Add(knn);
     FSqlNames.Add(name);
  end;
end;

Function TNykSQLField.TestSQLPresent(knn : string; var index : integer) : boolean;
Begin
  Result:=FSQLKNList.Find(knn,index);
end;

Function TNykSQLField.SQLByKN(knn : string) : TNykSQL;
var
 ii, co : integer;
 sm : TNykSQL;
Begin
  Result:=nil;
  co:=FSQLs.Count;
  For ii:=0 To co-1 Do Begin
    sm:=FSQLs.Items[ii];
    If sm.kn=knn Then Begin
       Result:=FSQLs.Items[ii];
       Exit;
    end;
  end;
end;

Function TNykSQLField.SQLByIndex(index : integer) : TNykSQL;
Begin
  Result:=nil;
  if (FSQLs.Count-1)>=index then Result:=FSQLs.Items[index];
end;

Function TNykSQLField.GetTransSQL(knn : string) : string;
var
 sm : TNykSQL;
Begin
  Result:='';
  sm:=SQLByKN(knn);
  Result:=sm.GetTransSQL;
end;

Function TNykSQLField.TestRules(knn : string; rul : integer) : boolean;
var
 sm : TNykSQL;
Begin 
  Result:=false;
  sm:=SQLByKN(knn);
  Result:=sm.TestRules(rul);
end;

Procedure TNykSQLField.ReActivate(knn : string);
var
 sm : TNykSQL;
Begin 
  sm:=SQLByKN(knn);
  sm.ReActivate;
end;

procedure TNykSQLField.AddSQLtxt(knn : string; txt : variant);
var
 sm : TNykSQL;
Begin
  sm:=SQLByKN(knn);
  If not VarIsNull(txt) Then sm.AddSQLtxt(txt);
end;

Procedure TNykSQLField.AddStrToSQL(knn, str : string);
var
 sm : TNykSQL;
Begin
  sm:=SQLByKN(knn);
  sm.AddStrToSQL(str);
end;

Procedure TNykSQLField.AddClrComent(knn, nam : string);
var
 sm : TNykSQL;
Begin     
  sm:=SQLByKN(knn);
  sm.AddClrComent(nam);
end;

Procedure TNykSQLField.AddValue(knn, nam : string; vvl : variant);
var
 sm : TNykSQL;
Begin
  sm:=SQLByKN(knn);
  sm.AddValue(nam,vvl);
  //temp:=sm.Values[0];
end;

Function TNykSQLField.RunIBSQL_LE(asql : pointer; DS : TIBQuery) : integer;
var
  er : string;
Begin
  Result:=RunIBSQL_LEex(asql,DS, er);
end;

Function TNykSQLField.RunIBSQL_LEex(asql : pointer; DS : TIBQuery; var er : string) : integer;
var
 sm : TNykSQL;
 sqltxt : string;
 ii : integer;
 vr : variant;
Begin
  Result:=-3; // нет SQL
  sm:=asql;
  If sm=nil Then Begin
     SDM.WriteLogFile(0,'RunIBSQL_LEex','sm : nil');
     Exit;
  end;
  Result:=-1; // Ошибка
//  WriteLogFile(4,'RunIBSQL_LEex','enter '+sm.kn);
  sqltxt:=sm.GetTransSQL;
  if SDM.debugmore Then if sm.kn=SDM.sqlspy then SDM.WriteLogFile(4,'RunIBSQL_LEex','SQL: '+sqltxt);
  If sqltxt='' Then Exit;
  DS.Active:=false;
  DS.SQL.Clear;
  DS.Params.Clear;
  DS.SQL.Text:=sqltxt;
  For ii:=0 To sm.Params.Count-1 Do
     If sm.Params.Strings[ii][1]<>'!' Then Begin
        vr:=sm.Values[ii];
        if SDM.debugmore Then if sm.kn=SDM.sqlspy then SDM.WriteLogFile(4,'RunIBSQL_LEex','Params: '+IntToStr(ii)+' = '+String(sm.Values[ii]));
        if VarIsNull(vr) Then DS.ParamByName(sm.Params.Strings[ii]).Value:=null
        Else
        Case VarType(vr) of
          varNull      : DS.ParamByName(sm.Params.Strings[ii]).Value:=null;
          varSmallint  : DS.ParamByName(sm.Params.Strings[ii]).AsInteger:=vr;
          varInteger   : DS.ParamByName(sm.Params.Strings[ii]).AsInteger:=vr;
          varSingle    : DS.ParamByName(sm.Params.Strings[ii]).AsFloat:=vr;
          varDouble    : DS.ParamByName(sm.Params.Strings[ii]).AsFloat:=vr;
          varDate      : DS.ParamByName(sm.Params.Strings[ii]).AsDate:=vr;
          varBoolean   : DS.ParamByName(sm.Params.Strings[ii]).AsBoolean:=vr;
          varVariant   : DS.ParamByName(sm.Params.Strings[ii]).AsBlob:=vr;
          varString    : DS.ParamByName(sm.Params.Strings[ii]).AsString:=vr;
          varOleStr    : DS.ParamByName(sm.Params.Strings[ii]).AsString:=vr;
        Else DS.ParamByName(sm.Params.Strings[ii]).Value:=vr;
        end;
        //vr:=DS.ParamByName(sm.Params.Strings[ii]).Value;
     end;
  For ii:=0 To sm.SysVar.Count-1 Do Begin
        vr:=sm.SysVal[ii];
        if VarIsNull(vr) Then DS.ParamByName(sm.SysVar.Strings[ii]).Value:=null
        Else
        Case VarType(vr) of
          varNull      : DS.ParamByName(sm.SysVar.Strings[ii]).Value:=null;
          varSmallint  : DS.ParamByName(sm.SysVar.Strings[ii]).AsInteger:=vr;
          varInteger   : DS.ParamByName(sm.SysVar.Strings[ii]).AsInteger:=vr;
          varSingle    : DS.ParamByName(sm.SysVar.Strings[ii]).AsFloat:=vr;
          varDouble    : DS.ParamByName(sm.SysVar.Strings[ii]).AsFloat:=vr;
          varDate      : DS.ParamByName(sm.SysVar.Strings[ii]).AsDate:=vr;
          varBoolean   : DS.ParamByName(sm.SysVar.Strings[ii]).AsBoolean:=vr;
          varVariant   : DS.ParamByName(sm.SysVar.Strings[ii]).AsBlob:=vr;
          varString    : DS.ParamByName(sm.SysVar.Strings[ii]).AsString:=vr;
          varOleStr    : DS.ParamByName(sm.SysVar.Strings[ii]).AsString:=vr;
        Else DS.ParamByName(sm.SysVar.Strings[ii]).Value:=vr;
        end;
        //vr:=DS.ParamByName(sm.SysVar.Strings[ii]).Value;
  end;
  Result:=0;
  if SDM.debugmore Then if sm.kn=SDM.sqlspy then SDM.WriteLogFile(4,'RunIBSQL_LEex','Параменты заполнены.');
  try
    DS.prepare;
    If (sqltxt[1]<>'s') and (sqltxt[1]<>'S') Then Begin
      if SDM.debugmore Then if sm.kn=SDM.sqlspy then SDM.WriteLogFile(4,'RunIBSQL_LEex','ExecSQL.');
       DS.ExecSQL;
       if SDM.debugmore Then if sm.kn=SDM.sqlspy then SDM.WriteLogFile(4,'RunIBSQL_LEex','Ok.');
    end;
  except
    on E: Exception do Begin
       Result:=1;
       er:=E.Message;
       if SDM.debugmore Then SDM.WriteLogFile(0,'RunIBSQL_LEex','Ошибка исполнения: '+er);
    end;
  end;


end;

Function TNykSQLField.RunIBSQL(knn : string; rul : integer; DS : TIBQuery; var er : string) : integer;
var
 sm : TNykSQL;
 sqltxt : string;
 ii : integer;
 vr : variant;
Begin
  er:='нет SQL';
  Result:=-3; // нет SQL
  sm:=SQLByKN(knn);
  If sm=nil Then Exit;
  er:='Нет прав на операцию!';
  Result:=-2; // нет прав
  if not sm.TestRules(rul) Then Exit;
  er:='Не предвиденная ошибка...';
  Result:=-1; // Ошибка
  sqltxt:=GetTransSQL(knn);
  If sqltxt='' Then Exit;
  DS.Active:=false;
  DS.SQL.Clear;
  DS.Params.Clear;
  DS.SQL.Text:=sqltxt;
  For ii:=0 To sm.Params.Count-1 Do 
     If sm.Params.Strings[ii][1]<>'!' Then Begin
        vr:=sm.Values[ii];
        if VarIsNull(vr) Then DS.ParamByName(sm.Params.Strings[ii]).Value:=null
        Else
        Case VarType(vr) of
          varNull      : DS.ParamByName(sm.Params.Strings[ii]).Value:=null;
          varSmallint  : DS.ParamByName(sm.Params.Strings[ii]).AsInteger:=vr;
          varInteger   : DS.ParamByName(sm.Params.Strings[ii]).AsInteger:=vr;
          varSingle    : DS.ParamByName(sm.Params.Strings[ii]).AsFloat:=vr;
          varDouble    : DS.ParamByName(sm.Params.Strings[ii]).AsFloat:=vr;
          varDate      : DS.ParamByName(sm.Params.Strings[ii]).AsDate:=vr;
          varBoolean   : DS.ParamByName(sm.Params.Strings[ii]).AsBoolean:=vr;
          varVariant   : DS.ParamByName(sm.Params.Strings[ii]).AsBlob:=vr;
          varString    : DS.ParamByName(sm.Params.Strings[ii]).AsString:=vr;
          varOleStr    : DS.ParamByName(sm.Params.Strings[ii]).AsString:=vr;
        Else DS.ParamByName(sm.Params.Strings[ii]).Value:=vr;
        end;
        //vr:=DS.ParamByName(sm.Params.Strings[ii]).Value;
     end;
  For ii:=0 To sm.SysVar.Count-1 Do Begin
        vr:=sm.SysVal[ii];
        if VarIsNull(vr) Then DS.ParamByName(sm.SysVar.Strings[ii]).Value:=null
        Else
        Case VarType(vr) of
          varNull      : DS.ParamByName(sm.SysVar.Strings[ii]).Value:=null;
          varSmallint  : DS.ParamByName(sm.SysVar.Strings[ii]).AsInteger:=vr;
          varInteger   : DS.ParamByName(sm.SysVar.Strings[ii]).AsInteger:=vr;
          varSingle    : DS.ParamByName(sm.SysVar.Strings[ii]).AsFloat:=vr;
          varDouble    : DS.ParamByName(sm.SysVar.Strings[ii]).AsFloat:=vr;
          varDate      : DS.ParamByName(sm.SysVar.Strings[ii]).AsDate:=vr;
          varBoolean   : DS.ParamByName(sm.SysVar.Strings[ii]).AsBoolean:=vr;
          varVariant   : DS.ParamByName(sm.SysVar.Strings[ii]).AsBlob:=vr;
          varString    : DS.ParamByName(sm.SysVar.Strings[ii]).AsString:=vr;
          varOleStr    : DS.ParamByName(sm.SysVar.Strings[ii]).AsString:=vr;
        Else DS.ParamByName(sm.SysVar.Strings[ii]).Value:=vr;
        end;
        //vr:=DS.ParamByName(sm.SysVar.Strings[ii]).Value;
  end;
  Result:=0;
  DS.prepare;
  If (sqltxt[1]<>'s') and (sqltxt[1]<>'S') Then Begin
     try
       DS.ExecSQL;
     except
        on E: Exception do Begin
          Result:=1;
          er:=E.Message;
        end;
     end;
  end;
end;

Function TNykSQLField.RunSQL(knn : string; rul : integer; DS : TQuery; var er : string) : integer;
Begin
  Result:=-3; // нет SQL
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  TNykSQLField end declaration
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


end.
