pipeline{
    agent any
    tools {
        maven 'maven'
    }
    stages{
        stage('SET IPs'){
            steps{
                sh """
                echo $amazonIP > amazon_ip
                echo $ubuntuIP > ubuntu_ip
                """
            }
        }
         stage('BUILD'){
            steps{
                sh """
                ./install.sh
                """
            }
        }
         stage('archive'){
            steps{
                archiveArtifacts artifacts: 'target/citizen.war', fingerprint: true
            }
        }
    }
    post {
        success {
            build job: 'geo-ansible-job', parameters: [string(name: 'amazonIP', value: String.valueOf(amazonIP)), string(name: 'ubuntuIP', value: String.valueOf(ubuntuIP))], wait:false
        }
    }
}
