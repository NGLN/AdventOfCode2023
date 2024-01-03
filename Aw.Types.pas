unit Aw.Types;

interface

type
  TInt64Coord = record
    X: Int64;
    Y: Int64;
    constructor Create(AX, AY: Int64);
    function Equals(const ACoord: TInt64Coord): Boolean;
    function StepCountTo(const ACoord: TInt64Coord): Int64;
  end;

  TCoord = TInt64Coord;

function Coord(AX, AY: Int64): TInt64Coord;

implementation

function Coord(AX, AY: Int64): TInt64Coord;
begin
  Result := TInt64Coord.Create(AX, AY);
end;

constructor TInt64Coord.Create(AX, AY: Int64);
begin
  Self.X := AX;
  Self.Y := AY;
end;

function TInt64Coord.Equals(const ACoord: TInt64Coord): Boolean;
begin
  Result := (ACoord.X = X) and (ACoord.Y = Y);
end;

function TInt64Coord.StepCountTo(const ACoord: TInt64Coord): Int64;
begin
  Result := Abs(ACoord.Y - Y) + Abs(ACoord.X - X);
end;

end.
