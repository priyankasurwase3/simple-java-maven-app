pipeline {
    agent  {
        node {
            label 'maven'
        }
    }
        environment {
            PATH = "/opt/apache-maven-3.9.5/bin:$PATH"
        
    }
    stages {
        stage ('buildt'){
            steps {
              sh 'mvn clean install'
            }
        }
    }
}
