unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls;

type
  TDatef = class(TForm)
    Calendar: TMonthCalendar;
    TimeP: TDateTimePicker;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Datef: TDatef;

implementation
     uses unit1;
{$R *.dfm}

procedure TDatef.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  mGr.Cells[xx,yy] := DateToStr(Datef.Calendar.Date) + ' ' + TimeToStr(Datef.TimeP.Time);
  form1.Enabled := True;
end;

end.
