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

  T3DInt64Coord = record
    X: Int64;
    Y: Int64;
    Z: Int64;
    constructor Create(AX, AY, AZ: Int64);
    function Equals(const ACoord: T3DInt64Coord): Boolean;
  end;

  T3DCoord = T3DInt64Coord;

function Coord(AX, AY: Int64): TInt64Coord; overload
function Coord(AX, AY, AZ: Int64): T3DInt64Coord; overload

implementation

function Coord(AX, AY: Int64): TInt64Coord; overload
begin
  Result := TInt64Coord.Create(AX, AY);
end;

function Coord(AX, AY, AZ: Int64): T3DInt64Coord; overload
begin
  Result := T3DInt64Coord.Create(AX, AY, AZ);
end;

{ TInt64Coord }

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

{ T3DInt64Coord }

constructor T3DInt64Coord.Create(AX, AY, AZ: Int64);
begin
  Self.X := AX;
  Self.Y := AY;
  Self.Z := AZ;
end;

function T3DInt64Coord.Equals(const ACoord: T3DInt64Coord): Boolean;
begin
  Result := (ACoord.X = X) and (ACoord.Y = Y) and (ACoord.Z = Z);
end;

end.
