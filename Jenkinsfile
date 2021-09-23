pipeline{
    agent any
    tools {
        maven 'maven'
    }
    stages{
         stage('BUILD'){
            steps{
                sh """
                echo $JAVA_HOME
                mvn --version
                
                """
            }
        }
         stage('archive'){
            steps{
                archiveArtifacts artifacts: 'target/citizen.war', fingerprint: true
            }
        }
    }
    //post {
        //success {
        //    build job: 'geo-ansible-job', parameters: [string(name: 'amazonIP', value: String.valueOf(amazonIP)), string(name: 'ubuntuIP', value: String.valueOf(ubuntuIP))], wait:false
        //}
    //}
}
