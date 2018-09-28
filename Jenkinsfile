  node {
    checkout scm

    withCredentials([file(credentialsId: 'GITCRYPT_KEY', variable: 'GITCRYPT_KEY')]) {
      sh "git-crypt unlock $GITCRYPT_KEY"
    }

    kubernetes.image().withName("pipeline-test").build().fromPath(".")

  }
