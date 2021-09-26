pipeline{
    agent any
    tools{
        maven "Maven-3-6-3"
    }
    parameters{
        booleanParam(name:'Ansible',defaultValue:true,description:"Run Ansible pipeline after this pipeline")
        string(name:'WEB_IP',defaultValue:'0.0.0.0',description:'IP address of Geocitizen server on AWS')
        string(name:'DB_IP',defaultValue:'0.0.0.0',description:'IP address of PostgreSQL server on AWS')
    }
    stages{
        stage("Replace IP's and PORT in Geocitizen"){
            steps{
                echo "DB_IP: ${params.DB_IP}"
                echo "WEB_IP: ${params.WEB_IP}"
                bat ".\\Automation\\replace_ip_and_port_geocitizen.sh ${params.DB_IP} ${params.WEB_IP}"
            }
        }
        stage('Build Geocitizen'){
            steps{
                nodejs('Nodejs-12-22-6'){
                    bat ".\\Automation\\build_copy_edit.sh"
                }
            }
        }
        stage('Create Artifact Geocitizen'){
            steps{
                archiveArtifacts artifacts: 'target\\citizen.war', fingerprint: true
            }
        }
    }
    post{
        success{
            echo "SUCCESS!)"
            script {
                if (params.Ansible == true)
                    build job: 'GitHub-Ansible-Configuration', parameters: [string(name: 'WEB_IP', value: String.valueOf(params.WEB_IP)), string(name: 'DB_IP', value: String.valueOf(params.DB_IP))], wait: false
            }
        }
        failure{
            echo "FAIL:("
        }
    }
}