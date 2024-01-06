program AOC2023_13;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.Generics.Collections;

var
  Input: TStringList;
  Patterns: TObjectList<TStringList>;
  Pattern: TStringList;
  Line: String;
  SumOfPatternNotes: Integer;
  PartII: Boolean;

type
  TStringListHelper = class helper for TStringList
    function ColCount: Integer;
    function RowCount: Integer;
    procedure TransposeTo(AStringList: TStringList);
    function Mirrored(ARowCount, SmudgeCount: Integer): Boolean;
  end;

{ TStringListHelper }

function TStringListHelper.ColCount: Integer;
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    TransposeTo(SL);
    Result := SL.RowCount;
  finally
    SL.Free;
  end;
end;

function TStringListHelper.Mirrored(ARowCount, SmudgeCount: Integer): Boolean;
var
  I: Integer;
  J: Integer;
  K: Integer;
  Smudges: Integer;
begin
  I := ARowCount - 1;
  J := I + 1;
  Smudges := 0;
  while (Smudges <= SmudgeCount) and (I >= 0) and (J < Count) do
  begin
    for K := 1 to Length(Strings[0]) do
      if Strings[I][K] <> Strings[J][K] then
        Inc(Smudges);
    Dec(I);
    Inc(J);
  end;
  Result := Smudges = SmudgeCount;
end;

function TStringListHelper.RowCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 1 to Count - 1 do
    if Mirrored(I, 0) then
    begin
      Result := I;
      Break;
    end;
  if PartII then
  begin
    for I := 1 to Count - 1 do
      if Mirrored(I, 1) and (I <> Result) then
        Exit(I);
    Result := 0;
  end;
end;

procedure TStringListHelper.TransposeTo(AStringList: TStringList);
var
  I: Integer;
  S: String;
  Line: String;
begin
  AStringList.Clear;
  for I := 1 to Length(Strings[0]) do
  begin
    S := '';
    for Line in Self do
      S := S + Line[I];
    AStringList.Add(S);
  end;
end;
 
begin
  Input := TStringList.Create;
  Patterns := TObjectList<TStringList>.Create(True);
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    Input.Insert(0, '');
    Pattern := nil;
    for Line in Input do
      if Line = '' then
      begin
        Pattern := TStringList.Create;
        Patterns.Add(Pattern);
      end
      else
        Pattern.Add(Line);
    PartII := False;
    SumOfPatternNotes := 0;    
    for Pattern in Patterns do
      Inc(SumOfPatternNotes, Pattern.ColCount + 100 * Pattern.RowCount);
    WriteLn('Part I: ', SumOfPatternNotes);
  { Part II }
    PartII := True;
    SumOfPatternNotes := 0;    
    for Pattern in Patterns do
      Inc(SumOfPatternNotes, Pattern.ColCount + 100 * Pattern.RowCount);
    WriteLn('Part II: ', SumOfPatternNotes);
  finally
    Patterns.Free;
    Input.Free;
  end;
  ReadLn;
end.
