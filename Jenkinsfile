pipeline {
    agent any
    tools {
        maven 'maven'
    }
    stages {
	stage('MavenVersion') {
            steps {
                sh 'mvn --version'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn install -Dmaven.test.skip=true'
            }
        }
    }
}
