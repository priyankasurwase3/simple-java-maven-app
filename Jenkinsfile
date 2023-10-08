pipeline {
    agent  {
        node {
            label 'maven'
        }
    }
        environment {
            PATH = "/opt/apache-maven-3.9.5/bin:$PATH"
            scannerHome = tool 'sonar scanner'
        
    }
    stages {
        stage ('build'){
            steps {
              sh 'mvn clean install'
            }
        }
    


    stage('SonarQube analysis') {
    steps {
    withSonarQubeEnv('sonar server') { // If you have configured more than one global server connection, you can specify its name
      sh "${scannerHome}/bin/sonar-scanner"
      } 
     }
    }
  }
}
