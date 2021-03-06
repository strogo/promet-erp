; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Promet-ERP DB Installer Postgres Client"
#define MyAppVersion "7.0"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId=CUPROMETERP6
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
DefaultDirName={pf}\Promet-ERP
DefaultGroupName=Promet-ERP
DisableProgramGroupPage=yes
Compression=lzma
SolidCompression=yes
OutputBaseFilename=db_setup_postgres
OutputDir=../output

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"


[Files]
Source: postgres_client\*.dll; DestDir: {sys}; 

