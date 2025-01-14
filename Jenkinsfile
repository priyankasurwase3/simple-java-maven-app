def registry = 'https://priya123e2e.jfrog.io'
def imageName = 'priya123e2e.jfrog.io/mycicde2e-docker-local/mycicde2e'
def version   = '1.0-SNAPSHOT'
pipeline {
    agent  {
        node {
            label 'maven'
        }
    }
        environment {
            PATH = "/opt/apache-maven-3.9.5/bin:$PATH"
            scannerHome = tool 'sonar-scanner'
        
    }
    stages {
        stage ('build'){
            steps {
              sh 'mvn clean install -Dmaven.test.skip=true'
            }
        }
     stage("test"){
            steps{
                echo "----------- unit test started ----------"
                sh 'mvn surefire-report:report'
                 echo "----------- unit test Complted ----------"
            }
        }

 stage('SonarQube analysis') {
    steps {
    withSonarQubeEnv('sonar-server') { // If you have configured more than one global server connection, you can specify its name
      sh "${scannerHome}/bin/sonar-scanner"
      } 
     }
 }
    stage("Quality Gate"){
     steps {
      script {
    timeout(time: 1, unit: 'HOURS')
    { // Just in case something goes wrong, pipeline will be killed after a timeout
     def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
     if (qg.status != 'OK')
        {
      error "Pipeline aborted due to quality gate failure: ${qg.status}"
    }
    }
  }
    }
    
}

            
         stage("Jar Publish") {
        steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrog"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "target/(*)",
                              "target": "libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
            }
        }   
    }   


    stage(" Docker Build ") {
      steps {
        script {
           echo '<--------------- Docker Build Started --------------->'
           app = docker.build(imageName+":"+version)
           echo '<--------------- Docker Build Ends --------------->'
        }
      }
    }

            stage (" Docker Publish "){
        steps {
            script {
               echo '<--------------- Docker Publish Started --------------->'  
                docker.withRegistry(registry, 'jfrog'){
                    app.push()
                }    
               echo '<--------------- Docker Publish Ended --------------->'  
            }
        }
    }
    
  }
}
