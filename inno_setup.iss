[Setup]
AppName=JenkinsTestProject
AppVersion=1.0
DefaultDirName={autopf}\JenkinsTestProject
DefaultGroupName=JenkinsTestProject
; 설치 파일이 저장될 위치와 이름
OutputDir=.\Output
OutputBaseFilename=JenkinsTestProjectInstaller

[Files]
; 빌드된 결과물(.exe) 경로를 적어줍니다. 
; 빌드 결과가 bin\Release 폴더에 생긴다고 가정할 때:
Source: "JenkinsTestProject\bin\Release\*.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "JenkinsTestProject\bin\Release\*.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\JenkinsTestProject"; Filename: "{app}\JenkinsTestProject.exe"
