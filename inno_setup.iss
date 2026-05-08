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
DefaultDirName=C:\Heller Industries\{#ProjectName}
DefaultGroupName=Heller Industries\{#ProjectName}
DisableProgramGroupPage=yes

; Output configuration
OutputDir=.\HS3Output
OutputBaseFilename=HS3_{#ProjectName}_Installer_v{#VersionInfo}

; Uninstall configuration
UninstallDisplayIcon={app}\Remote.ico
UninstallDisplayName=Heller {#ProjectName}

; Privileges and compatibility
PrivilegesRequired=admin
Compression=lzma2
SolidCompression=yes

; Visual settings
WizardStyle=modern
DisableReadyPage=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "bin\Release\*.*"; DestDir: "{app}"; Flags: ignoreversion
Source: "bin\Release\Config\*.*"; DestDir: "{app}\Config"; Flags: ignoreversion
Source: "bin\Release\Config\{#ConfigPath}\*.*"; DestDir: "{app}\Config\{#ConfigPath}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{commondesktop}\Heller {#ProjectName}"; Filename: "{app}\JenkinsTestProject.exe"; IconFilename: "{app}\Remote.ico"
Name: "{group}\Heller {#ProjectName}"; Filename: "{app}\JenkinsTestProject.exe"; IconFilename: "{app}\Remote.ico"
Name: "{group}\Uninstall Heller {#ProjectName}"; Filename: "{uninstallexe}"
