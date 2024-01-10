program AOC2023_16;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  Aw.Types;

type
  TWind = (N, E, S, W);

var
  Input: TStringList;
  Grid: array of array of Char;
  Energy: array of array of set of TWind;
  X: Integer;
  Y: Integer;
  ColCount: Integer;
  RowCount: Integer;
  Start: TCoord;
  Dir: TWind;

function InGrid(const ACoord: TCoord): Boolean;
begin
  Result := (ACoord.X >= 0) and (ACoord.X < ColCount) and 
    (ACoord.Y >= 0) and (ACoord.Y < RowCount);
end;

function Done(const ACoord: TCoord; ADir: TWind): Boolean;
begin
  Result := ADir in Energy[ACoord.X, ACoord.Y];
end;

function Next(const ACoord: TCoord; ADir: TWind): TCoord;
begin
  Result := ACoord;
  case Adir of
    N: Dec(Result.Y);
    E: Inc(Result.X);
    S: Inc(Result.Y);
    W: Dec(Result.X);
  end;
end;

function Moving(var Coord: TCoord; var Dir: TWind): Boolean;
var
  Coord2: TCoord;
  Dir2: TWind;
begin
  Result := InGrid(Coord) and not Done(Coord, Dir);
  if Result then
  begin
    Include(Energy[Coord.X, Coord.Y], Dir);
    case Grid[Coord.X, Coord.Y] of
      '\': case Dir of
             N: Dir := W;
             E: Dir := S;
             S: Dir := E;
             W: Dir := N;
           end;
      '/': case Dir of
             N: Dir := E;
             E: Dir := N;
             S: Dir := W;
             W: Dir := S;
           end;
      '|': case Dir of
             E, W:
               begin
                 Dir := N;
                 Coord2 := Coord;
                 Dir2 := S;
                 while Moving(Coord2, Dir2) do;
               end;
           end;
      '-': case Dir of
             N, S:
               begin
                 Dir := E;
                 Coord2 := Coord;
                 Dir2 := W;
                 while Moving(Coord2, Dir2) do;
               end;
           end;
    end;
    Coord := Next(Coord, Dir);
  end;
end;

function TotalEnergy: Integer;
var
  X: Integer;
  Y: Integer;
begin
  Result := 0;
  for X := 0 to ColCount - 1 do
    for Y := 0 to RowCount - 1 do
      if Energy[X, Y] <> [] then
        Inc(Result);
end;

begin
  Input := TStringList.Create;
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    ColCount := Length(Input[0]);
    RowCount := Input.Count;
    SetLength(Grid, ColCount, RowCount);
    SetLength(Energy, ColCount, RowCount);
    for X := 0 to ColCount - 1 do
      for Y := 0 to RowCount - 1 do
        Grid[X, Y] := Input[Y][X + 1];
    Start := Coord(0, 0);
    Dir := E;
    while Moving(Start, Dir) do;
    WriteLn('Part I: ', TotalEnergy);
  { Part II }

    WriteLn('Part II: ');
  finally
    Input.Free;
  end;
  ReadLn;
end.
