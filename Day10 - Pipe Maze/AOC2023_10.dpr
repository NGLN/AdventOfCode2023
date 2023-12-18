program AOC2023_10;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Types,
  System.Generics.Collections,
  System.Generics.Defaults,
  System.Math;

type
  TCoord = record
    X: Integer;
    Y: Integer;
    constructor Create(AX, AY: Integer);
    function Equals(ACoord: TCoord): Boolean;
  end;

{ TCoord }

constructor TCoord.Create(AX, AY: Integer);
begin
  Self.X := AX;
  Self.Y := AY;
end;

function TCoord.Equals(ACoord: TCoord): Boolean;
begin
  Result := (ACoord.X = X) and (ACoord.Y = Y);
end;

var
  Input: TStringList;
  Prev1: TCoord;
  Prev2: TCoord;
  Current1: TCoord;
  Current2: TCoord;
  Next1: TCoord;
  Next2: TCoord;
  StepCount: Integer;

function FindStart: TCoord;
var
  X: Integer;
  Y: Integer;
begin
  for Y := 0 to Input.Count - 1 do
    for X := 1 to Length(Input[0]) do
      if Input[Y][X] = 'S' then
      begin
        Result := TCoord.Create(X, Y);
        Exit;
      end;
end;

function CoordChar(ACoord: TCoord): Char;
begin
  Result := Input[ACoord.Y][ACoord.X];
end;

function NextMove(const AFrom, AVia: TCoord): TCoord;
begin
  case CoordChar(AVia) of
    '|': if AFrom.Y < AVia.Y then
           Result := TCoord.Create(AVia.X, AVia.Y + 1)
         else
           Result := TCoord.Create(AVia.X, AVia.Y - 1);
    '-': if AFrom.X < AVia.X then
           Result := TCoord.Create(AVia.X + 1, AVia.Y)
         else
           Result := TCoord.Create(AVia.X - 1, AVia.Y);
    'L': if AFrom.X = AVia.X then
           Result := TCoord.Create(AVia.X + 1, AVia.Y)
         else
           Result := TCoord.Create(AVia.X, AVia.Y - 1);
    'J': if AFrom.X = AVia.X then
           Result := TCoord.Create(AVia.X - 1, AVia.Y)
         else
           Result := TCoord.Create(AVia.X, AVia.Y - 1);
    '7': if AFrom.X = AVia.X then
           Result := TCoord.Create(AVia.X - 1, AVia.Y)
         else
           Result := TCoord.Create(AVia.X, AVia.Y + 1);
    'F': if AFrom.X = AVia.X then
           Result := TCoord.Create(AVia.X + 1, AVia.Y)
         else
           Result := TCoord.Create(AVia.X, AVia.Y + 1);
    else
      WriteLn('False');
  end;
end;

begin
  Input := TStringList.Create;
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    Prev1 := FindStart;
    Prev2 := Prev1;
    Current1 := TCoord.Create(Prev1.X - 1, Prev1.Y);
    Current2 := TCoord.Create(Prev2.X, Prev2.Y + 1);
    StepCount := 1;
    while not Current1.Equals(Current2) do
    begin 
      Next1 := NextMove(Prev1, Current1);
      Next2 := NextMove(Prev2, Current2);
      Prev1 := Current1;
      Prev2 := Current2;
      Current1 := Next1;
      Current2 := Next2;
      Inc(StepCount);
    end;
    WriteLn('Part I: ', StepCount);
  { Part II }
  
    WriteLn('Part II: ');
  finally
    Input.Free;
  end;
  ReadLn;
end.
