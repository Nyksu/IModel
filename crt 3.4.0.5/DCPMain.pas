unit DCPMain;

interface
uses SysUtils, DCPHaval, DCPrijndael;

function CreateKey(Value: string): string;
function DigestToStr(Digest: array of Byte): string;
function EncryptString(Source, Password: string): string;
function DecryptString(Source, Password: string): string;

implementation

function CreateKey(Value: string): string;
var
  Hash: TDCP_haval;
  Digest: array[0..31] of Byte;
begin
  Hash := TDCP_haval.Create(nil);
  FillChar(Digest,31,#0);
  Hash.Init;
  Hash.HashSize := 256;
  Hash.UpdateStr(Value);
  Hash.Final(Digest);
  Hash.Free;
  Result := DigestToStr(Digest); 
end;

function DigestToStr(Digest: array of Byte): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to 31 do
    Result := Result + LowerCase(IntToHex(Digest[i], 2));
end;

function EncryptString(Source, Password: string): string;
var
  DCP_rijndael1: TDCP_rijndael;
  Key: string;
begin
  Key := CreateKey(Password);
  DCP_rijndael1 := TDCP_rijndael.Create(nil);
  DCP_rijndael1.InitStr(Key, TDCP_haval);
  Result := DCP_rijndael1.EncryptString(Source);
  DCP_rijndael1.Burn;
  DCP_rijndael1.Free;
end;

function DecryptString(Source, Password: string): string;
var
  DCP_rijndael1: TDCP_rijndael;
  Key: string;
begin
  Key := CreateKey(Password);
  DCP_rijndael1 := TDCP_rijndael.Create(nil);
  DCP_rijndael1.InitStr(Key, TDCP_haval);
  Result := DCP_rijndael1.DecryptString(Source);
  DCP_rijndael1.Burn;
  DCP_rijndael1.Free;                          
end;

end.
