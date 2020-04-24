pipeline {
     agent any
     stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html'
            }
        }

        stage('Build image') {
            steps {
                echo 'Starting to build docker image'
                script {
                    app = docker.build("helara/devops-nanodegree")
                }
            }
        }

        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'DockerHub') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }

        stage('Apply Kubernetes configuration') {
            steps {
                withKubeConfig([credentialsId: 'KubeConfig']) {
                    sh 'kubectl apply -f deployment.yaml --validate=false' 
                }
            }
        }
    }
}
