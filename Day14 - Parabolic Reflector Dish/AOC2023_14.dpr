program AOC2023_14;

{$APPTYPE CONSOLE}

uses
  System.Classes;

var
  Input: TStringList;
  Platfrm: array of array of Char;
  RowCount: Integer;
  ColCount: Integer;

procedure Slide(OldX, OldY: Integer);
var
  NewX: Integer;
  NewY: Integer;
begin
  NewX := OldX;
  NewY := OldY;
  while (NewY - 1 >= 0) and (Platfrm[OldX, NewY - 1] = '.') do
    Dec(NewY);
  Platfrm[OldX, OldY] := '.';
  Platfrm[NewX, NewY] := 'O';
end;

procedure Tilt;
var
  X: Integer;
  Y: Integer;
begin
  for X := 0 to ColCount - 1 do
    for Y := 0 to RowCount - 1 do
      if Platfrm[X, Y] = 'O' then
        Slide(X, Y);
end;

procedure ReadPlatform;
var
  X: Integer;
  Y: Integer;
begin
  RowCount := Input.Count;
  ColCount := Length(Input[0]);
  SetLength(Platfrm, ColCount, RowCount);
  for X := 0 to ColCount - 1 do
    for Y := 0 to RowCount - 1 do
      Platfrm[X, Y] := Input[Y][X + 1];
end;

function TotalWeight: Integer;
var
  X: Integer;
  Y: Integer;
begin
  Result := 0;
  for X := 0 to ColCount - 1 do
    for Y := 0 to RowCount - 1 do
      if Platfrm[X, Y] = 'O' then
        Inc(Result, RowCount - Y);
end;

begin
  Input := TStringList.Create;
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    ReadPlatform;
    Tilt;
    WriteLn('Part I: ', TotalWeight);
  { Part II }

    WriteLn('Part II: ');
  finally
    Input.Free;
  end;
  ReadLn;
end.
