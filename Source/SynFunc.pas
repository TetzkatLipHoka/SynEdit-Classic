{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: SynFunc.pas, released 2026-11-14.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.

Known Issues:
-------------------------------------------------------------------------------}

// Compatibility unit for code that is shared with the TurboPack SynEdit.
//
// TurboPack declares TSynNativeInt and TSynNativeUInt in its SynFunc unit and
// uses them in events, plugin overrides and line indexes. With this unit,
// shared code can list SynFunc and use these types without an IFDEF per
// generation.
//
// Only the types are here. The functions of the TurboPack SynFunc unit are
// not, so calling one of them still fails to compile against this SynEdit.
// The types are always 32 bit because this SynEdit uses Integer and Cardinal
// in those places, on Win64 as well.

unit SynFunc;

interface

type
  TSynNativeInt  = Integer;
  TSynNativeUInt = Cardinal;

implementation

end.
