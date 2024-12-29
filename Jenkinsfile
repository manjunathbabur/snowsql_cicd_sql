pipeline {
    agent any

    environment {
        GIT_REPO = "https://github.com/manjunathbabur/snowsql_cicd_sql.git"
        GIT_BRANCH = "main"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Setup Environment') {
            steps {
                sh 'chmod +x scripts/run_sql.sh'
            }
        }

        stage('Execute SQL Files') {
            steps {
                script {
                    def sqlFiles = sh(script: "ls sql/*.sql", returnStdout: true).trim().split("\n")
                    for (file in sqlFiles) {
                        echo "Executing ${file}"
                        sh "./scripts/run_sql.sh ${file}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
