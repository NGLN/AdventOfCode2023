program AOC2023_15;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils;

var
  Input: TStringList;
  InitSeq: TArray<String>;
  S: String;
  SumOfHashes: Integer = 0;

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

begin
  Input := TStringList.Create;
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    InitSeq := Input[0].Split([',']);
    for S in InitSeq do
      Inc(SumOfHashes, Hash(S));
    WriteLn('Part I: ', SumOfHashes);
  { Part II }

    WriteLn('Part II: ');
  finally
    Input.Free;
  end;
  ReadLn;
end.
