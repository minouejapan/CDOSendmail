(*
  CDO.Messageオブジェクトを使用したメール送信ユニット

  DelphiによるCDO.Messageを利用したメール送信の実装例がほとんどなかったため
  VBスクリプトによる実装を参考にした

  2025/12/19 送信エラー時はFalseを返すようにした
*)
unit CDOSendmail;

interface

uses
  System.Win.ComObj;

type
  TMailData = record
    SMTPServer,             // SMTPサーバー名
    UserName,               // ログインユーザー名
    Password,               // パスワード
    ToAddress,              // 宛先アドレル
    FromAddress,            // 送信元アドレス
    SubjectStr,             // 表題
    BodyStr,                // 本文
    Attachment: String;     // 添付ファイル
    Port,                   // SMTPサーバー接続ポート
    Authenticate: integer;  // SMTPサーバー認証方法(1:BASIC認証, 2:NTLM認証)
    UseSSL: Boolean;        // SSL接続(True:SSL接続あり, False:なし)
  end;{TMailData}

function SendMail(MailData: TMailData): boolean;

implementation

// CDO.Messageを使用したメール送信処理


uses CDOMsgUnit;

function SendMail(MailData: TMailData): boolean;
var
  fld: string;
  CDOMsg: OleVariant;
begin
  Result := True;
  CDOMsg := CreateOleObject('CDO.Message');
  fld := 'http://schemas.microsoft.com/cdo/configuration/';
  CDOMsg.Configuration.Fields.Item(fld + 'sendusing')             := 2; // 外部SMTPサーバーに接続
  CDOMsg.Configuration.Fields.Item(fld + 'smtpserver')            := MailData.SMTPServer;
  CDOMsg.Configuration.Fields.Item(fld + 'smtpserverport')        := MailData.Port;
  CDOMsg.Configuration.Fields.Item(fld + 'smtpusessl')            := MailData.UseSSL;
  CDOMsg.Configuration.Fields.Item(fld + 'smtpauthenticate')      := MailData.Authenticate;
  CDOMsg.Configuration.Fields.Item(fld + 'sendusername')          := MailData.UserName;
  CDOMsg.Configuration.Fields.Item(fld + 'sendpassword')          := MailData.Password;
  CDOMsg.Configuration.Fields.Item(fld + 'smtpconnectiontimeout') := 60;
  CDOMsg.Configuration.Fields.Update;
  CDOMsg.BodyPart.Charset := 'ISO-2022-JP';   // KindleパーソナルドキュメントサービスではISO-2022-JPでないと受信してくれないようだ
  CDOMsg.To               := MailData.ToAddress;
  CDOMsg.From             := MailData.FromAddress;
  CDOMsg.Subject          := MailData.SubjectStr;
  CDOMsg.TextBody         := MailData.BodyStr;
  CDOMsg.AddAttachment(MailData.Attachment,'','');  // 複数のファイルを添付する場合はこの処理を繰り返すらしい
  try
    CDOMsg.Send;
  except
    Result := False;
  end;

  VarClear(CDOMsg);
end;

end.
