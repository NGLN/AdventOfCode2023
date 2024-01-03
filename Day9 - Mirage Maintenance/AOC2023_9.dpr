program AOC2023_9;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Types,
  System.Generics.Collections,
  System.Generics.Defaults,
  System.Math;

type
  TValues = TList<Int64>;
  TSensor = TObjectList<TValues>;

var
  Input: TStringList;
  Sensors: TList<TSensor>;
  
function Zero(Values: TValues): Boolean;
var
  Value: Int64;
begin
  Result := False;
  for Value in Values do
    if Value <> 0 then
      Exit;
  Result := True;
end;

function SumOfExtrapolations(PartII: Boolean): Int64;
var
  Line: String;
  History: TArray<String>;
  Hist: String;
  Sensor: TSensor;
  Prev: TValues;
  Last: TValues;
  I: Integer;
begin
  Sensors.Clear;
  Result := 0;
  for Line in Input do
  begin
    History := Line.Split([' ']);
    Sensor := TSensor.Create(True);
    Sensors.Add(Sensor);
    Sensor.Add(TList<Int64>.Create);
    for Hist in History do
      Sensor.Last.Add(StrToInt(Hist));
    while not Zero(Sensor.Last) do
    begin
      Prev := Sensor.Last; 
      Last := TList<Int64>.Create;
      Sensor.Add(Last);
      for I := 0 to Prev.Count - 2 do
        Last.Add(Prev[I + 1] - Prev[I]);
    end;
    if PartII then
    begin
      for I := Sensor.Count - 1 downto 1 do
        Sensor[I - 1].Insert(0, Sensor[I - 1].First - Sensor[I].First);
      Inc(Result, Sensor[0].First);  
    end
    else
    begin
      for I := Sensor.Count - 1 downto 1 do
        Sensor[I - 1].Add(Sensor[I].Last + Sensor[I - 1].Last);
      Inc(Result, Sensor[0].Last);  
    end;
  end;
end;

begin
  Input := TStringList.Create;
  Sensors := TObjectList<TSensor>.Create(True);
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    WriteLn('Part I: ', SumOfExtrapolations(False));
  { Part II }
    WriteLn('Part II: ', SumOfExtrapolations(True));
  finally
    Sensors.Free;
    Input.Free;
  end;
  ReadLn;
end.
