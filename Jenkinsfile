pipeline {
    agent  {
        node {
            label 'maven'
        }
    }
    stages {
        stage ('git checkout'){
            steps {
              git branch: 'main', url: 'https://github.com/priyankasurwase3/simple-java-maven-app.git' }
        }
    }
