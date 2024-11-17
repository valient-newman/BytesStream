unit BytesStream;
// TBytesStream class was added in Delphi 2009, so I define it manually for Delphi 2007
// CompilerVersion is 18.5 for Delphi 2007 Win32

interface

{$IF CompilerVersion = 18.5}
uses
   Classes, SysUtils, RTLConsts;
{$IFEND}

// This code was taken from unit System.Classes of Delphi 10.4.2 and remade
{$IF CompilerVersion = 18.5}
type
  TBytesStream = class(TMemoryStream)
  private
    FBytes: TBytes;
    FCapacity: Longint;
    FSize: Longint;
  protected
    function Realloc(var NewCapacity: Longint): Pointer; override;
  public
    constructor Create(const ABytes: TBytes); overload;
    property Bytes: TBytes read FBytes;
  end;
{$IFEND}

implementation
{$IF CompilerVersion = 18.5}
const
  MemoryDelta = $2000; // Must be a power of 2
{$IFEND}

// This code was taken from unit System.Classes of Delphi 10.4.2
{$IF CompilerVersion = 18.5}
constructor TBytesStream.Create(const ABytes: TBytes);
begin
  inherited Create;
  FBytes := ABytes;
  SetPointer(Pointer(FBytes), Length(FBytes));
  FCapacity := FSize;
end;

function TBytesStream.Realloc(var NewCapacity: Integer): Pointer;
begin
  if (NewCapacity > 0) and (NewCapacity <> FSize) then
    NewCapacity := (NewCapacity + (MemoryDelta - 1)) and not (MemoryDelta - 1);
  Result := Pointer(FBytes);
  if NewCapacity <> FCapacity then
  begin
    SetLength(FBytes, NewCapacity);
    Result := Pointer(FBytes);
    if NewCapacity = 0 then
      Exit;
    if Result = nil then raise EStreamError.CreateRes(@SMemoryStreamError);
  end;
end;
{$IFEND}

end.
