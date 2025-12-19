unit CDOMsgUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, System.IniFiles;

type
  TCDOMessage = class(TForm)
    MainPanel: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    SMTP: TEdit;
    PortNo: TEdit;
    UseSSL: TCheckBox;
    Label3: TLabel;
    Authenticate: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    UserName: TEdit;
    PassWord: TEdit;
    Label6: TLabel;
    FromAddress: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ToAddress: TEdit;
    Subject: TEdit;
    Body: TMemo;
    Attachment: TEdit;
    Button1: TButton;
    Button2: TButton;
    OD: TOpenDialog;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private 宣言 }
    Ini: TInifile;
  public
    { Public 宣言 }
  end;

var
  CDOMessage: TCDOMessage;

implementation

{$R *.dfm}

uses CDOSendmail;

procedure TCDOMessage.Button1Click(Sender: TObject);
begin
  if FileExists(Attachment.Text) then
    OD.FileName := Attachment.Text;
  if OD.Execute then
    Attachment.Text := OD.FileName;
end;

procedure TCDOMessage.Button2Click(Sender: TObject);
var
  MailData: TMailData;
begin
  MailData.ToAddress    := ToAddress.Text;
  MailData.SubjectStr   := Subject.Text;
  MailData.BodyStr      := Body.Text;
  MailData.FromAddress  := FromAddress.Text;
  MailData.SMTPServer   := SMTP.Text;
  MailData.Port         := StrToInt(PortNo.Text);
  MailData.UserName     := UserName.Text;
  MailData.Password     := Password.Text;
  MailData.UseSSL       := True;
  MailData.Authenticate := Authenticate.ItemIndex + 1;
  MailData.Attachment   := Attachment.Text;

  if not SendMail(MailData) then // CDOSendmail Unit
    MessageBox(Handle, 'メールを送信できませんでした.', '送信エラー', 0);
end;

procedure TCDOMessage.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  tmp: string;
begin
  // 本来は最初にIniファイルを書き込みできるかどうか確認すべきだが、ここではあくまでも
  // サンプルなので考慮していない
  Ini.WriteString('options', 'SMTP', SMTP.Text);
  Ini.WriteString('options', 'Port', PortNo.Text);
  Ini.WriteString('options', 'UserName', UserName.Text);
  // パスワードは暗号化されたデータで保存すべきだが、ここではあくまでもサンプルなので
  // ベタテキストで保存・読込している
  Ini.WriteString('options', 'Password', Password.Text);
  Ini.WriteBool('options', 'UseSSL', UseSSL.Checked);
  Ini.WriteInteger('options', 'Authenticate', Authenticate.ItemIndex);
  Ini.WriteString('options', 'From', FromAddress.Text);
  Ini.WriteString('options', 'To', ToAddress.Text);
  Ini.WriteString('options', 'Subject', Subject.Text);
  Ini.WriteString('options', 'Attachment', Attachment.Text);
  tmp := StringReplace(Body.Text, #13#10, '#13#10', [rfReplaceAll]);
  Ini.WriteString('options', 'Body', tmp);

  Ini.Free;
end;

procedure TCDOMessage.FormCreate(Sender: TObject);
var
  inif, tmp: string;
begin
  inif := ChangeFileExt(Application.ExeName, '.ini');
  Ini := TInifile.Create(inif);

  SMTP.Text               := Ini.ReadString('options', 'SMTP', '');
  PortNo.Text             := Ini.ReadString('options', 'Port', '465');
  UserName.Text           := Ini.ReadString('options', 'UserName', '');
  // パスワードは暗号化されたデータで保存すべきだが、ここではあくまでもサンプルなので
  // ベタテキストで保存・読込している
  Password.Text           := Ini.ReadString('options', 'Password', '');
  UseSSL.Checked          := Ini.ReadBool('options', 'UseSSL', True);
  Authenticate.ItemIndex  := Ini.ReadInteger('options', 'Authenticate', 0);
  FromAddress.Text        := Ini.ReadString('options', 'From', '');
  ToAddress.Text          := Ini.ReadString('options', 'To', '');
  Subject.Text            := Ini.ReadString('options', 'Subject', '');
  Attachment.Text         := Ini.ReadString('options', 'Attachment', '');
  tmp                     := Ini.ReadString('options', 'Body', '');
  tmp := StringReplace(tmp, '#13#10', #13#10, [rfReplaceAll]);
  Body.Text               := tmp;
end;

end.
