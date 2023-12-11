program AOC2023_08;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Types,
  System.Generics.Collections,
  System.Generics.Defaults;

var
  Input: TStringList;
  Navigate: String;
  Node: String = 'AAA';
  StepCount: Integer = 0;
  Elements: String;
  I: Integer;
  Nodes: array of String;

function Finished: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to Length(Nodes) - 1 do
    Result := Result and (Nodes[I][3] = 'Z');
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
    while Node <> 'ZZZ' do
    begin
      Inc(StepCount);
      Elements := Input.Values[Node];
      case Navigate[(StepCount - 1) mod Length(Navigate) + 1] of
        'L': Node := Copy(Elements, 2, 3);
        'R': Node := Copy(Elements, 6, 3);
      end;
    end;
    WriteLn('Part I: ', StepCount);
  { Part II }
    for I := 0 to Input.Count - 1 do
      if Input.Names[I][3] = 'A' then
      begin
        SetLength(Nodes, Length(Nodes) + 1);
        Nodes[Length(Nodes) - 1] := Input.Names[I];
      end;
    StepCount := 0;
    while not Finished do
    begin
      Inc(StepCount);
      for I := 0 to Length(Nodes) - 1 do
      begin
        Elements := Input.Values[Nodes[I]];
        case Navigate[(StepCount - 1) mod Length(Navigate) + 1] of
          'L': Nodes[I] := Copy(Elements, 2, 3);
          'R': Nodes[I] := Copy(Elements, 6, 3);
        end;
      end;
    end;
    WriteLn('Part II: ', StepCount);
  finally
    Input.Free;
  end;
  ReadLn;
end.
