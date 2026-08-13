# SynEdit-Classic — Delphi 7 to 11 (based on SynEdit/SynEdit, Jan 2022)

Based on the final state of the official repository
[SynEdit/SynEdit](https://github.com/SynEdit/SynEdit) (last commit 2022-01-29) —
the last SynEdit line that supports Delphi 7 (officially D7 through 11 Alexandria).
The modern line lives on in the
[VSoft fork](https://github.com/VSoftTechnologies/SynEdit) (10.4+, DirectWrite,
multi-caret); the two are no longer mergeable.

## Directory layout

```
Source\               core units
Source\Highlighters\  all highlighters
Packages\<IDE>\       packages, one folder per Delphi version (as upstream)
```

Highlighters include their configuration as `{$I ..\SynEdit.inc}`. **Note that
this is not sufficient on its own:** `SynEdit.inc` pulls in `SynEditJedi.inc`,
and a nested `{$I}` is resolved through the search path, *not* relative to the
including file. `Source` therefore has to be on the include search path. The
`.dof`/`.cfg` (Delphi 7) and the `.dproj` (Delphi 2009) in the package folders
already carry it.

## Packages

Everything is built from `Packages\<IDE>\`, exactly as upstream did it - a
plain Delphi installation is all that is needed.

| Folder | Packages |
|---|---|
| `Packages\D7` | `SynEdit_R7.dpk` / `SynEdit_D7.dpk` (plus the upstream CLX, PE and TNT variants) |
| `Packages\D2009` | `SynEdit_R2009.dpk` / `SynEdit_D2009.dpk` |
| `Packages\110A` | upstream's Delphi 11 packages, path adjusted; the runtime package is built and verified |
| `Packages\2010` … `Packages\104S`, `Packages\XE*` | upstream's packages, paths adjusted for the new highlighter folder, otherwise untouched and untested here |

Every package that uses `{$R *.res}` now has its resource file next to it. Upstream
left most of them out because the IDE generates them, which is fine in the IDE but
makes a command line build fail with E1026.

The D7 and D2009 packages carry the full unit set of this fork, including the
SynUni, spell check and SimpleXML suites and the added highlighters. Those three
suites are ANSI only and sit behind `{$IFNDEF UNICODE}`, so Delphi 2009 leaves
them out. Also excluded: `SynHighlighterAsmMASM` before Delphi 2010 (needs
`IOUtils`) and code folding before XE (`SynEditCodeFolding.pas` needs
`Generics.Defaults`).

`SynSpellCheck` is not Unicode clean by design - it indexes its tables with
`Ord(character)` over `array[0..255]`.

### Building

Open `Packages\D7\SynEdit_R7.dpk` (or the D2009 counterpart) in the IDE and
build, runtime package first, then the design time one. From the command line,
run dcc32 inside the package folder - the `.cfg` next to the package supplies
the search paths:

```
dcc32 SynEdit_R7.dpk -B -Q -U"<Lib>;<Out>" -N"<Out>" -LE"<Out>" -LN"<Out>"
dcc32 SynEdit_D7.dpk -B -Q -U"<Lib>;<Out>" -N"<Out>" -LE"<Out>" -LN"<Out>"
```

`<Lib>` is the Delphi library directory, `<Out>` the output directory; the
design time package needs `SynEdit_R7.dcp` there, so build the runtime package
first. Verified with dcc32 15.0 (Delphi 7) and 20.0 (Delphi 2009), both packages
each.

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
> The only original work in this repository is `SynHighlighterAsmX86_64`, and it
> is released under the same terms as the rest of the project: MPL 1.1 with the
> GPL 2 or later alternative, exactly like every other SynEdit unit.
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
