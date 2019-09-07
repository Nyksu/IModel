unit modelserver_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 14.07.2010 16:26:39 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Programm Development\delphi\Model\D2006\Server\modelserver.tlb (1)
// LIBID: {469305EB-1FCD-4599-A37A-6027C3A74FAA}
// LCID: 0
// Helpfile: 
// HelpString: modelserver Library
// DepndLst: 
//   (1) v1.0 Midas, (C:\WINDOWS\system32\midas.dll)
//   (2) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, Midas, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  modelserverMajorVersion = 1;
  modelserverMinorVersion = 0;

  LIBID_modelserver: TGUID = '{469305EB-1FCD-4599-A37A-6027C3A74FAA}';

  IID_IRI_Modelserver: TGUID = '{E94D9B99-8AA1-436D-A68D-D1E033D1AE1F}';
  CLASS_RI_Modelserver: TGUID = '{7FCA845D-5720-4B05-A778-059F871DF99F}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IRI_Modelserver = interface;
  IRI_ModelserverDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  RI_Modelserver = IRI_Modelserver;


// *********************************************************************//
// Interface: IRI_Modelserver
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E94D9B99-8AA1-436D-A68D-D1E033D1AE1F}
// *********************************************************************//
  IRI_Modelserver = interface(IAppServer)
    ['{E94D9B99-8AA1-436D-A68D-D1E033D1AE1F}']
    function LogDB(lg: OleVariant; ps: OleVariant): Integer; safecall;
    procedure StartTrans; safecall;
    procedure CommTrans; safecall;
    procedure BackTrans; safecall;
    function RunSQL(ksql: OleVariant; params: OleVariant; dbdirect: OleVariant): OleVariant; safecall;
    function GetData(ksql: OleVariant; params: OleVariant; dbdirect: OleVariant): OleVariant; safecall;
    function GetTehData(ksql: OleVariant; params: OleVariant; dbdirect: OleVariant): OleVariant; safecall;
    function GetTehDataN(ksql: OleVariant; params: OleVariant; nams: OleVariant; 
                         dbdirect: OleVariant): OleVariant; safecall;
    function GetStatus(params: OleVariant): OleVariant; safecall;
    function GetLastId: OleVariant; safecall;
    function TestOperRites(kn: OleVariant): OleVariant; safecall;
    function IsOperationRite(kn: OleVariant): OleVariant; safecall;
    function RunScript(kn: OleVariant; script: OleVariant): OleVariant; safecall;
    function DoCalculate(mapid: Integer; params: OleVariant): Integer; safecall;
    function StartTransmit(FileName: OleVariant; FileType: Integer; ModulType: Integer): OleVariant; safecall;
    function CloseTransmit: OleVariant; safecall;
    function WorkTransmit(Buffer: OleVariant): OleVariant; safecall;
    procedure StartTransC; safecall;
    procedure CommTransC; safecall;
    procedure BackTransC; safecall;
    function GetUserStatus: OleVariant; safecall;
    function DoLockMapF(mid: OleVariant; sts: OleVariant): OleVariant; safecall;
    function GetMonoState: OleVariant; safecall;
    function LoadUpstuct(scrpt: OleVariant): OleVariant; safecall;
    function SetUpstruct: OleVariant; safecall;
    function MapCalcCount(mapid: Integer): OleVariant; safecall;
    function LockMapEditOp(mid: OleVariant; sts: OleVariant): OleVariant; safecall;
    procedure ErrSQLlogControl(kn: OleVariant; oper: OleVariant); safecall;
    function GetConfigINI: OleVariant; safecall;
    procedure SetConfigINI(INITEXT: OleVariant; LOGTYPE: OleVariant); safecall;
    procedure ResetCalcSet(CUNIT: Smallint); safecall;
    function GetVersions: OleVariant; safecall;
    function GetCalcSetMap(mapid: Integer; modul: Integer): OleVariant; safecall;
    procedure PutCalcSetMap(mapid: Integer; modul: Integer; res: OleVariant); safecall;
    function GetGostKey: OleVariant; safecall;
    function GetCalcState: OleVariant; safecall;
    function GetLastError: OleVariant; safecall;
  end;

