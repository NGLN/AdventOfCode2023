program AOC2023_14;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.Generics.Collections;

var
  Input: TStringList;
  Platfrm: array of array of Char;
  RowCount: Integer;
  ColCount: Integer;

type
  TWind = (N, W, S, E);

procedure Slide(OldX, OldY: Integer; Wind: TWind);
var
  NewX: Integer;
  NewY: Integer;
begin
  NewX := OldX;
  NewY := OldY;
  case Wind of
    N:
      while (NewY - 1 >= 0) and (Platfrm[OldX, NewY - 1] = '.') do
        Dec(NewY);
    W:
      while (NewX - 1 >= 0) and (Platfrm[NewX - 1, OldY] = '.') do
        Dec(NewX);
    S:
      while (NewY + 1 < RowCount) and (Platfrm[OldX, NewY + 1] = '.') do
        Inc(NewY);
    E:
      while (NewX + 1 < ColCount) and (Platfrm[NewX + 1, OldY] = '.') do
        Inc(NewX);
  end;
  Platfrm[OldX, OldY] := '.';
  Platfrm[NewX, NewY] := 'O';
end;

procedure Tilt(Wind: TWind);
var
  X: Integer;
  Y: Integer;
begin
  case Wind of
    N, W:
      for X := 0 to ColCount - 1 do
        for Y := 0 to RowCount - 1 do
          if Platfrm[X, Y] = 'O' then
            Slide(X, Y, Wind);
    S, E:
      for X := ColCount - 1 downto 0 do
        for Y := RowCount - 1 downto 0 do
          if Platfrm[X, Y] = 'O' then
            Slide(X, Y, Wind);
  end;
end;

procedure PerformCycle;
begin
  Tilt(N);
  Tilt(W);
  Tilt(S);
  Tilt(E);
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

var
  Weights: TList<Integer>;
  I: Integer;
  J: Integer;
  PatternSize: Integer;
  CycleCount: Integer = 1000000000;

begin
  Input := TStringList.Create;
  Weights := TList<Integer>.Create;
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    ReadPlatform;
    Tilt(N);
    WriteLn('Part I: ', TotalWeight);
  { Part II }
    ReadPlatform;
    for I := 0 to 1000 do
    begin
      PerformCycle;
      Weights.Add(TotalWeight);
    end;
    I := Weights.IndexOf(99099);
    Weights[I] := 0;
    J := Weights.IndexOf(99099);
    PatternSize := J - I;
    while CycleCount >= J do
      Dec(CycleCount, PatternSize);
    WriteLn('Part II: ', Weights[CycleCount - 1]);
  finally
    Weights.Free;
    Input.Free;
  end;
  ReadLn;
end.
