

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
    }
}


