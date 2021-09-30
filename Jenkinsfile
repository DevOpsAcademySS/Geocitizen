pipeline{
    agent any
    tools {
  maven 'maven-ubuntu'
}
parameters {
        string(name: 'amazonIP', defaultValue: '0', description: 'IP for Amazon host')
        string(name: 'ubuntuIP', defaultValue: '0', description: 'IP for Ubuntu host')
}
    stages{
         stage('REPLACE'){
            steps{
                sh """
                sed -i -E '\\@(front.*|back.*)[Uu]rl@s@p:.*:@p://$amazonIP:@g' ./src/main/resources/application.properties ./front-end/src/main.js
                sed -i -E '\\|db.url|s|l:.*/ss|l://$ubuntuIP:5432/ss|g' ./src/main/resources/application.properties
                sed -i -E '\\@vue-(mat|rou)@s@\\^@@g' ./front-end/package.json
                sed -i -E '\\|repo.spring.io/milestone|s|http|https|g' pom.xml
                """
            }
        }
        stage('Front-end BUILD'){
            steps{
                nodejs('NodeJS12'){
                sh """
                (cd ./front-end && npm install && npm audit fix && npm run build --no-progress --no-color | sed "s,\\x1B\\[[0-9;]*[a-zA-Z],,g")
                """
                }
            }
        }
        stage('Back-end BUILD'){
            steps{
                sh """
                cp -r ./front-end/dist/* ./src/main/webapp/
                sed -i -E '\\|/static|s|=/static|=./static|g' ./src/main/webapp/index.html
                mvn install
                """
            }
        }
         stage('nexus publish'){
            steps{
                //createTag nexusInstanceId: 'nexus3', tagName: 'build-$BUILD_NUMBER'
                nexusPublisher nexusInstanceId: 'nexus3', nexusRepositoryId: 'geocitizen', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: 'target/citizen.war']], mavenCoordinate: [artifactId: 'geo-citizen', groupId: 'com.softserveinc', packaging: 'war', version: '1.0.5']]]//, tagName: 'build-$BUILD_NUMBER'
            }
        }
    }
    post {
        success {
          //  build job: 'deliver-geo', parameters: [string(name: 'amazonIP', value: String.valueOf(amazonIP))], wait:false
            telegramSend('BUILD IS SUCCESFULL. job: $JOB_NAME')
        }
        failure { 
            telegramSend('BUILD FAILED. job: $JOB_NAME')
        }
    }
}