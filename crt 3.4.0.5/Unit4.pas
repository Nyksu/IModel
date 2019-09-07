unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TBlobf = class(TForm)
    MyMemo: TMemo;
    procedure MyMemoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Blobf: TBlobf;

implementation
   uses unit1;
{$R *.dfm}

procedure TBlobf.MyMemoChange(Sender: TObject);
begin
  mGr.Cells[xx,yy]:= MyMemo.Text;
end;

procedure TBlobf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 mGr.Cells[xx,yy] := MyMemo.Text;
 BlobDown := False;
 form1.Enabled := True;
end;

end.
