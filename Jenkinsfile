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

        stage('Set Up Environment') {
            steps {
                // Log the environment and ensure SnowSQL is accessible
                bat 'echo Setting up environment...'
                bat 'echo Current PATH: %PATH%'
                bat 'dir sql\\*.sql'
                bat 'type configs\\config.env'
            }
        }

        stage('Execute SQL Files') {
            steps {
                // Execute SQL files with retry and logging
                bat '''
                echo Starting SQL execution process...
                for %%f in (sql\\*.sql) do (
                    echo Executing SQL file: %%f
                    scripts\\run_sql.bat %%f
                )
                echo SQL execution process completed.
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs for details.'
        }
    }
}
