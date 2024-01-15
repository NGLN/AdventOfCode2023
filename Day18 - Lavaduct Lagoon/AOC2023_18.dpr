program AOC2023_18;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  Aw.Types,
  System.Math,
  System.Generics.Collections;

var
  Input: TStringList;
  Coords: TList<TCoord>;
  DigCount: Integer = 0;

procedure ReadCoords(PartII: Boolean);
var
  Current: TCoord;
  Line: String;
  Args: TArray<String>;
  Count: Integer;
  Dir: Char;
begin
  Coords.Clear;
  Current := Coord(0, 0);
  Coords.Add(Current);
  for Line in Input do
  begin
    Args := Line.Split([' ']);
    if PartII then
    begin
      Dir := Args[2][8];
      Count := StrToInt('$' + Copy(Args[2], 3, 5));
    end
    else
    begin
      Dir := Args[0][1];
      Count := Args[1].ToInteger;
    end;
    Inc(DigCount, Count);
    case Dir of
      'R', '0': Inc(Current.X, Count);
      'D', '1': Inc(Current.Y, Count);
      'L', '2': Dec(Current.X, Count);
      'U', '3': Dec(Current.Y, Count);
    end;
    Coords.Add(Current);
  end;
end;

function Volume: Int64;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Coords.Count - 2 do
  begin
    Inc(Result, Coords[I].X * Coords[I + 1].Y);
    Dec(Result, Coords[I + 1].X * Coords[I].Y);
  end;
  Result := Result div 2;
  Inc(Result, DigCount div 2 + 1);
end;

function Volume2: Int64;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Coords.Count - 1 do
  begin
    if I = 0 then
      Inc(Result, Coords[I].X * (Coords[I + 1].Y - Coords.Last.Y))
    else if I = Coords.Count - 1 then
      Inc(Result, Coords[I].X * (Coords.First.Y - Coords[I - 1].Y))
    else
      Inc(Result, Coords[I].X * (Coords[I + 1].Y - Coords[I - 1].Y));
  end;
  Result := Result div 2;
  Inc(Result, DigCount div 2 + 1);
end;

begin
  Input := TStringList.Create;
  Coords := TList<TCoord>.Create;
  try
    Input.LoadFromFile('input.txt');
//    Input.LoadFromFile('example.txt');
  { Part I }
    ReadCoords(False);
    WriteLn('DigCount = ', DigCount);
    WriteLn('Part I: ', Volume);
  { Part II }
    ReadCoords(True);
    WriteLn('DigCount = ', DigCount);
    WriteLn('Part II: ', Volume);
    WriteLn('Part II: ', Volume2);

    // BUT 177243763228642 is too high ?!?!?!?

  finally
    Coords.Free;
    Input.Free;
  end;
  ReadLn;
end.



