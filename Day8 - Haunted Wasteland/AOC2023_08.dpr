program AOC2023_08;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Types,
  System.Generics.Collections,
  System.Generics.Defaults,
  System.Math;

var
  Input: TStringList;
  Navigate: String;
  S: String = 'AAA';
  StepCount: Int64 = 0;
  Elements: String;
  I: Integer;
  Nodes: TArray<String>;
  CycleLengths: TArray<Int64>;
  StepCounts: TArray<Int64>;
  IMin: Integer;
  MinStepCount: Int64;

function AllEqual: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to Length(StepCounts) - 2 do
  begin
    Result := Result and (StepCounts[I] = StepCounts[I + 1]);
    if not Result then
      Break;
  end;
end;

function GCD(A, B: Int64): Int64; { Greatest common divisor }
begin
  if (B mod A) = 0 then
    Result := A
  else
    Result := GCD(B, A mod B);
end;

function LCM(A: TArray<Int64>): Int64; { Least common multiple }
var
  B: Int64;
begin
  Result := 1;
  for B in A do
    Result := (Result * B) div GCD(Result, B);
end;

begin
  Input := TStringList.Create;
  try
    Input.LoadFromFile('input.txt');
    Navigate := Input[0];
    Input.Delete(0);
    Input.Delete(0);
    Input.NameValueSeparator := '=';
    Input.Text := ReplaceText(Input.Text, ' ', '');
    Input.Sorted := True;
  { Part I }
    while S <> 'ZZZ' do
    begin
      Inc(StepCount);
      Elements := Input.Values[S];
      case Navigate[(StepCount - 1) mod Length(Navigate) + 1] of
        'L': S := Copy(Elements, 2, 3);
        'R': S := Copy(Elements, 6, 3);
      end;
    end;
    WriteLn('Part I: ', StepCount);
  { Part II - quick (with the help of Google)}
    for I := 0 to Input.Count - 1 do
      if Input.Names[I][3] = 'A' then
      begin
        SetLength(Nodes, Length(Nodes) + 1);
        Nodes[Length(Nodes) - 1] := Input.Names[I];
      end;
    SetLength(CycleLengths, Length(Nodes));
    for I := 0 to Length(Nodes) - 1 do
    begin
      CycleLengths[I] := 0;
      while Nodes[I][3] <> 'Z' do
      begin
        Inc(CycleLengths[I]);
        Elements := Input.Values[Nodes[I]];
        case Navigate[(CycleLengths[I] - 1) mod Length(Navigate) + 1] of
          'L': Nodes[I] := Copy(Elements, 2, 3);
          'R': Nodes[I] := Copy(Elements, 6, 3);
        end;
      end;
    end;
    StepCount := LCM(CycleLengths);
    WriteLn('Part II: ', StepCount);
  { Part II - slow (all of my own)}
    WriteLn('Wait for it...');
    StepCounts := Copy(CycleLengths, 0, Length(CycleLengths));
    IMin := -1;
    while not AllEqual do
    begin
      MinStepCount := High(Int64);
      for I := 0 to Length(StepCounts) - 1 do
        if StepCounts[I] < MinStepCount then
        begin
          MinStepCount := StepCounts[I];
          IMin := I;
        end;
      Inc(StepCounts[IMin], CycleLengths[IMin]);
    end;
    StepCount := StepCounts[0];
    WriteLn('Part II: ', StepCount);
  finally
    Input.Free;
  end;
  ReadLn;
end.
