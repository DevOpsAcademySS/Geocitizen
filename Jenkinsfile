pipeline{
    agent {
  label 'agent-ubuntu'
}
    tools {
  maven 'maven-ubuntu'
}
parameters {
        string(name: 'amazonIP', defaultValue: '0', description: 'IP for Amazon host')
        string(name: 'ubuntuIP', defaultValue: '0', description: 'IP for Ubuntu host')
}
    stages{
        //stage('Git checkout'){
        //    steps{
        //        git branch: 'IA-135-mykola-manual-deploy-geocitizen', credentialsId: '0d321903-fc6f-4ed8-840a-25772018b1b1', url: 'https://github.com/DevOpsAcademySS/Geocitizen.git'    
        //    }
        //}
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
            build job: 'deliver-geo', parameters: [string(name: 'amazonIP', value: String.valueOf(amazonIP))], wait:false
            telegramSend('BUILD IS SUCCESFULL. job: $JOB_NAME')
        }
        failure { 
            telegramSend('BUILD FAILED. job: $JOB_NAME')
        }
    }
}