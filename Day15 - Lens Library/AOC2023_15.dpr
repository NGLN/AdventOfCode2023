program AOC2023_15;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.Generics.Collections;

var
  Input: TStringList;
  InitSeq: TArray<String>;
  S: String;
  SumOfHashes: Integer = 0;
  Boxes: TObjectList<TStringList>;
  I: Integer;

function Hash(const S: String): Integer;
var
  C: Char;
begin
  Result := 0;
  for C in S do
  begin
    Inc(Result, Ord(C));
    Result := Result * 17;
    Result := Result mod 256;
  end;
end;

procedure Process(const S: String);
var
  Lable: String;
  BoxId: Integer;
  FocalStrength: Integer;
  LensId: Integer;
begin
  if S[Length(S)] = '-' then
  begin
    Lable := Copy(S, 1, Length(S) - 1);
    BoxId := Hash(Lable);
    LensId := Boxes[BoxId].IndexOf(Lable);
    if LensId > -1 then
      Boxes[BoxId].Delete(LensId);
  end
  else
  begin
    Lable := Copy(S, 1, Length(S) - 2);
    BoxId := Hash(Lable);
    LensId := Boxes[BoxId].IndexOf(Lable);
    FocalStrength := StrToInt(S[Length(S)]);
    if LensId > -1 then
      Boxes[BoxId].Objects[LensId] := TObject(FocalStrength)
    else
      Boxes[BoxId].AddObject(Lable, TObject(FocalStrength));
  end;
end;

function FocusingPower: Integer;
var
  I: Integer;
  J: Integer;
begin
  Result := 0;
  for I := 0 to Boxes.Count - 1 do
    for J := 0 to Boxes[I].Count - 1 do
      Inc(Result, (I + 1) * (J + 1) * Integer(Boxes[I].Objects[J]));
end;

begin
  Input := TStringList.Create;
  Boxes := TObjectList<TStringList>.Create(True);
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    InitSeq := Input[0].Split([',']);
    for S in InitSeq do
      Inc(SumOfHashes, Hash(S));
    WriteLn('Part I: ', SumOfHashes);
  { Part II }
    for I := 0 to 255 do
      Boxes.Add(TStringList.Create);
    for S in InitSeq do
      Process(S);
    WriteLn('Part II: ', FocusingPower);
  finally
    Boxes.Free;
    Input.Free;
  end;
  ReadLn;
end.
