unit DM;

interface

uses
  SysUtils, Classes, DB, DBClient, MConnect, SConnect;

type
  TDataModule7 = class(TDataModule)
    SockTo: TSocketConnection;
    cds_work: TClientDataSet;
    cds_work2: TClientDataSet;
    cds_work3: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule7: TDataModule7;

implementation

{$R *.dfm}

end.