// *********************************************************************//
// DispIntf:  IRI_ModelserverDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E94D9B99-8AA1-436D-A68D-D1E033D1AE1F}
// *********************************************************************//
  IRI_ModelserverDisp = dispinterface
    ['{E94D9B99-8AA1-436D-A68D-D1E033D1AE1F}']
    function LogDB(lg: OleVariant; ps: OleVariant): Integer; dispid 301;
    procedure StartTrans; dispid 302;
    procedure CommTrans; dispid 303;
    procedure BackTrans; dispid 304;
    function RunSQL(ksql: OleVariant; params: OleVariant; dbdirect: OleVariant): OleVariant; dispid 305;
    function GetData(ksql: OleVariant; params: OleVariant; dbdirect: OleVariant): OleVariant; dispid 306;
    function GetTehData(ksql: OleVariant; params: OleVariant; dbdirect: OleVariant): OleVariant; dispid 307;
    function GetTehDataN(ksql: OleVariant; params: OleVariant; nams: OleVariant; 
                         dbdirect: OleVariant): OleVariant; dispid 308;
    function GetStatus(params: OleVariant): OleVariant; dispid 309;
    function GetLastId: OleVariant; dispid 310;
    function TestOperRites(kn: OleVariant): OleVariant; dispid 311;
    function IsOperationRite(kn: OleVariant): OleVariant; dispid 312;
    function RunScript(kn: OleVariant; script: OleVariant): OleVariant; dispid 313;
    function DoCalculate(mapid: Integer; params: OleVariant): Integer; dispid 314;
    function StartTransmit(FileName: OleVariant; FileType: Integer; ModulType: Integer): OleVariant; dispid 315;
    function CloseTransmit: OleVariant; dispid 316;
    function WorkTransmit(Buffer: OleVariant): OleVariant; dispid 317;
    procedure StartTransC; dispid 318;
    procedure CommTransC; dispid 319;
    procedure BackTransC; dispid 320;
    function GetUserStatus: OleVariant; dispid 321;
    function DoLockMapF(mid: OleVariant; sts: OleVariant): OleVariant; dispid 322;
    function GetMonoState: OleVariant; dispid 323;
    function LoadUpstuct(scrpt: OleVariant): OleVariant; dispid 324;
    function SetUpstruct: OleVariant; dispid 325;
    function MapCalcCount(mapid: Integer): OleVariant; dispid 326;
    function LockMapEditOp(mid: OleVariant; sts: OleVariant): OleVariant; dispid 327;
    procedure ErrSQLlogControl(kn: OleVariant; oper: OleVariant); dispid 328;
    function GetConfigINI: OleVariant; dispid 329;
    procedure SetConfigINI(INITEXT: OleVariant; LOGTYPE: OleVariant); dispid 330;
    procedure ResetCalcSet(CUNIT: Smallint); dispid 331;
    function GetVersions: OleVariant; dispid 332;
    function GetCalcSetMap(mapid: Integer; modul: Integer): OleVariant; dispid 333;
    procedure PutCalcSetMap(mapid: Integer; modul: Integer; res: OleVariant); dispid 334;
    function GetGostKey: OleVariant; dispid 335;
    function GetCalcState: OleVariant; dispid 336;
    function GetLastError: OleVariant; dispid 337;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// The Class CoRI_Modelserver provides a Create and CreateRemote method to          
// create instances of the default interface IRI_Modelserver exposed by              
// the CoClass RI_Modelserver. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRI_Modelserver = class
    class function Create: IRI_Modelserver;
    class function CreateRemote(const MachineName: string): IRI_Modelserver;
  end;

implementation

uses ComObj;

class function CoRI_Modelserver.Create: IRI_Modelserver;
begin
  Result := CreateComObject(CLASS_RI_Modelserver) as IRI_Modelserver;
end;

class function CoRI_Modelserver.CreateRemote(const MachineName: string): IRI_Modelserver;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RI_Modelserver) as IRI_Modelserver;
end;

end.
