#define ProjectName=ProjectName
#define ConfigPath=ConfigPath

[Setup]
; Basic application information
AppId={{YOUR-GUID-HERE}
AppName=JenkinsTestProject_{#ProjectName}
AppVersion={#VersionInfo}
AppVerName=Heller_{#ProjectName}_v{#VersionInfo}
AppPublisher=Heller Industries
AppPublisherURL=https://www.hellerindustries.com
AppSupportURL=https://www.hellerindustries.com/support
AppUpdatesURL=https://www.hellerindustries.com/updates

; Installation directories
DefaultDirName={autopf}\Heller Industries\{#ProjectName}
DefaultGroupName=Heller Industries\{#ProjectName}
DisableProgramGroupPage=yes

; Output configuration
OutputDir=.\HS3Output
OutputBaseFilename=HS3_{#ProjectName}_Installer_v{#VersionInfo}

; Uninstall configuration
UninstallDisplayIcon={app}\Remote.ico
UninstallDisplayName=Heller {#ProjectName} v{#VersionInfo}

; Privileges and compatibility
PrivilegesRequired=admin
PrivilegesRequiredOverridesAllowed=dialog
Compression=lzma2
SolidCompression=yes

; Visual settings
WizardStyle=modern
SetupIconFile=JenkinsTestProject\Remote.ico

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";

[Files]
Source: "JenkinsTestProject\bin\Release\*.*"; DestDir: "{app}"; Flags: ignoreversion
Source: "JenkinsTestProject\bin\Release\Config\*.*"; DestDir: "{app}\Config"; Flags: ignoreversion
Source: "JenkinsTestProject\bin\Release\Config\{#ConfigPath}\*.*"; DestDir: "{app}\Config\{#ConfigPath}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{commondesktop}\Heller {#ProjectName}"; Filename: "{app}\JenkinsTestProject.exe"; IconFilename: "{app}\Remote.ico"; Tasks: desktopicon
Name: "{group}\Heller {#ProjectName}"; Filename: "{app}\JenkinsTestProject.exe"; IconFilename: "{app}\Remote.ico"
Name: "{group}\Uninstall Heller {#ProjectName}"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\JenkinsTestProject.exe"; Description: "{cm:LaunchProgram,Heller {#ProjectName}}"; Flags: nowait postinstall skipifsilent