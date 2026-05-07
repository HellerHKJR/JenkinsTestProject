#define ProjectName=ProjectName
#define ConfigPath=ConfigPath

[Setup]
; Name of program for Delete in control panel
AppName=JenkinsTestProject_{#ProjectName}
AppVersion={#VersionInfo}
AppVerName=Heller_{#ProjectName} 
AppPublisher=Heller Industries
DefaultDirName=C:\Heller Industries\{#ProjectName}
DefaultGroupName=Heller Industries

OutputDir=.\HS3Output
OutputBaseFilename=HS3_{#ProjectName}_Installer_v{#VersionInfo}

[Files]
Source: "JenkinsTestProject\bin\Release\*.*"; DestDir: "{app}"; Flags: ignoreversion
Source: "JenkinsTestProject\bin\Release\Config\*.*"; DestDir: "{app}\Config"; Flags: ignoreversion
Source: "JenkinsTestProject\bin\Release\Config\{#ConfigPath}\*.*"; DestDir: "{app}\Config\{#ConfigPath}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{commondesktop}\{#ProjectName}"; Filename: "{app}\JenkinsTestProject.exe"; IconFilename: "{app}\Remote.ico"
Name: "{group}\{#ProjectName}"; Filename: "{app}\JenkinsTestProject.exe"; IconFilename: "{app}\Remote.ico"
