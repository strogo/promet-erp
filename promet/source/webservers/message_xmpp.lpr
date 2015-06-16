 program message_xmpp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp
  { you can add units after this },db,Utils,
  FileUtil,uData, uIntfStrConsts, pcmdprometapp,uBaseCustomApplication,
  uBaseApplication;

type

  { PrometXMPPMessanger }

  PrometXMPPMessanger = class(TBaseCustomApplication)
  private
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ PrometXMPPMessanger }

procedure PrometXMPPMessanger.DoRun;
begin
  with BaseApplication as IBaseApplication do
    begin
      AppVersion:={$I ../base/version.inc};
      AppRevision:={$I ../base/revision.inc};
    end;
  if not Login then Terminate;
  //Your logged in here on promet DB


  // stop program loop
  Terminate;
end;

constructor PrometXMPPMessanger.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor PrometXMPPMessanger.Destroy;
begin
  inherited Destroy;
end;

var
  Application: PrometXMPPMessanger;

begin
  Application:=PrometXMPPMessanger.Create(nil);
  Application.Run;
  Application.Free;
end.
