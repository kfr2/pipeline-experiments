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
  ) {

  def image = "kfr2/pipeline-experiments"

  node(label) {
    stage('Checkout repository') {
      checkout scm
    }

    stage('Decrypt secrets') {
      withCredentials([file(credentialsId: 'GITCRYPT_KEY', variable: 'GITCRYPT_KEY')]) {
        sh "git-crypt unlock $GITCRYPT_KEY"
      }
    }

    stage('Build Docker image') {
      container('docker') {
        sh "docker build -t ${image} ."
      }
    }
  }
}
