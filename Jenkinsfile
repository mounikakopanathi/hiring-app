pipeline {
    agent any

    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Docker Build') {
            steps {
                sh "docker build . -t dockerhub1126/hiring-app:$BUILD_NUMBER"
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub', variable: 'hubPwd')]) {
                    sh "docker login -u dockerhub1126 -p ${hubPwd}"
                    sh "docker push dockerhub1126/hiring-app:$BUILD_NUMBER"
                }
            }
        }
        stage('Checkout K8S manifest SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/mounikakopanathi/Hiring-app-argocd1.git'
            }
        }
        stage('Update K8S manifest & push to Repo') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'github', variable: 'GIT_TOKEN')]) { 
                        sh '''
                        git config --global user.email "mounikakopanathi1126@gmail.com"
                        git config --global user.name "Mounika"
                        cat /var/lib/jenkins/workspace/$JOB_NAME/dev/deployment.yaml
                        sed -i "s/20/${BUILD_NUMBER}/g" /var/lib/jenkins/workspace/$JOB_NAME/dev/deployment.yaml
                        cat /var/lib/jenkins/workspace/$JOB_NAME/dev/deployment.yaml
                        git add .
                        git commit -m 'Updated the deploy yaml | Jenkins Pipeline'
                        git remote -v
                        git push https://$GIT_TOKEN@github.com/mounikakopanathi/Hiring-app-argocd1.git main
                        '''
                    }
                }
            }
        }
    }
}
