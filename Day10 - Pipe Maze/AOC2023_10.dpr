program AOC2023_10;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Types,
  System.Generics.Collections,
  System.Generics.Defaults,
  System.Math,
  Vcl.Graphics,
  Aw.Types;

type
  TGrid = array of array of Char;

var
  Input: TStringList;
  Prev1: TCoord;
  Prev2: TCoord;
  Current1: TCoord;
  Current2: TCoord;
  Next1: TCoord;
  Next2: TCoord;
  StepCount: Integer;
  Grid1: TGrid;
  Grid2: TGrid;
  Grid: TGrid;
  Bmp: TBitmap;
  X: Integer;
  Y: Integer;
  ColCount: Integer;
  RowCount: Integer;

function FindStart: TCoord;
var
  X: Integer;
  Y: Integer;
begin
  for Y := 0 to RowCount - 1 do
    for X := 0 to ColCount - 1 do
      if Grid[X, Y] = 'S' then
      begin
        Result := Coord(X, Y);
        Exit;
      end
end;

function NextMove(const AFrom, AVia: TCoord; LeaveTrace: Boolean): TCoord;
begin
  case Grid[AVia.X, AVia.Y] of
    '|', 'V': if AFrom.Y < AVia.Y then
           Result := Coord(AVia.X, AVia.Y + 1)
         else
           Result := Coord(AVia.X, AVia.Y - 1);
    '-', 'H': if AFrom.X < AVia.X then
           Result := Coord(AVia.X + 1, AVia.Y)
         else
           Result := Coord(AVia.X - 1, AVia.Y);
    'L': if AFrom.X = AVia.X then
           Result := Coord(AVia.X + 1, AVia.Y)
         else
           Result := Coord(AVia.X, AVia.Y - 1);
    'J': if AFrom.X = AVia.X then
           Result := Coord(AVia.X - 1, AVia.Y)
         else
           Result := Coord(AVia.X, AVia.Y - 1);
    '7': if AFrom.X = AVia.X then
           Result := Coord(AVia.X - 1, AVia.Y)
         else
           Result := Coord(AVia.X, AVia.Y + 1);
    'F': if AFrom.X = AVia.X then
           Result := Coord(AVia.X + 1, AVia.Y)
         else
           Result := Coord(AVia.X, AVia.Y + 1);
  end;
  if LeaveTrace then
    Grid[AVia.X, AVia.Y] := 'S';
end;

procedure WalkPath(LeaveTrace: Boolean);
begin
  Prev1 := FindStart;
  Prev2 := Prev1;
  Current1 := Coord(Prev1.X - 1, Prev1.Y);
  Current2 := Coord(Prev2.X, Prev2.Y + 1);
  StepCount := 1;
  while not Current1.Equals(Current2) do
  begin
    Next1 := NextMove(Prev1, Current1, LeaveTrace);
    Next2 := NextMove(Prev2, Current2, LeaveTrace);
    Prev1 := Current1;
    Prev2 := Current2;
    Current1 := Next1;
    Current2 := Next2;
    Inc(StepCount);
  end;
  if LeaveTrace then
    Grid[Current1.X, Current1.Y] := 'S';
end;

begin
  Input := TStringList.Create;
  Bmp := TBitmap.Create;
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    ColCount := Length(Input[0]);
    RowCount := Input.Count;
    SetLength(Grid1, ColCount, RowCount);
    Grid := Grid1;
    for X := 0 to ColCount - 1 do
      for Y := 0 to RowCount - 1 do
        Grid[X, Y] := Input[Y][X + 1];
    WalkPath(False);
    WriteLn('Part I: ', StepCount);
  { Part II }
    ColCount := 2 * ColCount + 1;
    RowCount := 2 * RowCount + 1;
    SetLength(Grid2, ColCount, RowCount);
    Grid := Grid2;
    for X := 0 to ColCount - 1 do
      for Y := 0 to RowCount - 1 do
        if (X mod 2 = 1) and (Y mod 2 = 1) then
          Grid[X, Y] := Grid1[X div 2, Y div 2]
        else
          Grid[X, Y] := ' ';
    for X := 0 to ColCount - 1 do
      for Y := 0 to RowCount - 1 do
        if (X > 0) and (X < ColCount - 1) and
          CharInSet(Grid[X - 1, Y], ['F', '-', 'L', 'S']) and
          CharInSet(Grid[X + 1, Y], ['7', '-', 'J', 'S']) then
            Grid[X, Y] := 'H'
        else if (Y > 0) and (Y < RowCount - 1) and
          CharInSet(Grid[X, Y - 1], ['F', '|', '7', 'S']) and
          CharInSet(Grid[X, Y + 1], ['L', '|', 'J', 'S']) then
            Grid[X, Y] := 'V';
    WalkPath(True);
    Bmp.SetSize(ColCount, RowCount);
    for X := 0 to ColCount - 1 do
      for Y := 0 to RowCount - 1 do
        if Grid[X, Y] = 'S' then
          Bmp.Canvas.Pixels[X, Y] := clGreen
        else if CharInSet(Grid[X, Y], ['|', '-', 'F', 'J', '7', 'L', '.']) then
          Bmp.Canvas.Pixels[X, Y] := clBlue
        else
          Bmp.Canvas.Pixels[X, Y] := clRed;
    Bmp.Canvas.Brush.Color := clGreen;
    Bmp.Canvas.Brush.Style := bsSolid;
    Bmp.Canvas.FloodFill(0, 0, clGreen, fsBorder);
    StepCount := 0;
    for X := 0 to ColCount - 1 do
      for Y := 0 to RowCount - 1 do
        if Bmp.Canvas.Pixels[X, Y] = clBlue then
          Inc(StepCount);
    WriteLn('Part II: ', StepCount);
  finally
    Bmp.Free;
    Input.Free;
  end;
  ReadLn;
end.
