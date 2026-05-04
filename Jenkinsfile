pipeline {
    agent any

    environment {
        // 기존 서버에 설치된 Visual Studio 경로를 그대로 가져옵니다.
        DEVENV = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\Common7\\IDE\\devenv.com"
    }

    stages {
        stage('Checkout') {
            steps {
                // 이미 설정하신 SCM 방식을 그대로 사용 (git clone을 직접 쓸 필요 없음)
                checkout scm
            }
        }

        // 'Restore' 단계를 삭제하거나 아래 빌드 단계에 통합합니다.
        stage('Build') {
            steps {
                // 기존 프로젝트 방식 그대로 빌드 (이 명령어가 내부적으로 NuGet을 복구함)
                bat "\"${DEVENV}\" JenkinsTestProject.sln /Rebuild \"Release|Any CPU\""
            }
        }

        stage('Inno Setup') {
            steps {
                // 이 경로는 서버에 Inno Setup이 설치되어 있는지 꼭 확인하세요!
                bat '"C:\\Program Files (x86)\\Inno Setup 6\\ISCC.exe" "MyScript.iss"'
            }
        }
        
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'Output/*.exe', allowEmptyArchive: true
            }
        }
    }
}
