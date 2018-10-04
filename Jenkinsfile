def image='kfr2/pipeline-experiments'

pipeline {
    agent {
        kubernetes {
            label 'pipeline-test-build-pod'
            yamlFile 'KubernetesPod.yaml'
        }
    }

    stages {
        stage('Decrypt secrets') {
            steps {
                withCredentials([file(credentialsId: 'GITCRYPT_KEY', variable: 'GITCRYPT_KEY')]) {
                    sh "git-crypt unlock $GITCRYPT_KEY"
                }
            }
        }

        stage('Run jet') {
            environment {
                CI_BRANCH = env.BRANCH_NAME
                CI_AUTHOR = env.CHANGE_AUTHOR
            }
            steps {
                container('docker') {
                    sh "jet steps"
                }
            }
        }
    }
}
