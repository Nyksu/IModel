program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit3 in 'Unit3.pas' {Usf},
  Unit6 in 'Unit6.pas' {Form6},
  Unit2 in 'Unit2.pas' {Grf},
  Unit4 in 'Unit4.pas' {Blobf},
  Unit5 in 'Unit5.pas' {Datef},
  Unit8 in 'Unit8.pas' {Opf},
  DMmodel in 'DMmodel.pas' {DM: TDataModule},
  UpManagerUnit in 'UpManagerUnit.pas' {UpManagerForm},
  Limit in 'Limit.pas' {LimitForm},
  DCPbase64 in 'DCPbase64.pas',
  DCPblockciphers in 'DCPblockciphers.pas',
  DCPconst in 'DCPconst.pas',
  DCPcrypt2 in 'DCPcrypt2.pas',
  DCPhaval in 'DCPhaval.pas',
  DCPMain in 'DCPMain.pas',
  DCPrijndael in 'DCPrijndael.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SQL Creator 3.1';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TUsf, Usf);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TGrf, Grf);
  Application.CreateForm(TBlobf, Blobf);
  Application.CreateForm(TDatef, Datef);
  Application.CreateForm(TOpf, Opf);
  //Application.CreateForm(TLimitForm, LimitForm);
  //Application.CreateForm(TUpManagerForm, UpManagerForm);
  Application.Run;
end.
