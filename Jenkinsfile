

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
    }
}


