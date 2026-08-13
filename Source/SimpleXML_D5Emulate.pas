unit SimpleXML_D5Emulate;

interface
uses Sysutils;

type
	TVarType = Word;

const
	varShortInt = $0010; { vt_i1          16 }
	varWord     = $0012; { vt_ui2         18 }
	varLongWord = $0013; { vt_ui4         19 }
	varInt64    = $0014; { vt_i8          20 }

function VarIsNumeric(const V: Variant): Boolean;
function VarSameValue(const A, B: Variant): Boolean;

function EncodeDateTime(y, m, d, h, n, ss, mss : word) : TDateTime;
procedure DecodeDateTime(Date: TDateTime; var Year, Month, Day, Hour, Min, Sec, MSec: Word);

implementation

function EncodeDateTime(y, m, d, h, n, ss, mss : word) : TDateTime;
begin
  Result := EncodeDate(y, m, d) + EncodeTime (h, n, ss, mss);
end;

procedure DecodeDateTime(Date: TDateTime; var Year, Month, Day, Hour, Min, Sec, MSec: Word);
begin
  DecodeDate(Date, Year, Month, Day);
  DecodeTime(Date, Hour, Min, Sec, MSec);
end;

function VarTypeIsOrdinal(const AVarType: TVarType): Boolean;
begin
	Result := AVarType in [varSmallInt, varInteger, varBoolean, varShortInt,
												 varByte, varWord, varLongWord, varInt64];
end;

function VarIsOrdinal(const V: Variant): Boolean;
begin
	Result := VarTypeIsOrdinal(TVarData(V).VType);
end;

function VarTypeIsFloat(const AVarType: TVarType): Boolean;
begin
	Result := AVarType in [varSingle, varDouble, varCurrency];
end;

function VarIsFloat(const V: Variant): Boolean;
begin
	Result := VarTypeIsFloat(TVarData(V).VType);
end;

function VarTypeIsNumeric(const AVarType: TVarType): Boolean;
begin
	Result := VarTypeIsOrdinal(AVarType) or VarTypeIsFloat(AVarType);
end;

function VarIsNumeric(const V: Variant): Boolean;
begin
	Result := VarTypeIsNumeric(TVarData(V).VType);
end;


function FindVarData(const V: Variant): PVarData;
begin
  Result := @TVarData(V);
  while Result.VType = varByRef or varVariant do
    Result := PVarData(Result.VPointer);
end;


function VarSameValue(const A, B: Variant): Boolean;
var
  LA, LB: TVarData;
begin
  LA := FindVarData(A)^;
  LB := FindVarData(B)^;
  if LA.VType = varEmpty then
    Result := LB.VType = varEmpty
  else if LA.VType = varNull then
    Result := LB.VType = varNull
  else if LB.VType in [varEmpty, varNull] then
    Result := False
  else
    Result := A = B;
end;


end.
