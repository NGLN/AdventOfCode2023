program AOC2023_11;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.Generics.Collections,
  Aw.Types;

var
  Input: TStringList;
  Galaxies: TList<TInt64Coord>;
  I: Integer;
  J: Integer;
  SumOfShortestPathLengths: Int64;

function EmptyCol(Index: Integer): Boolean;
var
  Line: String;
begin
  for Line in Input do
    if Line[Index] = '#' then
      Exit(False);
  Result := True;
end;

function EmptyRow(Row: String): Boolean;
begin
  Result := Row = StringOfChar('.', Length(Input[0]));
end;

procedure ReadGalaxies(EmptySize: Integer);
var
  Line: String;
  I: Integer;
  X: Integer;
  Y: Integer;
begin
  Galaxies.Clear;
  Y := 0;
  for Line in Input do
  begin
    if EmptyRow(Line) then
      Inc(Y, EmptySize - 1);
    X := 0;
    for I := 1 to Length(Line) do
    begin
      if EmptyCol(I) then
        Inc(X, EmptySize - 1);
      if Line[I] = '#' then
        Galaxies.Add(TInt64Coord.Create(X, Y));
      Inc(X);
    end;
    Inc(Y);
  end;
end;

begin
  Input := TStringList.Create;
  Galaxies := TList<TInt64Coord>.Create;
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    ReadGalaxies(2);
    SumOfShortestPathLengths := 0;
    for I := 0 to Galaxies.Count - 1 do
      for J := I + 1 to Galaxies.Count - 1 do
        Inc(SumOfShortestPathLengths, Galaxies[I].StepCountTo(Galaxies[J]));
    WriteLn('Part I: ', SumOfShortestPathLengths);
  { Part II }
    ReadGalaxies(1000000);
    SumOfShortestPathLengths := 0;
    for I := 0 to Galaxies.Count - 1 do
      for J := I + 1 to Galaxies.Count - 1 do
        Inc(SumOfShortestPathLengths, Galaxies[I].StepCountTo(Galaxies[J]));
    WriteLn('Part II: ', SumOfShortestPathLengths);
  finally
    Galaxies.Free;
    Input.Free;
  end;
  ReadLn;
end.
