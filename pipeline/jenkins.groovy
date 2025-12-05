pipeline {
    agent any

    parameters {
        choice(
            name: 'OS',
            choices: ['linux', 'darwin', 'windows'],
            description: 'Target operating system'
        )
        choice(
            name: 'ARCH',
            choices: ['amd64', 'arm64'],
            description: 'Target architecture'
        )
        booleanParam(
            name: 'SKIP_TESTS',
            defaultValue: false,
            description: 'Skip running tests'
        )
        booleanParam(
            name: 'SKIP_LINT',
            defaultValue: false,
            description: 'Skip running linter'
        )
    }

    environment {
        TARGETOS   = "${params.OS}"
        TARGETARCH = "${params.ARCH}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Info') {
            steps {
                echo "Building for OS=${TARGETOS}, ARCH=${TARGETARCH}"
                echo "SKIP_TESTS=${params.SKIP_TESTS}, SKIP_LINT=${params.SKIP_LINT}"
            }
        }

        stage('Lint') {
            when { expression { !params.SKIP_LINT } }
            steps {
                sh 'echo "Run linter here (golangci-lint / go vet / etc.)"'
            }
        }

        stage('Test') {
            when { expression { !params.SKIP_TESTS } }
            steps {
                sh 'echo "Run tests here, e.g. go test ./..."'
            }
        }

        stage('Build') {
            steps {
                sh '''
                echo "Simulating build..."
                echo "TARGETOS=$TARGETOS TARGETARCH=$TARGETARCH"
                # Здесь могла бы быть реальная сборка:
                # GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o kbot .
                '''
            }
        }
    }
}
