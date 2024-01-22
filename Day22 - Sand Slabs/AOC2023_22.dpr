program AOC2023_22;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  Aw.Types,
  System.Math,
  System.Generics.Collections,
  system.Generics.Defaults;

type
  TBrick = record
    P1: T3DCoord;
    P2: T3DCoord;
  end;

var
  Input: TStringList;
  Bricks: TList<TBrick>;

procedure ReadBricks;
var
  Line: String;
  Points: TArray<String>;
  Coords1: TArray<String>;
  Coords2: TArray<String>;
  Brick: TBrick;
  Z: Int64;
begin
  for Line in Input do
  begin
    Points := Line.Split(['~']);
    Coords1 := Points[0].Split([',']);
    Coords2 := Points[1].Split([',']);
    Z := Min(Coords1[2].ToInt64, Coords2[2].ToInt64);
    Brick.P1.Create(Coords1[0].ToInt64, Coords1[1].ToInt64, Z);
    Z := Max(Coords1[2].ToInt64, Coords2[2].ToInt64);
    Brick.P2.Create(Coords2[0].ToInt64, Coords2[1].ToInt64, Z);
    Bricks.Add(Brick);
  end;
end;

function CompareBricks(const Left, Right: TBrick): Integer;
begin
  Result := Left.P1.Z - Right.P1.Z;
end;

function Occupied(ACoord: T3DCoord): Boolean;
var
  Brick: TBrick;
  X: Int64;
  Y: Int64;
  Z: Int64;
begin
  Result := False;
  for Brick in Bricks do
  begin
    if Brick.P1.Z > ACoord.Z then
      Exit(False);
    for X := Brick.P1.X to Brick.P2.X do
      for Y := Brick.P1.Y to Brick.P2.Y do
        for Z := Brick.P1.Z to Brick.P2.Z do
          if ACoord.Equals(T3DCoord.Create(X, Y, Z)) then
            Exit(True);
  end;
end;

procedure Fall;
var
  I: Integer;
  Brick: TBrick;
  X: Int64;
  Y: Int64;
  Z: Int64;
  Clear: Boolean;
begin
  for I := 0 to Bricks.Count - 1 do
  begin
    Brick := Bricks[I];
    Clear := True;
    while Clear do
    begin
      Z := Brick.P1.Z;
      if Z = 1 then
        Clear := False;
      for X := Brick.P1.X to Brick.P2.X do
        for Y := Brick.P1.Y to Brick.P2.Y do
          if Occupied(T3DCoord.Create(X, Y, Z - 1)) then
            Clear := False;
      if Clear then
      begin
        Dec(Brick.P1.Z);
        Dec(Brick.P2.Z);
      end;
    end;
  end;
end;

function Position(ABrick: TBrick): String;
begin
  Result :=
    ABrick.P1.X.ToString + ', ' +
    ABrick.P1.Y.ToString + ', ' +
    ABrick.P1.Z.ToString + ' .. ' +
    ABrick.P2.X.ToString + ', ' +
    ABrick.P2.Y.ToString + ', ' +
    ABrick.P2.Z.ToString;
end;

procedure WriteAll;
var
  Brick: TBrick;
begin
  for Brick in Bricks do
    WriteLn(Position(Brick));
end;

begin
  Input := TStringList.Create;
  Bricks := TList<TBrick>.Create(TComparer<TBrick>.Construct(CompareBricks));
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    ReadBricks;
    Bricks.Sort;
    WriteAll;
    ReadLn;
    Fall;
    WriteAll;

    WriteLn('Part I: ');
  { Part II }
    WriteLn('Part II: ');
  finally
    Bricks.Free;
    Input.Free;
  end;
  ReadLn;
end.



