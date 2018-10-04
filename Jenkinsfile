def label = "worker-${UUID.randomUUID().toString()}"

podTemplate(label: label, containers: [
  containerTemplate(
    name: 'jnlp',
    image: 'quay.io/lightside/jenkins-jnlp-agent:0.1.0',
    ttyEnabled: true
  ),
  containerTemplate(
    name: 'docker',
    image: 'quay.io/lightside/jet:0.1.0',
    ttyEnabled: true,
    privileged: true,
    envVars: [
        envVar(key: 'CI_BRANCH', value: 'hardcoded'),
    ]
  )
]) {
  node(label) {
    def myRepo = checkout scm
    def gitCommit = myRepo.GIT_COMMIT
    def gitBranch = myRepo.GIT_BRANCH
    def shortGitCommit = "${gitCommit[0..10]}"
    def previousGitCommit = sh(script: "git rev-parse ${gitCommit}~", returnStdout: true)

    stage('Decrypt secrets') {
      withCredentials([file(credentialsId: 'GITCRYPT_KEY', variable: 'GITCRYPT_KEY')]) {
          sh "git-crypt unlock $GITCRYPT_KEY"
      }
    }

    stage('Describe environment') {
      container('docker') {
        sh "env"
      }
    }

    stage('Test') {
      container('docker') {
        sh "/srv/test.sh"
      }
    }
    // stage('Create Docker images') {
    //   container('docker') {
    //     withCredentials([[$class: 'UsernamePasswordMultiBinding',
    //       credentialsId: 'dockerhub',
    //       usernameVariable: 'DOCKER_HUB_USER',
    //       passwordVariable: 'DOCKER_HUB_PASSWORD']]) {
    //       sh """
    //         docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}
    //         docker build -t namespace/my-image:${gitCommit} .
    //         docker push namespace/my-image:${gitCommit}
    //         """
    //     }
    //   }
    // }
  }
}
