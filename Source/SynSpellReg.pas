unit SynSpellReg;

{$i synedit.inc}

interface

uses
  Classes,
  SynSpellCheck;

procedure Register;

implementation

procedure Register;
begin
{$IFDEF SPELLCHECK}
  RegisterComponents('SynEdit', [TSynSpellCheck]);
{$ENDIF}
end;

end.
