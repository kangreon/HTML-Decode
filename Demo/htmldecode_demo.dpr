{
  HTML Decode 1.1.2

  Copyright (C) 2011-2013, Kangreon.
  License: GNU/GPL, http://www.gnu.org/copyleft/gpl.html
  Author: Dmitry Zhilko
  Websites: http://kdcodes.blogspot.com/
}
program htmldecode_demo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  HTMLDecode in 'HTMLDecode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
