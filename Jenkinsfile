def remote = [:]
remote.name = 'web server'
remote.host = '45.32.246.10'
remote.user = 'root'
remote.password = '5Ns]RP6Ah?xK5Nd='
remote.allowAnyHosts = true
pipeline {
  agent any
  
  environment {
    DISABLE_AUTH = 'true'
    DB_ENGINE    = 'sqlite'
  }
  
  stages {
    stage('Static Check') {
      steps {
        sh 'echo Static Check'
      }
    } 
    stage('Unit Testing') {
      steps {
        sh 'echo Unit Testing'
      }
    }
    stage('Cypress Integration Testing') {
      steps {
        sh 'echo Start Cypress Integration Testing'
        sh '''
        bash /var/jenkins_home/workspace/pipeline/getCypressCode.sh
        bash /var/jenkins_home/workspace/pipeline/executeCypressTest.sh
        '''
     }
    }
    stage('Build Result Image') {
      steps {
        sh 'printenv'
        sh 'docker build -t docker4170/result ./result'
        echo 'Build result completed'
      }
    } 
    stage('Build Vote Image') {
      steps {
        sh 'docker build -t docker4170/vote ./vote'
      }
    }
    stage('Build Worker Image') {
      steps {
        sh 'docker build -t docker4170/worker ./worker'
      }
    }
    stage('E2E Testing') {
      steps {
        parallel(
          Chrome: {
            echo "Running E2E Testing on Chrome"
          },
          Firefox: {
            echo "Running E2E Testing on Firefox"
          },
          Safari: {
            echo "Running E2E Testing on Safari"
          }
        )
      }    
    } 
    stage('Push Result Image') {
      when {
        expression {
          return env.GIT_BRANCH == "origin/master"
        }
      }
      steps {
        withDockerRegistry(credentialsId: 'cad4f32a-2bfe-4db7-b8d9-5b8362f2546e', url:'') {
          sh 'docker push docker4170/result'
        }
      }
    }
    stage('Push Vote Image') {
      when {
        expression {
          return env.GIT_BRANCH == "origin/master"
        }
      }
      steps {
        withDockerRegistry(credentialsId: 'cad4f32a-2bfe-4db7-b8d9-5b8362f2546e', url:'') {
          sh 'docker push docker4170/vote'
        }
      }
    }
    stage('Push Worker Image') {
      when {
        expression {
          return env.GIT_BRANCH == "origin/master"
        }
      }
      steps {
        withDockerRegistry(credentialsId: 'cad4f32a-2bfe-4db7-b8d9-5b8362f2546e', url:'') {
          sh 'docker push docker4170/worker'
        }
      }
    }
    stage('Deployment') {
      steps {
        sshCommand remote: remote, command: 
        "cd /home/don/projects/example-voting-app && " +
        "git pull && " +
        "docker-compose pull && " +
        "docker-compose down && " +
        "docker-compose up -d && " + 
        "docker-compose ps" 
      }
    }
  }
 }