def getVersionFromXML(fileName) {
    def xmlText = readFile(file: fileName, encoding: "UTF-8")
    xmlText = xmlText.substring(xmlText.indexOf("<"))
    def xml = new XmlSlurper().parseText(xmlText)
    return xml.version.text()
}

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

        stage('Get Version') {
            steps {                
                script {                             
                    def version = getVersionFromXML("JenkinsTestProject/Config/${StartupArg}")
                    VERSION = version                    
                    echo "Version: ${VERSION}, StartupArg: ${StartupArg}"
                }
            }
        }

        // 'Restore' 단계를 삭제하거나 아래 빌드 단계에 통합합니다.
        stage('Build') {
            steps {
                // 기존 프로젝트 방식 그대로 빌드 (이 명령어가 내부적으로 NuGet을 복구함)
                bat "\"${DEVENV}\" JenkinsTestProject.sln /Rebuild \"Release|Any CPU\""
            }
        }

        stage('Modify Config') {
            steps {
                script {
                    // 이미 Jenkinsfile 상단에 정의된 회사 이름 변수 사용
                    def startupArg = params.StartupArg
                    
                    // 빌드 결과물이 나온 경로 (이미지 상의 폴더 위치)
                    def configPath = "${WORKSPACE}\\bin\\Release\\JenkinsTestProject.exe.config"

                    powershell """
                        [xml]\$xml = Get-Content '${configPath}'
                
                        # StartupArg 세팅 노드 찾기
                        \$node = \$xml.configuration.applicationSettings.JenkinsTestProject.Properties.Settings.setting | Where-Object { \$_.name -eq 'StartupArg' }
                
                        if (\$node) {
                            # 값을 ABC\\ABC.Config.xml 형태로 변경
                            \$node.value = startupArg
                            \$xml.Save('${configPath}')
                            Write-Host "Successfully updated StartupArg to ${startupArg}"
                        } else {
                            Write-Error "Could not find StartupArg node."
                        }
                    """
                }
            }
        }

        stage('Inno Setup') {
            steps {
                // 이 경로는 서버에 Inno Setup이 설치되어 있는지 꼭 확인하세요!
                def ConfigPath = StartupArg.split('/')[0]
                bat """ "C:\\Program Files (x86)\\Inno Setup 6\\ISCC.exe" /dVersionInfo=${VERSION} /dProjectName=${ProjectName} /dConfigPath=${ConfigPath} inno_setup.iss """
            }
        }
        
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'Output/*.exe', allowEmptyArchive: true
            }
        }
    }
}
