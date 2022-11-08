(*
  CDO.Message�I�u�W�F�N�g���g�p�������[�����M���j�b�g

  Delphi�ɂ��CDO.Message�𗘗p�������[�����M�̎����Ⴊ�قƂ�ǂȂ���������
  VB�X�N���v�g�ɂ��������Q�l�ɂ���

*)
unit CDOSendmail;

interface

uses
  System.Win.ComObj;

type
  TMailData = record
    SMTPServer,             // SMTP�T�[�o�[��
    UserName,               // ���O�C�����[�U�[��
    Password,               // �p�X���[�h
    ToAddress,              // ����A�h����
    FromAddress,            // ���M���A�h���X
    SubjectStr,             // �\��
    BodyStr,                // �{��
    Attachment: String;     // �Y�t�t�@�C��
    Port,                   // SMTP�T�[�o�[�ڑ��|�[�g
    Authenticate: integer;  // SMTP�T�[�o�[�F�ؕ��@(1:BASIC�F��, 2:NTLM�F��)
    UseSSL: Boolean;        // SSL�ڑ�(True:SSL�ڑ�����, False:�Ȃ�)
  end;{TMailData}

procedure SendMail(MailData: TMailData);

implementation

// CDO.Message���g�p�������[�����M����
procedure SendMail(MailData: TMailData);
var
  fld: string;
  CDOMsg: OleVariant;
begin
  CDOMsg := CreateOleObject('CDO.Message');
  fld := 'http://schemas.microsoft.com/cdo/configuration/';

  CDOMsg.Configuration.Fields.Item(fld + 'sendusing')             := 2; // �O��SMTP�T�[�o�[�ɐڑ�
  CDOMsg.Configuration.Fields.Item(fld + 'smtpserver')            := MailData.SMTPServer;
  CDOMsg.Configuration.Fields.Item(fld + 'smtpserverport')        := MailData.Port;
  CDOMsg.Configuration.Fields.Item(fld + 'smtpusessl')            := MailData.UseSSL;
  CDOMsg.Configuration.Fields.Item(fld + 'smtpauthenticate')      := MailData.Authenticate;
  CDOMsg.Configuration.Fields.Item(fld + 'sendusername')          := MailData.UserName;
  CDOMsg.Configuration.Fields.Item(fld + 'sendpassword')          := MailData.Password;
  CDOMsg.Configuration.Fields.Item(fld + 'smtpconnectiontimeout') := 60;
  CDOMsg.Configuration.Fields.Update;

  CDOMsg.BodyPart.Charset := 'ISO-2022-JP';   // Kindle�p�[�\�i���h�L�������g�T�[�r�X�ł�ISO-2022-JP�łȂ��Ǝ�M���Ă���Ȃ��悤��
  CDOMsg.To               := MailData.ToAddress;
  CDOMsg.From             := MailData.FromAddress;
  CDOMsg.Subject          := MailData.SubjectStr;
  CDOMsg.TextBody         := MailData.BodyStr;
  CDOMsg.AddAttachment(MailData.Attachment,'','');  // �����̃t�@�C����Y�t����ꍇ�͂��̏������J��Ԃ��炵��
  CDOMsg.Send;

  VarClear(CDOMsg);
end;

end.
