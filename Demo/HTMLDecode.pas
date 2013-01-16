{
  HTML Decode 1.1.2

  Copyright (C) 2011-2013, Kangreon.
  License: GNU/GPL, http://www.gnu.org/copyleft/gpl.html
  Author: Dmitry Zhilko
  Websites: http://kdcodes.blogspot.com/
}

unit HTMLDecode;

interface

uses
  Classes, SysUtils, StrUtils;

type
  THTMLDecode = class
  private
    FErrorResource: Boolean;
    FTagList: WideString;
    function ConvertTag(const tag: WideString): WideString;
    procedure ErrorResource;
    procedure GetTagList;
    function HTMLDecode(const Src: WideString): WideString;
    function TextToCode(const tag: WideString): WideString;
  public
    constructor Create;
    destructor Destroy; override;

    ///	<summary>
    ///	  Конвертирует HTML символы в обычные.
    ///	</summary>
    ///	<param name="InText">
    ///	  Строка, которую необходимо конвертировать
    ///	</param>
    ///	<returns>
    ///	  Строка, содержащая конвертированные HTML символы
    ///	</returns>
    function Convert(const InText: WideString): WideString;

    ///	<summary>
    ///	  Показывает, удалось ли загрузить ресурс, содержащий соответствия HTML
    ///	  и обычных символов.
    ///	</summary>
    property IsError: Boolean read FErrorResource;
  end;

// Ресурс, содержит в себе название символов и их коды
{$R htmldecode.RES}

implementation

const
  RT_RCDATA       = PChar(10);

{ THTMLDecode }

constructor THTMLDecode.Create;
begin
  FErrorResource := False;
  GetTagList;
end;

destructor THTMLDecode.Destroy;
begin
  FTagList := '';
  inherited;
end;

function THTMLDecode.Convert(const InText: WideString): WideString;
begin
  if FErrorResource then
    ErrorResource
  else
  begin
    Result := HTMLDecode(InText);
  end;
end;

function THTMLDecode.ConvertTag(const tag: WideString): WideString;
var
  t: WideString;
  StringInt: WideString;
  int, lt: Integer;
begin
  lt := Length(tag);

  { Возврат исходных данных }
  Result := '&' + tag + ';';

  if Length(tag) <> 0 then
    if tag[1] = '#' then
    begin

      { Является ли число шестнадцатиричным }
      if tag[2] = 'x' then
      begin
        { Копирование вероятного числа }
        StringInt := Copy(tag, 3, lt);
        {
          Является ли набор символов числом,
          и перевод str в int
        }
        if TryStrToInt('$' + StringInt, int) then
          Result := WideChar(int);
      end
      else
      begin
        StringInt := Copy(tag, 2, lt);
        if TryStrToInt(StringInt, int) then
          Result := WideChar(int);
      end;

    end
    else
    begin
      { Перевод текста в код }
      t := TextToCode(tag);

      if TryStrToInt(t, int) then
        Result := WideChar(int);
    end;
end;

procedure THTMLDecode.ErrorResource;
begin
  raise Exception.Create('Resource htmldecode.RES not found or corrupt.');
end;

procedure THTMLDecode.GetTagList;
var
  tmp: AnsiString;
begin
  try
    with TResourceStream.Create(0, 'TagList', RT_RCDATA) do
    try
      SetLength(tmp, Size);
      ReadBuffer(tmp[1], Size);
      FTagList := WideString(tmp);
      tmp := '';
    finally
      Free;
    end;
  except
    // Ошибка загрузки ресурса
    FErrorResource := True;
  end;
end;

function THTMLDecode.HTMLDecode(const Src: WideString): WideString;
var
  i, tz: Integer;
  oldPos: Integer;
  s: WideString;
  tag, nTag: WideString;
  newStr: WideString;
begin
  i := 1;
  oldPos := 1;
  s := Src;
  newStr := '';

  { Поиск всех вхождений символа & }
  while PosEx('&', s, i) <> 0 do
  begin
    i := PosEx('&', s, i) + 1;
    { Поиск позиции окончания HTML Tag }
    tz := PosEx(';', s, i);

    { Если после & уже нету ; то выход из цикла }
    if tz < i then
      Break;

    { Если ; находится дальше следующей & то пропустить }
    if PosEx('&', s, i) <> 0 then
      if tz > PosEx('&', s, i) then
        Continue;

    {
      Если HTML Tag получился очень длинным,
      пропускаем.
    }
    if tz - i > 35 then
      Continue;

    tag := Copy(s, i, tz - i);
    nTag := ConvertTag(tag);

    newStr := newStr + Copy(s, oldPos, i - oldPos - 1) + nTag;
    oldPos := tz + 1;
  end;

  Result := newStr + Copy(s, oldPos, Length(s));
end;

function THTMLDecode.TextToCode(const tag: WideString): WideString;
var
  i: Integer;
begin
  i := PosEx('&' + tag + ';', FTagList);
  if i > 0 then
  begin
    Inc(i, 3 + Length(tag));
    Result := Copy(FTagList, i, PosEx(' ', FTagList, i) - i);
  end
  else
    Result := '&' + tag + ';';
end;

end.
