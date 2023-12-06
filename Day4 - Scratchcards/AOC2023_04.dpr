program AOC2023_04;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Types;

var
  Input: TStringList;
  PosW: Integer;
  PosH: Integer;
  Winning: array of TStringDynArray;
  Having: array of TStringDynArray;
  CardCounts: array of Integer;
  TotalCardPoints: Integer;
  TotalCardCount: Integer;
  I: Integer;
  J: Integer;
  MatchCount: Integer;
  CardPoints: Integer;

begin
  Input := TStringList.Create;
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    PosW := Pos(':', Input[0]) + 1;
    PosH := Pos('|', Input[0]) + 1;
    SetLength(Winning, Input.Count);
    SetLength(Having, Input.Count);
    SetLength(CardCounts, Input.Count);
    TotalCardPoints := 0;
    TotalCardCount := 0;
    for I := 0 to Input.Count - 1 do
    begin
      Winning[I] := SplitString(ReplaceStr(Trim(
        Copy(Input[I], PosW, PosH - PosW - 1)), '  ', ' '), ' ');
      Having[I] := SplitString(ReplaceStr(Trim(
        Copy(Input[I], PosH, 1000)), '  ', ' '), ' ');
      MatchCount := 0;
      CardPoints := 0;
      for J := 0 to Length(Having[I]) - 1 do
        if MatchText(Having[I][J], Winning[I]) then
        begin
          Inc(MatchCount);
          if CardPoints = 0 then
            CardPoints := 1
          else
            CardPoints := CardPoints * 2;
        end;
      Inc(TotalCardPoints, CardPoints);
      Inc(CardCounts[I]);
      for J := I + 1 to I + MatchCount do
        Inc(CardCounts[J], CardCounts[I]);
      Inc(TotalCardCount, CardCounts[I]);
    end;
    WriteLn('Part I: ', TotalCardPoints);
  { Part II }
    WriteLn('Part II: ', TotalCardCount);
  finally
    Input.Free;
  end;
  ReadLn;
end.
