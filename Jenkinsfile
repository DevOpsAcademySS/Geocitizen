pipeline{
    agent {
  label 'agent-ubuntu'
}
    tools {
  maven 'maven-ubuntu'
}
    environment {
        ANSIBLE_PRIVATE_KEY     = credentials('aws-credential-ansible')
}
    stages{
        //stage('Git checkout'){
        //    steps{
        //        git branch: 'IA-135-mykola-manual-deploy-geocitizen', credentialsId: '0d321903-fc6f-4ed8-840a-25772018b1b1', url: 'https://github.com/DevOpsAcademySS/Geocitizen.git'    
        //    }
        //}
         stage('BUILD'){
            steps{
                sh """
                ./install.sh
                """
            }
        }
        stage('change servers IPs'){
            steps{
                sh """
                sed -i -E 's,host=.*,host='\$(cat $HOME/.cache/amazon_ip | tr -d '"')',g' amazon
                """
            }
        }
        stage('upload citizen.war and restart tomcat'){
            steps{
                sh """
                ansible-playbook deploy.yml -i amazon --private-key=$ANSIBLE_PRIVATE_KEY
                """
            }
        }
    }
    post {
        success { 
            telegramSend('BUILD IS SUCCESFULL. job: $JOB_NAME')
        }
        failure { 
            telegramSend('BUILD FAILED. job: $JOB_NAME')
        }
    }
}