pipeline {
    agent any

    environment {
        GIT_REPO = "https://github.com/manjunathbabur/snowsql_cicd_sql.git"
        GIT_BRANCH = "main"
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the Git repository
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Setup Environment') {
            steps {
                // Ensure scripts are executable and environment is prepared
                echo "Setting up environment for SQL execution"
            }
        }

        stage('Execute SQL Files') {
            steps {
                // Execute all SQL files in the 'sql' directory
                bat '''
                echo "Starting SQL execution process..."
                for %%f in (sql\\*.sql) do (
                    echo "Executing SQL file: %%f"
                    scripts\\run_sql.bat %%f
                )
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs for errors.'
        }
    }
}
