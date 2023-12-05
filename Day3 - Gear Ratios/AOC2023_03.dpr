program AOC2023_03;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils;

var
  Input: TStringList;
  X: Integer;
  Y: Integer;
  MaxX: Integer;
  MaxY: Integer;
  SumOfPartNumbers: Integer;

function Data(AX, AY: Integer): Char;
begin
  Result := Input[AY][AX + 1];
end;

function IsPartNumber(AX, AY: Integer): Boolean;
begin
  Result := CharInSet(Data(AX, AY), ['0'..'9']);
end;

function IsSymbol(AX, AY: Integer): Boolean;
begin
  Result := not CharInSet(Data(AX, AY), ['0'..'9', '.']);
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
    if (X > 0)    and (Y > 0)    and IsSymbol(X - 1, Y - 1) or
       (X > 0)                   and IsSymbol(X - 1, Y + 0) or
       (X > 0)    and (Y < MaxY) and IsSymbol(X - 1, Y + 1) or
                      (Y > 0)    and IsSymbol(X + 0, Y - 1) or
                      (Y < MaxY) and IsSymbol(X + 0, Y + 1) or
       (X < MaxX) and (Y > 0)    and IsSymbol(X + 1, Y - 1) or
       (X < MaxX)                and IsSymbol(X + 1, Y + 0) or
       (X < MaxX) and (Y < MaxY) and IsSymbol(X + 1, Y + 1) then
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

    WriteLn('Part II: ');
  finally
    Input.Free;
  end;
  ReadLn;
end.

