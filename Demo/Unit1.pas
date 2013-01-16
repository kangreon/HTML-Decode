{
  HTML Decode 1.1.2

  Copyright (C) 2011-2013, Kangreon.
  License: GNU/GPL, http://www.gnu.org/copyleft/gpl.html
  Author: Dmitry Zhilko
  Websites: http://kdcodes.blogspot.com/
}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, HTMLDecode;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
    Label2: TLabel;
    Memo2: TMemo;
    Button2: TButton;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    HTMLDec: THTMLDecode;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo2.Text := HTMLDec.Convert(Memo1.Text);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  ss: TStringStream;
  ws: WideString;
begin
  SaveDialog1.FileName := '';
  if not SaveDialog1.Execute then
    Exit;

  ws := HTMLDec.Convert(Memo1.Text);
  ss := TStringStream.Create(ws, TEncoding.UTF8);
  ss.SaveToFile(SaveDialog1.FileName);
  ss.Free;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  HTMLDec.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  HTMLDec := THTMLDecode.Create;

  Memo1.Clear;
  Memo2.Clear;

  ClientWidth := 350;
  ClientHeight := 300;
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width;
end;

procedure TForm1.FormResize(Sender: TObject);
var
  ch: Integer;
begin
  Memo1.Width := ClientWidth - 16;
  Memo2.Width := Memo1.Width;

  ch := ClientHeight - 66;

  Memo1.Height := ch div 2 - 30;
  Memo2.Height := Memo1.Height;
  Label2.top := Memo1.top + Memo1.Height + 10;
  Memo2.top := Label2.top + Label2.Height + 5;

  Button2.top := ClientHeight - Button2.Height - 8;
  Button3.Left := ClientWidth - Button3.Width - 8;
  Button3.top := Button2.top;
end;

end.
