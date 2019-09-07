unit BusyUnit;

interface

uses
  Windows,  Variants,  winsock;

type
IPINFO = record
Ttl :char;
Tos :char;
IPFlags :char;
OptSize :char;
Options :^char;
end; 

type
ICMPECHO = record
Source :longint;
Status :longint;
RTTime :longint;
DataSize:Shortint;
Reserved:Shortint;
pData :^variant;
i_ipinfo:IPINFO;
end;

TIcmpCreateFile =
  function():integer; {$IFDEF WIN32} stdcall; {$ENDIF}
TIcmpCloseHandle =
  procedure(var handle:integer);{$IFDEF WIN32} stdcall; {$ENDIF}
TIcmpSendEcho =
  function(var handle:integer; endereco:DWORD; buffer:variant;
  tam:WORD; IP:IPINFO; ICMP:ICMPECHO; tamicmp:DWORD;
  tempo:DWORD):DWORD;{$IFDEF WIN32} stdcall; {$ENDIF}

procedure DoBusy(ipstr:string);

implementation
procedure DoBusy(ipstr:string);
var
wsadt : wsadata;
icmp :icmpecho;
HNDicmp : integer;
hndFile :integer;
Host :PHostEnt;
Destino :in_addr;
Endereco :^DWORD;
IP : ipinfo;
Retorno :integer;
dwRetorno :DWORD;
x :integer;

IcmpCreateFile : TIcmpCreateFile;
IcmpCloseHandle : TIcmpCloseHandle;
IcmpSendEcho : TIcmpSendEcho;

begin
HNDicmp := LoadLibrary('ICMP.DLL');
if (HNDicmp <> 0) then begin
@IcmpCreateFile := GetProcAddress(HNDicmp,'IcmpCreateFile');
@IcmpCloseHandle := GetProcAddress(HNDicmp,'IcmpCloseHandle');
@IcmpSendEcho := GetProcAddress(HNDicmp,'IcmpSendEcho');
if (@IcmpCreateFile=nil) or (@IcmpCloseHandle=nil) or
   (@IcmpSendEcho=nil) then begin

FreeLibrary(HNDicmp);
end; 
end; 
Retorno := WSAStartup($0101,wsadt); 

if (Retorno <> 0) then
begin
WSACleanup();
FreeLibrary(HNDicmp); 
end;


if (Destino.S_addr = 0) then begin
Host := GetHostbyName(PChar(ipstr));
end
else begin 
Host := GetHostbyAddr(@Destino,sizeof(in_addr), AF_INET); 
end; 

if (host = nil) then
begin

WSACleanup(); 
FreeLibrary(HNDicmp); 
exit;
end;

Endereco := @Host.h_addr_list; 

HNDFile := IcmpCreateFile();
for x:= 0 to 4 do begin
Ip.Ttl := char(255); 
Ip.Tos := char(0); 
Ip.IPFlags := char(0); 
Ip.OptSize := char(0);
Ip.Options := nil; 

dwRetorno := IcmpSendEcho( 
HNDFile, 
Endereco^,
null, 
0, 
Ip,
Icmp, 
sizeof(Icmp),
DWORD(5000)); 
Destino.S_addr := icmp.source; 
end;

IcmpCLoseHandle(HNDFile);
FreeLibrary(HNDicmp);
WSACleanup();

end;
end.
