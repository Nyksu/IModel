unit Formula;

interface

function SumToStr(ssum : string; kp : boolean): string;

function DatToStr(ddtt : TDateTime): string;

Function AnalizeStr(str : string; br : char; formatstr : boolean) : variant;

Function AnalizeStrClosed(str : string; br : char; formatstr : boolean) : variant;

Function CorrectFormatStr(str : string; br : char) : string;

Function GetFirstIncludStr(str : string; brstr_b, brstr_e : string) : string;

Function NumAnalize(x : integer) : integer;

Function TestCharModulationString(str : string) : string;

implementation

uses SysUtils, StrUtils1, Variants;


Function GetStrCh(Chi : char; por : byte; firb, tis : boolean) : string;
Var
  stt : string;
Begin
  stt:='';
  Case por of
    0 : Case Chi of
       '1': If firb Then If not tis Then stt:='Один '
            Else stt:='Одна ' Else If not tis Then stt:='один '
            Else stt:='одна ';
       '2': If firb Then If not tis Then stt:='Два '
            Else stt:='Две ' Else If not tis Then stt:='два '
            Else stt:='две ';
       '3': If firb Then stt:='Три ' Else stt:='три ';
       '4': If firb Then stt:='Четыре ' Else stt:='четыре ';
       '5': If firb Then stt:='Пять ' Else stt:='пять ';
       '6': If firb Then stt:='Шесть ' Else stt:='шесть ';
       '7': If firb Then stt:='Семь ' Else stt:='семь ';
       '8': If firb Then stt:='Восемь ' Else stt:='восемь ';
       '9': If firb Then stt:='Девять ' Else stt:='девять ';
        end;
    1 : Case Chi of
         '0': If firb Then stt:='Десять ' Else stt:='десять ';
         '1': If firb Then stt:='Одиннадцать ' Else stt:='одиннадцать ';
         '2': If firb Then stt:='Двенадцать ' Else stt:='двенадцать ';
         '3': If firb Then stt:='Тринадцать ' Else stt:='тринадцать ';
         '4': If firb Then stt:='Четырнадцать ' Else stt:='четырнадцать ';
         '5': If firb Then stt:='Пятнадцать ' Else stt:='пятнадцать ';
         '6': If firb Then stt:='Шестнадцать ' Else stt:='шестнадцать ';
         '7': If firb Then stt:='Семнадцать ' Else stt:='семнадцать ';
         '8': If firb Then stt:='Восемнадцать ' Else stt:='восемнадцать ';
         '9': If firb Then stt:='Девятнадцать ' Else stt:='девятнадцать ';
        end;
    2 : Case Chi of
         '2': If firb Then stt:='Двадцать ' Else stt:='двадцать ';
         '3': If firb Then stt:='Тридцать ' Else stt:='тридцать ';
         '4': If firb Then stt:='Сорок ' Else stt:='сорок ';
         '5': If firb Then stt:='Пятьдесят ' Else stt:='пятьдесят ';
         '6': If firb Then stt:='Шестьдесят ' Else stt:='шестьдесят ';
         '7': If firb Then stt:='Семьдесят ' Else stt:='семьдесят ';
         '8': If firb Then stt:='Восемьдесят ' Else stt:='восемьдесят ';
         '9': If firb Then stt:='Девяносто ' Else stt:='девяносто ';
        end;
    3 : Case Chi of
         '1': If firb Then stt:='Сто ' Else stt:='сто ';
         '2': If firb Then stt:='Двести ' Else stt:='двести ';
         '3': If firb Then stt:='Триста ' Else stt:='триста ';
         '4': If firb Then stt:='Четыреста ' Else stt:='четыреста ';
         '5': If firb Then stt:='Пятьсот ' Else stt:='пятьсот ';
         '6': If firb Then stt:='Шестьсот ' Else stt:='шестьсот ';
         '7': If firb Then stt:='Семьсот ' Else stt:='семьсот ';
         '8': If firb Then stt:='Восемьсот ' Else stt:='восемьсот ';
         '9': If firb Then stt:='Девятьсот ' Else stt:='девятьсот ';
        end;
    end;
    GetStrCh:=stt;
end;


{******************************************************}


