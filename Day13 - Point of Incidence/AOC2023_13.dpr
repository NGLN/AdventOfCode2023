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

type
  TStringListHelper = class helper for TStringList
    function ColCount: Integer;
    function RowCount: Integer;
    procedure TransposeTo(AStringList: TStringList);
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

function TStringListHelper.RowCount: Integer;
var
  I: Integer;
  Mirrored: Boolean;
  Offset: Integer;
begin
  Result := 0;
  for I := 0 to Count - 2 do
    if Strings[I] = Strings[I + 1] then
    begin
      Mirrored := True;
      Offset := 1;
      while Mirrored and (I - Offset >= 0) and (I + 1 + Offset < Count) do
      begin
        Mirrored := Strings[I - Offset] = Strings[I + 1 + Offset];
        Inc(Offset);
      end;
      if Mirrored then
        Exit(I + 1);
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
    SumOfPatternNotes := 0;    
    for Pattern in Patterns do
      Inc(SumOfPatternNotes, Pattern.ColCount + 100 * Pattern.RowCount);
    WriteLn('Part I: ', SumOfPatternNotes);
  { Part II }

    WriteLn('Part II: ');
  finally
    Patterns.Free;
    Input.Free;
  end;
  ReadLn;
end.
