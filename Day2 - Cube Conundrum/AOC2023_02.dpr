program AOC2023_02;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils;

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
  SumOfPowerOfSets: Integer absolute SumOfPossibleGameIds;
  CubeCount: array[TColor] of Integer;

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
        CubeCount[AColor] := 0;
      for ASet in Sets do
        for AColor := Low(AColor) to High(AColor) do
          Inc(CubeCount[AColor], CubeCountInSet(ASet, AColor));


          
      for ASet in Sets do
        for AColor := Low(AColor) to High(AColor) do
          if CubeCountInSet(ASet, AColor) > MaxCount[AColor] then
            GamePossible := False;

      Inc(SumOfPossibleGameIds, GameId);
    end;


    WriteLn('Part II: ');
  finally
    Sets.Free;
    Input.Free;
  end;
  ReadLn;
end.


3287 is too high
132 is too low
2119 is too low


  CubeCount: array[TColor] of Integer;

      if GameId = 0 then
      begin
        WriteLn(Input.ValueFromIndex[0]);
        for ASet in Sets do
          WriteLn(ASet);
        for ASet in Sets do
          for AColor := Low(AColor) to High(AColor) do
            WriteLn(ColorNames[AColor], ':', CubeCountInSet(ASet, AColor));
      end;
    
      for AColor := Low(AColor) to High(AColor) do
        CubeCount[AColor] := 0;
      for ASet in Sets do
        for AColor := Low(AColor) to High(AColor) do
          Inc(CubeCount[AColor], CubeCountInSet(ASet, AColor));
      for ASet in Sets do
        for AColor := Low(AColor) to High(AColor) do
          if CubeCountInSet(ASet, AColor) > MaxCount[AColor] then
            GamePossible := False;
{
        for AColor := Low(AColor) to High(AColor) do
          if CubeCount[AColor] > MaxCount[AColor] then
            GamePossible := False;
    
