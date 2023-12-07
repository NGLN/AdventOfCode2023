program AOC2023_05;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Types,
  System.Generics.Collections,
  System.Generics.Defaults;

type
  TMapping = record
    Source: Cardinal;
    Dest: Cardinal;
    Range: Cardinal;
  end;
  TMap = TList<TMapping>;

var
  Input: TStringList;
  Maps: TObjectList<TMap>;
  MappingComparison: TComparison<TMapping>;
  DefaultCardinalComparer: IComparer<Cardinal>;

procedure ReadMaps;
var
  I: Integer;
  Map: TMap;
  Mapping: TMapping;
  Line: TStringDynArray;
  J: Integer;
begin
  Input.Add('');
  for I := 2 to Input.Count - 1 do
    if ContainsStr(Input[I], ' map:') then
    begin
      Map := TMap.Create(TComparer<TMapping>.Construct(MappingComparison));
      Maps.Add(Map);
    end
    else if Input[I] = '' then
    begin
      Map.Sort;
      for J := Map.Count - 1 downto 1 do
        if Map[J].Source <> (Map[J - 1].Source + Map[J - 1].Range) then
        begin
          Mapping.Source := Map[J - 1].Source + Map[J - 1].Range;
          Mapping.Dest := Mapping.Source;
          Mapping.Range := Map[J].Source - Mapping.Source;
          Map.Insert(J, Mapping);
        end;
    end
    else
    begin
      Line := SplitString(Input[I], ' ');
      Mapping.Dest := StrToUInt(Line[0]);
      Mapping.Source := StrToUInt(Line[1]);
      Mapping.Range := StrToUInt(Line[2]);
      Map.Add(Mapping);
    end;
end;

function GetLocation(Seed: Cardinal): Cardinal;
var
  Map: TMap;
  I: Integer;
begin
  Result := Seed;
  for Map in Maps do
  begin
    for I := 1 to Map.Count - 1 do
      if Result < Map[I].Source then
      begin
        Result := Result - Map[I - 1].Source + Map[I - 1].Dest;
        Break;
      end;
  end;
end;

var
  Seeds: TStringDynArray;
  S: String;
  Locations: TList<Cardinal>;

begin
  DefaultCardinalComparer := TComparer<Cardinal>.Default;
  MappingComparison :=
    function(const Left, Right: TMapping): Integer
    begin
      Result := DefaultCardinalComparer.Compare(Left.Source, Right.Source);
    end;
  Input := TStringList.Create;
  Maps := TObjectList<TMap>.Create(True);
  Locations := TList<Cardinal>.Create;
  try
    Input.LoadFromFile('input.txt');
  { Part I }
    Seeds := SplitString(Trim(Copy(Input[0], 7, 1000)), ' ');
    ReadMaps;
    for S in Seeds do
      Locations.Add(GetLocation(StrToUInt(S)));
    Locations.Sort;
    WriteLn('Part I: ', Locations[0]);
  { Part II }

    WriteLn('Part II: ');
  finally
    Locations.Free;
    Maps.Free;
    Input.Free;
  end;
  ReadLn;
end.

