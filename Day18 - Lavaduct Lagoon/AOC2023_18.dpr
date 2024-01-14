program AOC2023_18;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  Aw.Types,
  Vcl.Graphics,
  System.Math;

var
  Input: TStringList;
  Grid: array of array of Char;
  X: Integer;
  Y: Integer;
  ColCount: Integer;
  RowCount: Integer;
  Curr: TCoord;
  Dir: Char;
  DigCount: Integer = 0;
  TrenchLength: Integer = 0;
  Line: String;
  Bmp: TBitmap;
  Volume: Integer = 0;

function InGrid(const ACoord: TCoord): Boolean;
begin
  Result := (ACoord.X >= 0) and (ACoord.X < ColCount) and
    (ACoord.Y >= 0) and (ACoord.Y < RowCount);
end;

function Next(const ACoord: TCoord; ADir: Char): TCoord;
begin
  Result := ACoord;
  case ADir of
    'U': Dec(Result.Y);
    'R': Inc(Result.X);
    'D': Inc(Result.Y);
    'L': Dec(Result.X);
  end;
end;

procedure Process(const S: String);
var
  A: TArray<String>;
  Count: Integer;
  I: Integer;
begin
  A := S.Split([' ']);
  Dir := A[0][1];
  Count := A[1].ToInteger;
  for I := 0 to Count - 1 do
  begin
    Curr := Next(Curr, Dir);
    Grid[Curr.X, Curr.Y] := '#';
  end;
end;

procedure Init;
var
  Line: String;
  A: TArray<String>;
  Count: Integer;
  MinX: Integer;
  MinY: Integer;
  MaxX: Integer;
  MaxY: Integer;
begin
  MinX := 0;
  MinY := 0;
  MaxX := 0;
  MaxY := 0;
  Curr := Coord(0, 0);
  for Line in Input do
  begin
    A := Line.Split([' ']);
    Dir := A[0][1];
    Count := A[1].ToInteger;
    Inc(DigCount, Count);
    case Dir of
      'U': Dec(Curr.Y, Count);
      'R': Inc(Curr.X, Count);
      'D': Inc(Curr.Y, Count);
      'L': Dec(Curr.X, Count);
    end;
    MinX := Min(MinX, Curr.X);
    MinY := Min(MinY, Curr.Y);
    MaxX := Max(MaxX, Curr.X);
    MaxY := Max(MaxY, Curr.Y);
  end;
  ColCount := MaxX - MinX + 3;
  RowCount := MaxY - MinY + 3;
  SetLength(Grid, ColCount, RowCount);
  Curr := Coord(-MinX + 1, -MinY + 1);
end;

begin
  Input := TStringList.Create;
  Bmp := TBitmap.Create;
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    Init;
    for Line in Input do
      Process(Line);
    Bmp.SetSize(ColCount, RowCount);
    for X := 0 to ColCount - 1 do
      for Y := 0 to RowCount - 1 do
        if Grid[X, Y] = '#' then
          Bmp.Canvas.Pixels[X, Y] := clGreen
        else
          Bmp.Canvas.Pixels[X, Y] := clBlue;
    Bmp.Canvas.Brush.Color := clRed;
    Bmp.Canvas.Brush.Style := bsSolid;
    Bmp.Canvas.FloodFill(0, 0, clGreen, fsBorder);
    for X := 0 to ColCount - 1 do
      for Y := 0 to RowCount - 1 do
        if Bmp.Canvas.Pixels[X, Y] <> clRed then
          Inc(Volume);
    WriteLn('Part I: ', Volume);
  { Part II }

    WriteLn('Part II: ');
  finally
    Bmp.Free;
    Input.Free;
  end;
  ReadLn;
end.
