#define CustomerName={#CompanyName}

[Setup]
AppName=JenkinsTestProject
AppVersion={#VersionInfo}
AppPublisher=Heller Industries
DefaultDirName={autopf}\JenkinsTestProject
DefaultGroupName=JenkinsTestProject
; 설치 파일이 저장될 위치와 이름
OutputDir=.\Output
OutputBaseFilename=JenkinsTestProjectInstaller_v{#VersionInfo}

[Files]
; 빌드된 결과물(.exe) 경로를 적어줍니다. 
; 빌드 결과가 bin\Release 폴더에 생긴다고 가정할 때:
Source: "JenkinsTestProject\bin\Release\*.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "JenkinsTestProject\bin\Release\*.dll"; DestDir: "{app}"; Flags: ignoreversion skipifsourcedoesntexist
Source: "JenkinsTestProject\bin\Release\Config\{#CustomerName}\*.*"; DestDir: "{app}\Config\{#CustomerName}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "JenkinsTestProject\bin\Release\Config\*.*"; DestDir: "{app}\Config"; Flags: ignoreversion

[Icons]
Name: "{group}\JenkinsTestProject"; Filename: "{app}\JenkinsTestProject.exe"
