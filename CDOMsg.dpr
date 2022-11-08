program CDOMsg;

uses
  Vcl.Forms,
  CDOMsgUnit in 'CDOMsgUnit.pas' {CDOMessage},
  CDOSendmail in 'CDOSendmail.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCDOMessage, CDOMessage);
  Application.Run;
end.
