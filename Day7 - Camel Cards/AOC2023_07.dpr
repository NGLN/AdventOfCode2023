program AOC2023_07;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Types,
  System.Generics.Collections,
  System.Generics.Defaults;

type
  THandType = (HighCard, OnePair, TwoPair, ThreeOfAKind, FullHouse,
    FourOfAKind, FiveOfAKind);

  THand = record
    Hand: String;
    Bid: Integer;
    HandType: THandType;
  end;

var
  Input: TStringList;
  Hands: TList<THand>;
  HandComparison: TComparison<THand>;
  PartII: Boolean = False;
  TotalWinnings: Int64;
  I: Integer;

function GetValue(C: Char): Integer;
begin
  case C of
    '2'..'9': Result := StrToInt(C);
    'T': Result := 10;
    'J':
      if PartII then
        Result := 1
      else
        Result := 11;
    'Q': Result := 12;
    'K': Result := 13;
    else {'A'}
      Result := 14;
  end;
end;

procedure ReadHands;
var
  Chars: TStringList;
  I: Integer;
  Hand: THand;

  function Product2: Integer;
  begin
    Result := Integer(Chars.Objects[0]) * Integer(Chars.Objects[1]);
  end;

  function Product3: Integer;
  begin
    Result := Integer(Chars.Objects[0]) * Integer(Chars.Objects[1]) *
      Integer(Chars.Objects[2]);
  end;

  function GetHandType(const AHand: String): THandType;
  var
    C: Char;
    I: Integer;
    JCount: Integer;
    IMax: Integer;
    MaxCount: Integer;
  begin
    Chars.Clear;
    JCount := 0;
    for C in AHand do
      if PartII and (C = 'J') then
        Inc(JCount)
      else if Chars.Find(C, I) then
        Chars.Objects[I] := TObject(Integer(Chars.Objects[I]) + 1)
      else
        Chars.AddObject(C, TObject(1));
    if PartII and (JCount < 5) then
    begin
      IMax := -1;
      MaxCount := 0;
      for I := 0 to Chars.Count - 1 do
        if Integer(Chars.Objects[I]) > MaxCount then
        begin
          IMax := I;
          MaxCount := Integer(Chars.Objects[I]);
        end;
      Chars.Objects[IMax] := TObject(Integer(Chars.Objects[IMax]) + JCount);
    end;
    if Chars.Count = 5 then
      Result := HighCard
    else if Chars.Count = 4 then
      Result := OnePair
    else if (Chars.Count = 3) and (Product3 = 2 * 2 * 1) then
      Result := TwoPair
    else if (Chars.Count = 3) and (Product3 = 3 * 1 * 1) then
      Result := ThreeOfAKind
    else if (Chars.Count = 2) and (Product2 = 3 * 2) then
      Result := FullHouse
    else if (Chars.Count = 2) and (Product2 = 4 * 1) then
      Result := FourOfAKind
    else
      Result := FiveOfAKind;
  end;

begin
  Input.NameValueSeparator := ' ';
  Chars := TStringList.Create;
  Chars.Sorted := True;
  try
    for I := 0 to Input.Count - 1 do
    begin
      Hand.Hand := Input.Names[I];
      Hand.Bid := StrToInt(Input.ValueFromIndex[I]);
      Hand.HandType := GetHandType(Hand.Hand);
      Hands.Add(Hand);
    end;
  finally
    Chars.Free;
  end;
end;

begin
  HandComparison :=
    function(const Left, Right: THand): Integer
    begin
      Result := Ord(Left.HandType) - Ord(Right.HandType);
      if Result = 0 then
        Result := GetValue(Left.Hand[1]) - GetValue(Right.Hand[1]);
      if Result = 0 then
        Result := GetValue(Left.Hand[2]) - GetValue(Right.Hand[2]);
      if Result = 0 then
        Result := GetValue(Left.Hand[3]) - GetValue(Right.Hand[3]);
      if Result = 0 then
        Result := GetValue(Left.Hand[4]) - GetValue(Right.Hand[4]);
      if Result = 0 then
        Result := GetValue(Left.Hand[5]) - GetValue(Right.Hand[5]);
    end;
  Input := TStringList.Create;
  try
    Input.LoadFromFile('input.txt');
    Hands := TList<THand>.Create(TComparer<THand>.Construct(HandComparison));
  { Part I }
    ReadHands;
    Hands.Sort;
    TotalWinnings := 0;
    for I := 0 to Hands.Count - 1 do
      Inc(TotalWinnings, (I + 1) * Hands[I].Bid);
    WriteLn('Part I: ', TotalWinnings);
  { Part II }
    PartII := True;
    Hands.Clear;
    ReadHands;
    Hands.Sort;
    TotalWinnings := 0;
    for I := 0 to Hands.Count - 1 do
      Inc(TotalWinnings, (I + 1) * Hands[I].Bid);
    WriteLn('Part II: ', TotalWinnings);
  finally
    Hands.Free;
    Input.Free;
  end;
  ReadLn;
end.
