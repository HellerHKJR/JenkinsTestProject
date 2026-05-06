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
                    def version = getVersionFromXML("JenkinsTestProject/Config/${params.StartupArg}")
                    VERSION = version                    
                    echo "Version: ${VERSION}, StartupArg: ${params.StartupArg}"
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
                    def startupArgValue = params.StartupArg
                    def configPath = "${WORKSPACE}\\JenkinsTestProject\\bin\\Release\\JenkinsTestProject.exe.config"

                    echo "Target File: ${configPath}"
                    echo "New Value: ${startupArgValue}"

                    powershell """
                        if (Test-Path '${configPath}') {
                            [xml]\$xml = Get-Content '${configPath}'
                    
                            # XML 구조를 정확히 타겟팅 (따옴표 주의)
                            \$node = \$xml.configuration.applicationSettings.'JenkinsTestProject.Properties.Settings'.setting | Where-Object { \$_.name -eq 'StartupArg' }

                            if (\$node) {
                                Write-Host "Current Value in XML: " \$node.value
                        
                                # 값 변경
                                \$node.value = "${startupArgValue}"
                        
                                # 저장 전 확인
                                Write-Host "Changing to: " \$node.value
                        
                                \$xml.Save('${configPath}')
                                Write-Host "Save Completed!"
                            } else {
                                Write-Error "CRITICAL: Could not find 'StartupArg' node in the XML structure!"
                            }
                        } else {
                            Write-Error "CRITICAL: Config file NOT FOUND at ${configPath}"
                        }
                    """
                }
            }
        }


        stage('Inno Setup') {
            steps {
                script {
                    // inno setup
                    def extractedConfigPath = params.StartupArg.split('/')[0]
                    bat """ "C:\\Program Files (x86)\\Inno Setup 6\\ISCC.exe" /dVersionInfo=${VERSION} /dProjectName=${params.ProjectName} /dConfigPath=${extractedConfigPath} inno_setup.iss """
                }
            }
        }
        
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'Output/*.exe', allowEmptyArchive: true
            }
        }
    }
}
