def getVersionFromXML(fileName) {
    def xmlText = readFile(file: fileName, encoding: "UTF-8")
    xmlText = xmlText.trim()
    
    // Remove BOM if present
    if (xmlText.startsWith('\uFEFF')) {
        xmlText = xmlText.substring(1)
    }
    
    // Ensure we start from the first '<'
    if (xmlText.indexOf("<") > 0) {
        xmlText = xmlText.substring(xmlText.indexOf("<"))
    }
    
    def xml = new XmlSlurper().parseText(xmlText)
    
    echo "DEBUG: Root element name: ${xml.name()}"
    echo "DEBUG: Destination count: ${xml.Destination.size()}"
    
    // Access the 'ver' attribute directly
    def verAttr = xml.Destination.'@ver'.text()
    echo "DEBUG: Version found: ${verAttr}"
    
    return verAttr
}

pipeline {
    agent any

    environment {
        // location of devenv.com, adjust if your Visual Studio version or edition is different
        DEVENV = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\Common7\\IDE\\devenv.com"
    }

    stages {            
        stage('Printout Workspace') {
            steps {
                echo "=========================================="
                echo "Workspace Path: ${WORKSPACE}"
                echo "=========================================="
                
                // Show directory structure excluding bin and obj folders
                powershell '''
                    Write-Host "=== Workspace Directory Tree (excluding bin/obj) ==="
                    
                    function Show-Tree {
                        param([string]$Path = ".", [string]$Indent = "", [bool]$IsLast = $true)
                        
                        $items = Get-ChildItem $Path | Where-Object { 
                            $_.Name -notmatch '^(bin|obj)$' -and 
                            $_.Name -notmatch '^\\.git$' -and
                            $_.Name -notmatch '^\\.vs$'
                        }
                        
                        for ($i = 0; $i -lt $items.Count; $i++) {
                            $item = $items[$i]
                            $isLastItem = ($i -eq $items.Count - 1)
                            $branch = "|-- "
                            $newIndent = if ($isLastItem) { "$Indent    " } else { "$Indent|   " }
                            
                            Write-Host "$Indent$branch$($item.Name)"
                            
                            if ($item.PSIsContainer) {
                                Show-Tree -Path $item.FullName -Indent $newIndent -IsLast $isLastItem
                            }
                        }
                    }
                    
                    Write-Host (Get-Location).Path
                    Show-Tree
                '''     
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

        stage('Build') {
            steps {                
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
                            
                            \$node = \$xml.configuration.applicationSettings.'JenkinsTestProject.Properties.Settings'.setting | Where-Object { \$_.name -eq 'StartupArg' }

                            if (\$node) {
                                Write-Host "Current Value in XML: " \$node.value
                        
                                # Chanage the value
                                \$node.value = "${startupArgValue}"
                        
                                # Confirm the change
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
                archiveArtifacts artifacts: 'HS3Output/*.exe', allowEmptyArchive: true
            }
        }
    }
}
