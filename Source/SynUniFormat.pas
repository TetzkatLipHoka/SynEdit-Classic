{
@abstract(Provides highlighters import and export)
@authors(Vitalik [2vitalik@gmail.com])
@created(2005)
@lastmod(2006-06-30)
}

{$IFNDEF QSynUniFormat}
unit SynUniFormat;
{$ENDIF}

interface

uses
{$IFDEF SYN_CLX}
  QClasses,
  QSynUniHighlighter,
{$ELSE}
  Classes,
  SysUtils,
  SynUniHighlighter;
{$ENDIF}

type
  TSynUniFormat = class
  protected
    class function VerifyStream(AStream: TStream): boolean;
    class function VerifyFileName(AFileName: string): boolean;
    class function VerifyEmptyFileName(AFileName: string): boolean;
  public
    class function ImportFromStream(AObject: TObject; AStream: TStream): boolean; virtual;
    class function ImportFromFile(AObject: TObject; AFileName: string): boolean; virtual;
    class function ExportToStream(AObject: TObject; AStream: TStream): boolean; virtual;
    class function ExportToFile(AObject: TObject; AFileName: string): boolean; virtual;
  end;

implementation

class function TSynUniFormat.VerifyStream(AStream: TStream): boolean;
begin
  Result := Assigned(AStream);
end;

class function TSynUniFormat.VerifyFileName(AFileName: string): boolean;
begin
  Result := FileExists(AFileName);
end;

class function TSynUniFormat.VerifyEmptyFileName(AFileName: string): boolean;
begin
  Result := AFileName <> '';
end;

class function TSynUniFormat.ImportFromStream(AObject: TObject; AStream: TStream): boolean;
begin
end;

class function TSynUniFormat.ImportFromFile(AObject: TObject; AFileName: string): boolean;
begin
end;

class function TSynUniFormat.ExportToStream(AObject: TObject; AStream: TStream): boolean;
begin
end;

class function TSynUniFormat.ExportToFile(AObject: TObject; AFileName: string): boolean; 
begin
end;

end.