Function StartStr(million:string): string;
var
 ii,posl_ch,poz : integer;
 ss,chislo,mil,mrd,tsch : string;
 chary : char;
 des : boolean;
begin
   ss:='';
   mrd:='';
   des:=false;
   mil:='';
   tsch:='';
   chislo:=million;
   ii:=Length(chislo);
   poz:=ii;
   posl_ch:=0;
   While poz>=1 Do Begin
     Case poz of
       1 : Begin
             chary:=chislo[ii-poz+1];
             If chary >= '0' Then Begin
               If des Then
                  if ss = '' then
                     ss:=GetStrCh(chary,1,true,false)
                    else begin
                     If posl_ch > 9 Then ss:=ss+mrd;
                     If posl_ch > 6 Then ss:=ss+mil;
                     If posl_ch > 3 Then ss:=ss+tsch;
                     ss:=ss+GetStrCh(chary,1,false,false);
                    end
                  Else Begin
                    if ss = '' then
                      ss:=GetStrCh(chary,0,true,false)
                     else begin
                      If posl_ch > 9 Then ss:=ss+mrd;
                      If posl_ch > 6 Then ss:=ss+mil;
                      If posl_ch > 3 Then ss:=ss+tsch;
                      ss:=ss+GetStrCh(chary,0,false,false);
                     end;
                  end;
             end;
           end;
       2 : Begin
             chary:=chislo[ii-poz+1];
             des:=false;
             If chary > '0' Then Begin
               {tsch:='тысяч ';}
               If chary = '1' Then des:=true;
               If ss = '' Then Begin
                     If not des Then ss:=GetStrCh(chary,2,true,false)
                    end
                    Else Begin
                     If posl_ch > 9 Then ss:=ss+mrd;
                     If posl_ch > 6 Then ss:=ss+mil;
                     If posl_ch > 3 Then ss:=ss+tsch;
                     If not des Then ss:=ss+GetStrCh(chary,2,false,false);
                    end;
               posl_ch:=poz;
             end;
           end;
       3 : Begin
             chary:=chislo[ii-poz+1];
             If chary > '0' Then Begin
               If ss = '' Then
                     ss:=GetStrCh(chary,3,true,false)
                  Else Begin
                     If posl_ch > 9 Then ss:=ss+mrd;
                     If posl_ch > 6 Then ss:=ss+mil;
                     If posl_ch > 3 Then ss:=ss+tsch;
                     ss:=ss+GetStrCh(chary,3,false,false);
                  end;
               posl_ch:=poz;
             end;
           end;
       4 : Begin
             chary:=chislo[ii-poz+1];
             If ((chary >= '0')and(des))or(chary > '0') Then Begin
               tsch:='тысяч ';
               If des Then
                  if ss = '' then
                     ss:=GetStrCh(chary,1,true,true)
                    else begin
                     If posl_ch > 9 Then ss:=ss+mrd;
                     If posl_ch > 6 Then ss:=ss+mil;
                     ss:=ss+GetStrCh(chary,1,false,true);
                    end
                  Else Begin
                    Case chary of
                       '1' : tsch:='тысяча ';
                  '2'..'4' : tsch:='тысячи ';
                    end;
                    if ss = '' then
                      ss:=GetStrCh(chary,0,true,true)
                     else begin
                      If posl_ch > 9 Then ss:=ss+mrd;
                      If posl_ch > 6 Then ss:=ss+mil;
                      ss:=ss+GetStrCh(chary,0,false,true)
                     end;
                  end;
                 posl_ch:=poz;
             end;
           end;
       5 : Begin
             chary:=chislo[ii-poz+1];
             des:=false;
             If chary > '0' Then Begin
               tsch:='тысяч ';
               If chary = '1' Then des:=true;
               If ss = '' Then Begin
                     If not des Then ss:=GetStrCh(chary,2,true,true)
                    end
                    Else Begin
                     If posl_ch > 9 Then ss:=ss+mrd;
                     If posl_ch > 6 Then ss:=ss+mil;
                     If not des Then ss:=ss+GetStrCh(chary,2,false,true);
                    end;
                 posl_ch:=poz;
             end;
           end;
       6 : Begin
             chary:=chislo[ii-poz+1];
             If chary > '0' Then Begin
               tsch:='тысяч ';
               If ss = '' Then
                     ss:=GetStrCh(chary,3,true,true)
                  Else Begin
                     If posl_ch > 9 Then ss:=ss+mrd;
                     If posl_ch > 6 Then ss:=ss+mil;
                     ss:=ss+GetStrCh(chary,3,false,true);
                  end;
               posl_ch:=poz;
             end;
           end;
       7 : Begin
             chary:=chislo[ii-poz+1];
             If ((chary >= '0')and(des))or(chary > '0') Then Begin
               mil:='миллионов ';
               If des Then
                  if ss = '' then
                     ss:=GetStrCh(chary,1,true,false)
                    else begin
                     If posl_ch > 9 Then ss:=ss+mrd;
                     ss:=ss+GetStrCh(chary,1,false,false);
                    end
                  Else Begin
                    Case chary of
                       '1' : mil:='миллион ';
                  '2'..'4' : mil:='миллионa ';
                    end;
                    if ss = '' then
                      ss:=GetStrCh(chary,0,true,false)
                     else begin
                      If posl_ch > 9 Then ss:=ss+mrd;
                      ss:=ss+GetStrCh(chary,0,false,false)
                     end;
                  end;
               posl_ch:=poz;
             end;
           end;
       8 : Begin
             chary:=chislo[ii-poz+1];
             des:=false;
             If chary > '0' Then Begin
               mil:='миллионов ';
               If chary = '1' Then des:=true;
               If ss = '' Then Begin
                       If not des Then ss:=GetStrCh(chary,2,true,false)
                    end
                    Else Begin
                     If posl_ch > 9 Then ss:=ss+mrd;
                     If not des Then ss:=ss+GetStrCh(chary,2,false,false);
                    end;
                 posl_ch:=poz;
             end;
           end;
       9 : Begin
             chary:=chislo[ii-poz+1];
             If chary > '0' Then Begin
               mil:='миллионов ';
               If ss = '' Then
                     ss:=GetStrCh(chary,3,true,false)
                  Else Begin
                     If posl_ch > 9 Then ss:=ss+mrd;
                     ss:=ss+GetStrCh(chary,3,false,false);
                  end;
               posl_ch:=poz;
             end;
           end;
      10 : Begin
             chary:=chislo[ii-poz+1];
             If chary >= '0' Then Begin
               mrd:='миллиардов ';
               posl_ch:=poz;
               If des Then
                  if ss = '' then
                     ss:=GetStrCh(chary,1,true,false)
                    else
                     ss:=ss+GetStrCh(chary,1,false,false)
                  Else Begin
                    Case chary of
                       '1' : mrd:='миллиард ';
                  '2'..'4' : mrd:='миллиардa ';
                    end;
                    if ss = '' then
                      ss:=GetStrCh(chary,0,true,false)
                     else
                      ss:=ss+GetStrCh(chary,0,false,false)
                  end;
             end;
           end;
      11 : Begin
             chary:=chislo[ii-poz+1];
             des:=false;
             If chary > '0' Then Begin
               mrd:='миллиардов ';
               posl_ch:=poz;
               If chary = '1' Then des:=true;
               If ss = '' Then Begin
                     If not des Then ss:=GetStrCh(chary,2,true,false)
                    end
                    Else
                     If not des Then ss:=ss+GetStrCh(chary,2,false,false);
             end;
           end;
      12 : Begin
             chary:=chislo[ii-poz+1];
             If chary > '0' Then Begin
                ss:=GetStrCh(chary,3,true,false);
                mrd:='миллиардов ';
                posl_ch:=poz;
             end;
           end;
     end;
     Dec(poz);
   end;
   StartStr:=ss;
