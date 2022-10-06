node() {
    properties([
        parameters([
            string(name: 'docker_repo', defaultValue: 'YOUR-SERVICE-NAME', description: 'Docker Image Name'),
            string(name: 'docker_server', defaultValue: 'localhost:5000', description: 'Docker Registry URL'),

        ])
    ])
    stage('Checkout') {
            cleanWs()
            checkout scm
            commit_hash = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
            env.commit_id = sh(script: 'echo ' + env.docker_repo + '_' + commit_hash + '_' + env.BRANCH_NAME, returnStdout: true).trim()
            echo "${env.commit_id}"
    }

    stage('docker-build') {
            sh '''
                docker build -t $docker_server/$docker_repo:$commit_id app/
                '''
    }

    stage('docker-push') {
        sh '''
                docker push $docker_server/$docker_repo:$commit_id
                '''
    }
    stage('ArchiveArtifacts') {
        sh("echo ${commit_id} > commit_id.txt")
                archiveArtifacts 'commit_id.txt'
                currentBuild.description = "${commit_id}"
    }
}