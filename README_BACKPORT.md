# SynEdit-Classic — Delphi 7 to 11 (based on SynEdit/SynEdit, Jan 2022)

Based on the final state of the official repository
[SynEdit/SynEdit](https://github.com/SynEdit/SynEdit) (last commit 2022-01-29) —
the last SynEdit line that supports Delphi 7 (officially D7 through 11 Alexandria).
The modern line lives on in the
[VSoft fork](https://github.com/VSoftTechnologies/SynEdit) (10.4+, DirectWrite,
multi-caret); the two are no longer mergeable.

## Directory layout

The layout deliberately mirrors the VSoft fork so that package path and package
name stay the same across all Delphi generations:

```
Source\               core units
Source\Highlighters\  all highlighters
Source\Packages\      SynEdit_R.dpk / SynEdit_D.dpk plus project groups
```

Highlighters therefore include their configuration as `{$I ..\SynEdit.inc}`.
**Note that this is not sufficient on its own:** `SynEdit.inc` pulls in
`SynEditJedi.inc`, and a nested `{$I}` is *not* resolved relative to the
including `.inc`. `Source` has to be on the include search path; the supplied
`.dof`/`.cfg` files already do that.

## Packages

A single pair serves Delphi 7 **and** Delphi 2009:

| File | Purpose |
|---|---|
| `SynEdit_R.dpk` / `SynEdit_D.dpk` | runtime and design time |
| `SynEdit.bpg` | project group, Delphi 7 |
| `SynEdit.groupproj` + `SynEdit_R.dproj` / `SynEdit_D.dproj` | project group, Delphi 2009 (format 12.0) |
| `SynEdit_R.dof` / `.cfg`, `SynEdit_D.dof` / `.cfg` | search path and output directory |

The two compilers are told apart with `{$IFNDEF UNICODE}` and
`{$IF CompilerVersion}`. `LIBSUFFIX` yields `SynEdit_R70.bpl` and
`SynEdit_R2009.bpl` respectively.

Non-Unicode branch only (that is, Delphi 7): the SynUni, spell check and
SimpleXML suites. `SynSpellCheck` is not Unicode clean — it indexes its tables
with `Ord(character)` over `array[0..255]`, so it is byte oriented by design.
Also excluded: `SynHighlighterAsmMASM` before Delphi 2010 (needs `IOUtils`) and
code folding before XE (`SynEditCodeFolding.pas` needs `Generics.Defaults`).

### Building

From `Source\Packages`, with `<Lib>` being `C:\Delphi\7\Lib` or
`C:\Delphi\2009\lib`:

```
dcc32 SynEdit_R.dpk -B -Q -U"<Lib>;<Out>;..;..\Highlighters" -I"<Lib>;..;..\Highlighters" -R"<Lib>;.." -N"<Out>" -LE"<Out>" -LN"<Out>"
dcc32 SynEdit_D.dpk -B -Q -U"<Lib>;<Out>;..;..\Highlighters" -I"<Lib>;..;..\Highlighters" -R"<Lib>;.." -N"<Out>" -LE"<Out>" -LN"<Out>"
```

The design time package needs `SynEdit_R.dcp` on the `-U` path, so build the
runtime package first. Verified with dcc32 15.0 (Delphi 7) and 20.0
(Delphi 2009), both packages each.

## What was added on top of upstream

### Taken from a long-standing Delphi 7 installation
- **SynUni suite** (SynUniHighlighter plus designer, formats, rules, registration
  — 18 units including `SynUniHighlighter.inc`): a general purpose highlighter
  defined by XML.
- **Spell check suite** (SynSpellCheck, dialogs, metaphone, registration — 5 units).
- **SimpleXML** (plus `SimpleXML_D5Emulate`).
- Core changes these suites depend on:
  - `SynEditTypes.pas`: reintroduced `TSynIdentChars = set of AnsiChar`
  - `SynEditHighlighter.pas`: `FName`/`FAttributes` moved to `protected`;
    `GetLanguageNameProp`, `LoadFromFile` and `SaveToFile` made `virtual`
  - `SynEditMiscProcs.pas`: `ExpandPath`, `StrScanForCharInSet`,
    `StrRScanForCharInSet`

> **Provenance:** these suites come from earlier public SynEdit distributions and
> were taken over unchanged — the original authors' copyright notices are left
> untouched in the file headers (among them TSynSpellCheck 1.50 by Jacob Dybala).
> The only original work in this repository is `SynHighlighterAsmX86_64`.
>
> The dictionary used by the spell check suite (`Dictionary.7z`, 15.9 MB) is
> **not** part of this repository: it never changes, is not needed to compile,
> and would add 16 MB to every clone. It ships with the spell check distribution
> the units came from.

### Highlighters added or ported
- **SynHighlighterAsmX86_64** — an x64 assembler highlighter including AVX.
- **SynHighlighterYAML** — back-ported from the PyScripter fork to the classic API.
- **SynHighlighterZPL** — present upstream but in no Delphi 7 package; needs a
  local `WideUpCase`, because `UpCase` is AnsiChar only on Delphi 7.
- **SynHighlighterIni** — the VSoft fork's version with **TOML** support,
  back-ported (dedicated token kinds for hex, octal, float and triple quoted
  values, multi line string states; folding behind `{$IFDEF SYN_CodeFolding}`).
- **SynHighlighterDWS**, **SynHighlighterAsmMASM** — back-ported so they compile
  on D7/2009, where `Character` and `IOUtils` do not exist.
- **SynHighlighterPython** — added `match` and `case` (Python 3.10).

### Fixes
- `SynHighlighterXML`: the identifier check now compares against
  `WideChar(#$00C0)`. A literal holding a raw ANSI byte depends on the file
  encoding — a source file without a BOM is read as ANSI even by current
  compilers, and the resulting Char against String comparison compiles happily
  with the wrong result.
- `SynExportRTF`: background colour is written as `\chcbpat` as well — Word
  ignores `\cb` on its own.
- `SynExportTeX`: uses its own `TFormatSettings` instead of bending the global
  decimal separator, which was neither thread safe nor exception safe.
- `SynEditExport`: `ExportedText` is public now, so the exported text can be had
  without going through the clipboard.
- UTF-8 BOMs removed from the upstream sources — Delphi 7 aborts with
  "invalid character in input file" as soon as a source file carries one.

## Highlighter count: 70

All upstream highlighters, plus YAML, AsmX86_64 and SynUniHighlighter as a
general purpose definition driven highlighter. **Not** ported:
`SynHighlighterOmni` (tied to the modern `SynEditCodeFolding`; the counterpart
here is the SynUni suite). `TSynAsmMASMSyn` is registered only from Delphi 2010
on, via `{$IFDEF SYN_DELPHI_2010_UP}` (upstream's own rule).
