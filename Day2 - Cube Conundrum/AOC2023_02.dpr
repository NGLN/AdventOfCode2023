program AOC2023_02;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.Math;

type
  TColor = (R, G, B);

var
  Input: TStringList;
  GameId: Integer;
  Sets: TStringList;
  ASet: String;
  AColor: TColor;
  ColorNames: array[TColor] of String = ('red', 'green', 'blue');
  MaxCount: array[TColor] of Integer = (12, 13, 14);
  GamePossible: Boolean;
  SumOfPossibleGameIds: Integer;
  MinCubeCount: array[TColor] of Integer;
  PowerOfSets: Integer;
  SumOfPowerOfSets: Integer;

function CubeCountInSet(S: String; Color: TColor): Integer;
var
  C: Integer;
  L: Integer;
begin
  Result := 0;
  S := S + ',';
  L := Length(ColorNames[Color]);
  C := Pos(',', S);
  while C > 0 do
  begin
    if Copy(S, C - L, L) = Colornames[Color] then
      Result := StrToInt(Copy(S, 2, C - L - 3));
    Delete(S, 1, C);
    C := Pos(',', S);
  end
end;

begin
  Input := TStringList.Create;
  Sets := TStringList.Create;
  try
    Input.LoadFromFile('input.txt');
    Input.NameValueSeparator := ':';
    Sets.StrictDelimiter := True;
    Sets.Delimiter := ';';
    SumOfPossibleGameIds := 0;
  { Part I }
    for GameId := 1 to Input.Count do
    begin
      GamePossible := True;
      Sets.DelimitedText := Input.ValueFromIndex[GameId - 1];
      for ASet in Sets do
        for AColor := Low(AColor) to High(AColor) do
          if CubeCountInSet(ASet, AColor) > MaxCount[AColor] then
            GamePossible := False;
      if GamePossible then
        Inc(SumOfPossibleGameIds, GameId);
    end;
    WriteLn('Part I: ', SumOfPossibleGameIds);
  { Part II }
    SumOfPowerOfSets := 0;
    for GameId := 1 to Input.Count do
    begin
      Sets.DelimitedText := Input.ValueFromIndex[GameId - 1];
      for AColor := Low(AColor) to High(AColor) do
        MinCubeCount[AColor] := 0;
      for ASet in Sets do
        for AColor := Low(AColor) to High(AColor) do
          MinCubeCount[AColor] := Max(MinCubeCount[AColor],
            CubeCountInSet(ASet, AColor));
      PowerOfSets := 1;
      for AColor := Low(AColor) to High(AColor) do
        PowerOfSets := PowerOfSets * MinCubeCount[AColor];
      Inc(SumOfPowerOfSets, PowerOfSets);
    end;
    WriteLn('Part II: ', SumOfPowerOfSets);
  finally
    Sets.Free;
    Input.Free;
  end;
  ReadLn;
end.
