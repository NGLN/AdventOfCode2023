program AOC2023_06;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Types,
  System.Generics.Collections,
  System.Generics.Defaults;

type
  TRace = record
    Time: Integer;
    Dist: Integer;
  end;

var
  Input: TStringList;
  Races: TList<TRace>;

procedure ReadRaces;
var
  I: Integer;
  Race: TRace;
begin
  for I := 0 to 3 do
  begin
    Race.Time := StrToInt(Trim(Copy(Input[0], 12 + I * 7, 4)));
    Race.Dist := StrToInt(Trim(Copy(Input[1], 12 + I * 7, 4)));
    Races.Add(Race);
  end;
end;

function GetDist(PressTime, RaceTime: Int64): Int64;
begin
  Result := (RaceTime - PressTime) * PressTime;
end;

var
  Race: TRace;
  T: Int64;
  NoOfWaysToBeat: Int64;
  ProductOflNoOfWaysToBeat: Int64;

begin
  Input := TStringList.Create;
  Races := TList<TRace>.Create;
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    ReadRaces;
    ProductOflNoOfWaysToBeat := 1;
    for Race in Races do
    begin
      NoOfWaysToBeat := 0;
      for T := 0 to Race.Time do
        if GetDist(T, Race.Time) > Race.Dist then
          Inc(NoOfWaysToBeat);
      ProductOflNoOfWaysToBeat := ProductOflNoOfWaysToBeat * NoOfWaysToBeat;
    end;
    WriteLn('Part I: ', ProductOflNoOfWaysToBeat);
  { Part II }
    NoOfWaysToBeat := 0;
    for T := 0 to 59707878 do
      if GetDist(T, 59707878) > 430121812131276 then
        Inc(NoOfWaysToBeat);
    WriteLn('Part II: ', NoOfWaysToBeat);
  finally
    Races.Free;
    Input.Free;
  end;
  ReadLn;
end.

