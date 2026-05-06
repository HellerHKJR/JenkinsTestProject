#define ProjectName=ProjectName
#define ConfigPath=ConfigPath

[Setup]
; Name of program for Delete in control panel
AppName=JenkinsTestProject_{#ProjectName}
AppVersion={#VersionInfo}
AppVerName={#ProjectName}_Installer_v{#VersionInfo} 
AppPublisher=Heller Industries
DefaultDirName=C:\Heller Industries\{#ProjectName}
DefaultGroupName=Heller Industries
; 설치 파일이 저장될 위치와 이름
OutputDir=.\Output
OutputBaseFilename={#ProjectName}_Installer_v{#VersionInfo}

[Files]
; 빌드된 결과물(.exe) 경로를 적어줍니다. 
; 빌드 결과가 bin\Release 폴더에 생긴다고 가정할 때:
Source: "JenkinsTestProject\bin\Release\*.*"; DestDir: "{app}"; Flags: ignoreversion
Source: "JenkinsTestProject\bin\Release\Config\*.*"; DestDir: "{app}\Config"; Flags: ignoreversion
Source: "JenkinsTestProject\bin\Release\Config\{#ConfigPath}\*.*"; DestDir: "{app}\Config\{#ConfigPath}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; 바탕화면 바로가기 아이콘 설정
Name: "{commondesktop}\{#ProjectName}"; Filename: "{app}\JenkinsTestProject.exe"; IconFilename: "{app}\Remote.ico"

; 시작 메뉴 바로가기 아이콘 설정
Name: "{group}\{#ProjectName}"; Filename: "{app}\JenkinsTestProject.exe"; IconFilename: "{app}\Remote.ico"