end;

function SumToStr(ssum : string; kp : boolean): string;
var
pz, dl, ddl : integer;
kk : string;
Begin
 If kp Then Begin
   pz:=Pos(',',ssum);
   If pz>0 Then Begin
      ddl:=Length(ssum)-pz;
      dl:=ddl;
      If dl>2 Then dl:=2;
      kk:=Copy(ssum,pz+1,dl);
      Delete(ssum,pz,ddl+1);
   end;
   If (kk = '')or(kk = ' ') Then kk:='00';
   If Length(kk)<2 Then kk:=kk+'0';
   SumToStr:=StartStr(ssum)+'руб. ' + kk + 'коп.';
 end
 Else Begin
   pz:=Pos(',',ssum);
   If pz>0 Then Begin
      ddl:=Length(ssum)-pz;
      {If dl>2 Then dl:=2;}
      Delete(ssum,pz,ddl+1);
   end;
   SumToStr:=StartStr(ssum)+'руб.';
 end;
end;

function DatToStr(ddtt : TDateTime): string;
var
 st,sdey,sgod,smes : string;
 imes,idey,igod : word;
Begin
 DecodeDate(ddtt, igod, imes, idey);
 Str(igod,sgod);
 If Length(sgod)<4 Then If sgod > '90' Then sgod:='19'+sgod
                        Else sgod:='20'+sgod;
 Str(idey,sdey);
 Case imes of
   1 : smes:=' января ';
   2 : smes:=' февраля ';
   3 : smes:=' марта ';
   4 : smes:=' апреля ';
   5 : smes:=' мая ';
   6 : smes:=' июня ';
   7 : smes:=' июля ';
   8 : smes:=' августа ';
   9 : smes:=' сентября ';
  10 : smes:=' октября ';
  11 : smes:=' ноября ';
  12 : smes:=' декабря ';
 end;
 st:=sdey+smes+sgod+'г.';
 DatToStr:=st;
