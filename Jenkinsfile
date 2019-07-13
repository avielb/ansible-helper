pipeline {
  agent {
    docker {
      image 'centos'
    }

  }
  stages {
    stage('checkout') {
      agent {
        docker {
          image 'centos'
        }

      }
      steps {
        sh 'ls'
      }
    }
  }
}