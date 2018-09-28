pipeline {
  agent any

  def label = "docker-${UUID.randomUUID().toString()}"
  podTemplate(label: label, yaml: """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: docker:1.11
    command: ['cat']
    tty: true
    volumeMounts:
    - name: dockersock
      mountPath: /var/run/docker.sock
  volumes:
  - name: dockersock
    hostPath:
      path: /var/run/docker.sock
"""
  ){
    stages {
      stage("Decrypt secrets") {
        steps {
          withCredentials([file(credentialsId: 'GITCRYPT_KEY', variable: 'GITCRYPT_KEY')]) {
            sh "git-crypt unlock $GITCRYPT_KEY"
          }
        }
      }

      def image = "kfr2/pipeline-experiments"
      node(label) {
        stage('Build Docker image') {
          container('docker') {
            sh "docker build -t ${image} ."
          }
        }
      }
    }
  }
}
