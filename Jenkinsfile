pipeline {
    agent  {
        node {
            label 'maven'
        }
    }
    stages {
        stage ('buildt'){
            steps {
              sh 'mvn clean install'
            }
        }
    }
}
