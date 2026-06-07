pipeline {
    agent any

    environment {
        IMAGE_NAME = 'evariverdi-ui'
        CONTAINER_NAME = 'evariverdi-ui'
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Repo cekiliyor...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Docker image build ediliyor...'
                dir('app') {
                    sh 'docker build -t ${IMAGE_NAME}:latest .'
                }
            }
        }

        stage('Deploy') {
            when {
                anyOf {
                    branch 'main'
                    branch 'master'
                }
            }
            steps {
                echo 'Deploy baslatiliyor...'
                sh '''
                    # Eski containeri durdur ve sil
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    
                    # Yeni container baslat
                    docker compose -f docker-compose.yml up -d
                    
                    # Container saglik kontrolu
                    sleep 5
                    docker ps | grep ${CONTAINER_NAME}
                '''
            }
        }
    }

    post {
        always {
            echo 'Temizlik yapiliyor...'
            sh 'docker system prune -f || true'
        }
        success {
            echo 'Deploy basarili! Site: https://evariverdi.art'
        }
        failure {
            echo 'Deploy basarisiz!'
        }
    }
}
