

pipeline {
    agent any
    stages {
        stage ('Build Backend') {
            steps {
                bat 'mvn clean package -DskipTests=true' // construir mas n�o executar testes
            }
        }
        stage ('Unit Tests') {
            steps {
                bat 'mvn test' // aproveitar a constru��o anterior e executar testes
            }
        }
        stage ('Sonar Analisys') {
            environment {
                scannerHome = tool 'Sonar_Scanner'
            }
            steps {
                withSonarQubeEnv('Sonar_Local') {
                    bat "${scannerHome}/bin/sonar-scanner -e -Dsonar.projectKey=DeployBack -Dsonar.host.url=http://localhost:9000 -Dsonar.login=381014cf0f50a668a09ecceded61465a9cfeaa6c -Dsonar.java.binaries=target -Dsonar.coverage.exclusions=**/.mvn/**,**/src/test/**,**/model/**,**Application.java"
                }
            }
        }
    }
}


