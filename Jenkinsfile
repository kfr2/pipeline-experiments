stages {
  node {
    stage("checkout repo") {
      checkout scm
    }

    stage("decrypt secrets") {
      withCredentials([file(credentialsId: 'GITCRYPT_KEY', variable: 'GITCRYPT_KEY')]) {
        sh "git-crypt unlock $GITCRYPT_KEY"
      }
    }

    stage("build image") {
      kubernetes.image().withName("pipeline-test").build().fromPath(".")
    }

    stage("run the tests somehow") {

    }
  }
}
