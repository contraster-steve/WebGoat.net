pipeline {
  agent any
  environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
	    }
  tools {
        jdk "JDK 16"
    }
    stages {
      stage('1: Download') {
        steps{
            script{
                echo "Clean first"
                sh 'rm -rf *'
                echo "Download the RailsGoat from source."
                sh 'git clone https://github.com/contraster-steve/WebGoat.net'
                }
            }
        }
      stage('2: Add Contrast') {
        steps{
            withCredentials([string(credentialsId: 'AUTH_HEADER', variable: 'AUTH_HEADER'), string(credentialsId: 'API_KEY', variable: 'api_key'), string(credentialsId: 'SERVICE_KEY', variable: 'service_key'), string(credentialsId: 'USER_NAME', variable: 'user_name')]) {
                script{
                    dir('./WebGoat.net/') {
                        echo "Create YAML."
                        sh 'echo "api:\n  url: https://apptwo.contrastsecurity.com/Contrast\n  api_key: ${api_key}\n  service_key: ${service_key}\n  user_name: ${user_name}\napplication:\n  session_metadata: buildNumber=${BUILD_NUMBER}, committer="Steve Smith"" >> ./contrast_security.yaml' 
                        sh 'chmod 755 ./contrast_security.yaml'
                    }
                }
            }
        }
      }            
      stage('3: Build Images') {
        steps{
            script{
                echo "Build $JOB_NAME."
                dir('./WebGoat.net/') {
                    sh 'docker-compose build'
                    }
                }
            }
      }        
      stage('4: Deploy') {
        steps{
            script{
            echo "Run Dev here."
            dir('./WebGoat.net/') {
                sh 'docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d'
                	}
                }
            }
        }
    }
}    
