pipeline {
    agent {  label "master"    }
    
    stages {
        // Step 1
        stage('SCM') {
                steps {
                      sh 'rm -rf project-devops'

                // Clone the repository into a new directory
                      sh 'git clone https://github.com/elheme/Project-Devops.git'
                    
            }      
        }
        // Step 2
        stage('Build by Maven') {
                steps {
                    dir('project-devops') {
                        sh 'mvn clean package'
                    }
                }
        }
        
        // Step 3
        stage('Build docker image') {
                script {
                    dir('project-devops') {
                        docker.build("projectjava:latest")
                    }
                }
        }
        
        // Step 4
        stage('Push docker image') {
                steps {
                   
                    sh "sudo docker tag projectjava:latest elheme/project-devops/projectjava:latest "
                   
                    sh "sudo docker push elheme/project-devops/projectjava:latest"
                }
        }
        
        // Step 5 
        stage('Deploy Java App in  Dev Env') {
                steps {
                        sh "sudo docker rm -f projectjava"
                        sh "sudo docker run  -d -p 8080:8080 --name projectjava elheme/project-devops/projectjava:latest"
                }
        }
        
            
        stage('QAT Test') {
            steps {
        	// bcz tomcat take some sec. to display data , so apply some delay here        
                retry(30) {
                    sh 'curl --silent http://localhost:8080/projectjava/ '
                }   
            }
        }
        
    }
}      
