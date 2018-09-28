def label = "docker-${UUID.randomUUID().toString()}"

pipeline {
    agent {
        kubernetes {
            label "${label}"
            defaultContainer 'jnlp'
            yamlFile 'KubernetesPod.yaml'
        }
    }

    stages {
        stage('Checkout repository') {
            steps {
                checkout scm
            }
        }

        stage('Decrypt secrets') {
            steps {
                withCredentials([file(credentialsId: 'GITCRYPT_KEY', variable: 'GITCRYPT_KEY')]) {
                    sh "git-crypt unlock $GITCRYPT_KEY"
                }
            }
        }

        stage('Build Docker image') {
            steps {
                container('docker') {
                    sh "docker build -t ${image} ."
                }
            }
        }

        stage('Run tests') {
            steps {
                container('docker') {
                    sh "docker run --rm ${image} /srv/test.sh"
                }
            }
        }

        stage('Push image') {
            // Yep
        }

        stage('Prune image') {
            steps {
                container('docker') {
                    sh "docker rmi ${image}"
                }
            }
        }
    }
}
