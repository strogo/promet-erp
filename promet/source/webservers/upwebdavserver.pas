unit upwebdavserver;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, dom, xmlread, xmlwrite, uappserverhttp,udavserver,uAppServer,
  uprometdavserver;

type

  { TPrometWebDAVMaster }

  TPrometWebDAVMaster = class(TWebDAVMaster)
    procedure ServerAccess(aSocket: TDAVSession; Info: string);
  private
    ServerFunctions : TPrometServerFunctions;
  public
    constructor Create;override;
  end;

implementation

var
  DavServer : TPrometWebDAVMaster = nil;

function HandleDAVRequest(Sender : TAppNetworkThrd;Method, URL: string;Headers : TStringList;Input,Output : TMemoryStream): Integer;
var
  i: Integer;
  aSock: TDAVSession = nil;
  aParameters: TStringList;
  s: String;
  tmp: String;
begin
  Result := 500;
  try
    if not Assigned(DavServer) then
      begin
        DavServer := TPrometWebDAVMaster.Create;
      end;
    for i := 0 to Sender.Objects.Count-1 do
      if TObject(Sender.Objects[i]) is TDAVSession then
        aSock := TDAVSession(Sender.Objects[i]);
    if not Assigned(aSock) then
      begin
        aParameters := TStringList.Create;
        aParameters.NameValueSeparator:=':';
        aParameters.CaseSensitive:=False;
        aSock := TDAVSession.Create(DavServer,aParameters);
        aSock.Socket := Sender;
        Sender.Objects.Add(aSock);
      end;
    aParameters.Clear;
    for i := 0 to Headers.Count-1 do
      begin
        s := Headers[i];
        tmp := copy(s,0,pos(':',s)-1);
        aParameters.Add(lowercase(tmp)+':'+trim(copy(s,pos(':',s)+1,length(s))));
      end;
    Result := aSock.ProcessHttpRequest(Method,URL,Headers,Input,Output);
  except
    Result:=500;
  end;
end;

{ TPrometWebDAVMaster }

procedure TPrometWebDAVMaster.ServerAccess(aSocket: TDAVSession; Info: string);
begin
  writeln('DAV:'+Info);
end;

constructor TPrometWebDAVMaster.Create;
begin
  inherited Create;
  ServerFunctions := TPrometServerFunctions.Create;
  OnAccess:=@ServerAccess;
  OnGetDirectoryList:=@ServerFunctions.ServerGetDirectoryList;
  OnMkCol:=@ServerFunctions.ServerMkCol;
  OnDelete:=@ServerFunctions.ServerDelete;
  OnPutFile:=@ServerFunctions.ServerPutFile;
  OnGetFile:=@ServerFunctions.ServerGetFile;
  OnReadAllowed:=@ServerFunctions.ServerReadAllowed;
  OnWriteAllowed:=@ServerFunctions.ServerReadAllowed;
  OnUserLogin:=@ServerFunctions.ServerUserLogin;
end;

initialization
  uappserverhttp.RegisterHTTPHandler(@HandleDAVRequest);

end.

