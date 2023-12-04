program AOC2023_01;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils;

var
  Input: TStringList;
  Line: String;
  I: Integer;
  First: Char;
  Last: Char;
  SumOfCalibrationValues: Integer;
  Digits: array [1..9] of String = ('one', 'two', 'three', 'four', 'five',
    'six', 'seven', 'eight', 'nine');
  N: Integer;

begin
  Input := TStringList.Create;
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    SumOfCalibrationValues := 0;
    for Line in Input do
    begin
      I := 1;
      repeat
        First := Line[I];
        Inc(I);
      until CharInSet(First, ['0'..'9']);
      I := Length(Line);
      repeat
        Last := Line[I];
        Dec(I);
      until CharInSet(Last, ['0'..'9']);
      Inc(SumOfCalibrationValues, StrToInt(First + Last));
    end;
    WriteLn('Part I: ', SumOfCalibrationValues);
  { Part II }
    SumOfCalibrationValues := 0;
    for Line in Input do
    begin
      I := 1;
      repeat
        First := Line[I];
        for N := 1 to 9 do
          if Copy(Line, I, Length(Digits[N])) = Digits[N] then
            First := IntToStr(N)[1];
        Inc(I);
      until CharInSet(First, ['0'..'9']);
      I := Length(Line);
      repeat
        Last := Line[I];
        for N := 1 to 9 do
          if Copy(Line, I - Length(Digits[N]) + 1, Length(Digits[N])) = Digits[N] then
            Last := IntToStr(N)[1];
        Dec(I);
      until CharInSet(Last, ['0'..'9']);
      Inc(SumOfCalibrationValues, StrToInt(First + Last));
    end;
    WriteLn('Part II: ', SumOfCalibrationValues);
  finally
    Input.Free;
  end;
  ReadLn;
end.
