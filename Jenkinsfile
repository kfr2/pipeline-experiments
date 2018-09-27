pipeline {
  agent any
  stages {
    stage("Decrypt secrets") {
      steps {
        withCredentials([file(credentialsId: 'GITCRYPT_KEY', variable: 'GITCRYPT_KEY')]) {
          sh "git-crypt unlock $GITCRYPT_KEY"
        }
      }
    }

    stage("Test") {
      steps {
        sh "./test.sh"
      }
    }
  }
}
