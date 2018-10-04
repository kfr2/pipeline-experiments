def label = "worker-${UUID.randomUUID().toString()}"

def myRepo = checkout scm
def gitCommit = myRepo.GIT_COMMIT
def gitBranch = myRepo.GIT_BRANCH

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
        envVar(key: 'CI_BRANCH', value: gitBranch),
    ]
  )
]) {
  node(label) {
    checkout scm

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
        sh "jet steps"
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
