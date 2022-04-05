pipeline {
    agent any 
    stages {
        stage ('git clone') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/SatyaNarayan2506/exam.git']]])
            }
        }
        stage ('terafform init') {
            steps {
                sh '''
                terraform init
                terraform plan 
                '''
            }

        }        
        stage ('terraform apply in gcp') {
            steps {
                sh 'terraform destroy -auto-approve'
            }
        } 
    }
}
