

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
        stage ('Deploy Backend') {
            steps {
                deploy adapters: [tomcat8(credentialsId: 'Tomcat_Admin', path: '', url: 'http://localhost:8001/')], contextPath: 'tasks-backend', onFailure: false, war: 'target/tasks-backend.war'
            }
        }
        stage ('API Test') {
            steps {
                dir ('api-test') {
                    credentialsId: 'GitHub_MBV21', url: 'https://github.com/MBV21/tasks-api-test.git'
                    bat 'mvn test'
                }
            }
        }
    }
}
