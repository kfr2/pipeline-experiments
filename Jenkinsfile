def label = "docker-${UUID.randomUUID().toString()}"

pipeline {
    agent {
        kubernetes {
            label ${label}
            defaultContainer 'jnlp'
            yamlFile 'KubernetesPod.yaml'
        }
    }

    stages {
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

        stage('Run tests') {
        container('docker') {
            sh "docker run --rm ${image} /srv/test.sh"
        }
        }

        stage('Push image') {
            // Yep
        }

        stage('Prune image') {
            container('docker') {
                sh "docker rmi ${image}"
            }
        }
    }
}