end;

Function CorrectFormatStr(str : string; br : char) : string;
var
  len, i1 : integer;
Begin
  Result:=str;
  If br='' Then Exit;
  len:=Length(str);
  i1:=Pos(br,str);
  if i1>0 then
    if str[len]=br then str:=Copy(str,1,len-1);
  i1:=Pos(br,str);
  if i1=0 then str:=DelBSpace(str);
  Result:=str;
end;

Function AnalizeStr(str : string; br : char; formatstr : boolean) : variant;
var
  elem : string;
  cw,ii : integer;
Begin
  Result:=null;
  DelBSpace(str);
  If str='' Then Exit;
  If br='' Then Exit;
  If formatstr Then Begin // форматированная строка
     If br=' ' Then str:=DelSpace1(str)
     Else str:=DelSpace(str)
  end;
  // Неформатированная строка
  cw:=WordCount(str,[br]);
  Result:=VarArrayCreate([0,cw-1],varVariant);
  If cw>1 Then For ii:=0 To cw-1 Do Begin
     elem:=Copy2SymbDel(str,br);
     If str<>'' Then If str[1]=br Then Delete(str,1,1);
     DelBSpace(elem);
     Result[ii]:=elem;
  end
  Else Result[0]:=str;
end;

Function AnalizeStrClosed(str : string; br : char; formatstr : boolean) : variant;
var
  elem : string;
  cw,ii,co : integer;
Begin
  Result:=null;
  DelBSpace(str);
  If str='' Then Exit;
  If br='' Then Exit;
  if str[1]=br then Delete(str,1,1);
  co:=Length(str);
  if co>0 then Begin
     if str[co]=br then Delete(str,co,1);
  end
  Else Exit;
  Result:=AnalizeStr(str,br,formatstr)
end;

Function GetFirstIncludStr(str : string; brstr_b, brstr_e : string) : string;
var
  k_all, k_bb, tbb, tbe, tt, dlt : integer;
Begin
  Result:='';
  if str<>'' then Begin
     k_all:=Length(str);
     tbb:=Pos(brstr_b, str);
     if tbb=0 then Exit;
     tbe:=Pos(brstr_e, str);
     if tbe=0 then tbe:=k_all+1;
     k_bb:=Length(brstr_b);
     tt:=tbb+k_bb;
     dlt:=tbe-tt;
     if dlt>0 then  Result:=Copy(str,tt,dlt);
  end;
end;

Function NumAnalize(x : integer) : integer;
Begin
  Result:=0;
  if x>0 then Result:=1;
  if x<0 then Result:=-1;
end;

Function TestCharModulationString(str : string) : string;
 var
  l, ii : integer;
  st : string;
Begin
  result:='';
  l:=length(str);
  if l<1 then Exit;
  if l=1 then Begin
    Result:=str;
    Exit;
  end;
  st:=str[1];
  for ii := 1 to l do Begin
      if st<>str[ii] then Begin
         st:='';
         Break;
      end;
  end;
  Result:=st;
end;

end.
