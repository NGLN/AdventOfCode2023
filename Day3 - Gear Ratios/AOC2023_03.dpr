program AOC2023_03;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils;

var
  Input: TStringList;
  MaxX: Integer;
  MaxY: Integer;

function Data(X, Y: Integer): Char;
begin
  if (X < 0) or (X > MaxX) or (Y < 0) or (Y > MaxY) then
    Result := '.'
  else
    Result := Input[Y][X + 1];
end;

function IsPartNumber(X, Y: Integer): Boolean;
begin
  Result := CharInSet(Data(X, Y), ['0'..'9']);
end;

function IsSymbol(X, Y: Integer): Boolean;
begin
  Result := not CharInSet(Data(X, Y), ['0'..'9', '.']);
end;

function PartNumber(var X: Integer; Y: Integer): Integer;
var
  SymbolAdjacent: Boolean;
  EndOfPartNumber: Boolean;
begin
  Result := 0;
  if IsPartNumber(X, Y) then
    Result := StrToInt(Data(X, Y));
  SymbolAdjacent := False;
  EndOfPartNumber := False;
  while not EndOfPartNumber do
  begin
    if IsSymbol(X - 1, Y - 1) or
       IsSymbol(X - 1, Y + 0) or
       IsSymbol(X - 1, Y + 1) or
       IsSymbol(X + 0, Y - 1) or
       IsSymbol(X + 0, Y + 1) or
       IsSymbol(X + 1, Y - 1) or
       IsSymbol(X + 1, Y + 0) or
       IsSymbol(X + 1, Y + 1) then
      SymbolAdjacent := True;
    if IsPartNumber(X, Y) and (X < MaxX) and IsPartNumber(X + 1, Y) then
    begin
      Result := 10 * Result + StrToInt(Data(X + 1, Y));
      Inc(X);
    end
    else
      EndOfPartNumber := True;
  end;
  if not SymbolAdjacent then
    Result := 0;
end;

function FindPartNumber(X, Y: Integer): Integer;
begin
  if IsPartNumber(X, Y) then
    while IsPartNumber(X - 1, Y) do
      Dec(X);
  Result := PartNumber(X, Y);
end;

function FindGearRatio(X, Y: Integer; var Count, Ratio: Integer): Boolean;
var
  Nr: Integer;
begin
  Nr := FindPartNumber(X, Y);
  Result := Nr > 0;
  if Result then
  begin
    Inc(Count);
    Ratio := Ratio * Nr;
  end;
end;

function GearRatio(X, Y: Integer): Integer;
var
  Count: Integer;
begin
  Count := 0;
  Result := 1;
  if not   FindGearRatio(X - 1, Y - 1, Count, Result) then
  begin
    if not FindGearRatio(X    , Y - 1, Count, Result) then
           FindGearRatio(X + 1, Y - 1, Count, Result);
  end
  else
    if not IsPartNumber( X    , Y - 1) then
           FindGearRatio(X + 1, Y - 1, Count, Result);
           FindGearRatio(X - 1, Y    , Count, Result);
           FindGearRatio(X + 1, Y    , Count, Result);
  if not   FindGearRatio(X - 1, Y + 1, Count, Result) then
  begin
    if not FindGearRatio(X    , Y + 1, Count, Result) then
           FindGearRatio(X + 1, Y + 1, Count, Result);
  end
  else
    if not IsPartNumber( X    , Y + 1) then
           FindGearRatio(X + 1, Y + 1, Count, Result);
  if Count <> 2 then
    Result := 0;
end;

var
  X: Integer;
  Y: Integer;
  SumOfPartNumbers: Integer;
  SumOfGearRatios: Integer;

begin
  Input := TStringList.Create;
  try
    Input.LoadFromFile('input.txt');
    MaxX := Length(Input[0]) - 1;
    MaxY := Input.Count - 1;
  { Part I }
    SumOfPartNumbers := 0;
    Y := 0;
    while Y <= MaxY do
    begin
      X := 0;
      while X <= MaxX do
      begin
        Inc(SumOfPartNumbers, PartNumber(X, Y));
        Inc(X);
      end;
      Inc(Y);
    end;
    WriteLn('Part I: ', SumOfPartNumbers);
  { Part II }
    SumOfGearRatios := 0;
    for Y := 0 to MaxY do
      for X := 0 to MaxX do
        if Data(X, Y) = '*' then
          Inc(SumOfGearRatios, GearRatio(X, Y));
    WriteLn('Part II: ', SumOfGearRatios);
  finally
    Input.Free;
  end;
  ReadLn;
end.
