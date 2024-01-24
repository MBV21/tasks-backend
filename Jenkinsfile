

pipeline {
    agent any
    stages {
        stage ('Build Backend') {
            steps {
                bat 'mvn clean package -DskipTests=true' // construir mas não executar testes
            }
        }
        stage ('Unit Tests') {
            steps {
                bat 'mvn test' // aproveitar a construção anterior e executar testes
            }
        }
        stage ('Sonar Analisys') { // análise do sonar necessita dos containers sonar e pg-sonar
            environment {
                scannerHome = tool 'Sonar_Scanner'
            }
            steps {
                withSonarQubeEnv('Sonar_Local') {
                    bat "${scannerHome}/bin/sonar-scanner -e -Dsonar.projectKey=DeployBack -Dsonar.host.url=http://localhost:9000 -Dsonar.login=381014cf0f50a668a09ecceded61465a9cfeaa6c -Dsonar.java.binaries=target -Dsonar.coverage.exclusions=**/.mvn/**,**/src/test/**,**/model/**,**Application.java"
                }
            }
        }
        stage ('Quality Gate') {
            steps {
                sleep(30) // necessário dar algum tempo para que o quality gate seja mensurado
                timeout(time: 1, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}
