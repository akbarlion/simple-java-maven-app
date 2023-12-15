node {
    checkout scm
    stage('Build') {
    	docker.image('maven:3.8.6-eclipse-temurin-18-alpine').inside('-v /root/.m2:/root/.m2') {
		sh 'mvn -B -DskipTests clean package'
	}
    }
    stage('Test') {
    	try {
	        docker.image('maven:3.8.6-eclipse-temurin-18-alpine').inside('-v /root/.m2:/root/.m2') {
			sh 'mvn test'
		}
        } catch (e) {
                echo "Test Stage Failed!"
        } finally {
                junit 'target/surefire-reports/*.xml'
        }
    }
    stage('Manual Approval'){
	    input message: 'Lanjutkan ke tahap Deploy?', ok: 'Proceed'
    }
    stage('Deploy') {
	    archiveArtifacts 'target/submission-app-1.0-SNAPSHOT.jar'
	    docker.build("submission-app:latest");
	    sh "ssh-keyscan -H 13.250.57.185 >> ~/.ssh/known_hosts"
	    sh "/usr/bin/scp -i /var/jenkins_home/appserver.pem /var/jenkins_home/workspace/submission-cicd-pipeline-akbrln/target/submission-app-1.0-SNAPSHOT.jar  ec2-user@13.250.57.185:/home/ec2-user/submission-app-1.0-SNAPSHOT.jar"
	    sh 'docker run --rm submission-app'
	    sleep 60
    }
}