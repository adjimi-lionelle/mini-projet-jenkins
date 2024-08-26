pipeline {
    environment {
        IMAGE_NAME = "staticwebapp"
        IMAGE_TAG = "latest"
        STAGING = "staticwebapp-staging"
        PRODUCTION = "staticwebp-production"
    }
    agent none
    stages {
        stage('Build image') {
            agent any
            steps {
                script {
                    sh 'docker build -t lionie/$IMAGE_NAME:$IMAGE_TAG .'
                }
            }
        }
        
        stage('Run container based on builded image') {
            agent any
            steps {
                script {
                    sh '''
                        echo "Clean Environment"
                        docker run -e PORT=8082 -d -p 8082:8082 --name $IMAGE_NAME lionie/$IMAGE_NAME:$IMAGE_TAG
                        sleep 5
                    '''
                }
            }
        }

         stage('Test container') {
            agent any
            steps {
                script {
                    sh '''
                        echo "Testing container..."
                        response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8082)
                        if [ "$response" -ne 200 ]; then
                            echo "Test failed! HTTP response code: $response"
                            exit 1
                        else
                            echo "Test passed! HTTP response code: $response"
                        fi
                    '''
                }
            }
        }

        stage('Clean container') {
            agent any
            steps {
                script {
                    sh '''
                        docker stop $IMAGE_NAME
                        docker rm $IMAGE_NAME
                    '''
                }
            }
        }

        stage('Push image in staging and deploy it') {
            when {
                expression { GIT_BRANCH == 'origin/master' }
            }
            agent any
            environment {
                HEROKU_API_KEY = credentials('heroku_api_key')
            }
            steps {
                script {
                    sh '''
                        npm i -g heroku@7.68.0
                        heroku container:login
                        heroku create $STAGING || echo "project already exist"
                        heroku container:push -a $STAGING web
                        heroku container:release -a $STAGING web
                    '''
                }
            }
        }

        stage('Push image in production and deploy it') {
            when {
                expression { GIT_BRANCH == 'origin/master' }
            }
            agent any
            environment {
                HEROKU_API_KEY = credentials('heroku_api_key')
            }
            steps {
                script {
                    sh '''
                        npm i -g heroku@7.68.0
                        heroku container:login
                        heroku create $PRODUCTION || echo "project already exist"
                        heroku container:push -a $PRODUCTION web
                        heroku container:release -a $PRODUCTION web
                    '''
                }
            }
        }
    } 
} 
