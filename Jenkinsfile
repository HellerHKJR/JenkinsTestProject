pipeline {
    agent any
    tools {
        msbuild 'msbuild' // 젠킨스 설정에 등록한 이름과 같아야 함
    }
    stages {
        stage('Restore') {
            steps { bat 'nuget restore JenkinsTestProject.sln' }
        }
        stage('Build') {
            steps { bat 'msbuild JenkinsTestProject.sln /p:Configuration=Release' }
        }
        stage('Inno Setup') {
            steps { bat '"C:\\Program Files (x86)\\Inno Setup 6\\ISCC.exe" "MyScript.iss"' }
        }
    }
}
