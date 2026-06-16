pipeline {
	agent any
	triggers{
		pollSCM('*/1 * * * *')
	}
	stages {
		stage('build') {
			steps{
				script{
					build()
				}
			}
		}
		stage('deploy-to-dev') {
			steps{
				script{
					deploy('dev')
				}
			}
		}
		stage('tests-on-stg') {
			steps{
				script{
					test('stg')
				}
			}
		}
		stage('deploy-to-stg') {
			steps{
				script{
					deploy('stg')
				}
			}
		}
		stage('tests-on-stg') {
			steps{
				script{
					test('stg')
				}
			}
		}
		stage('deploy-to-prd') {
			steps{
				script{
					deploy('prd')
				}
			}
		}
		stage('tests-on-prd') {
			steps{
				script{
					test('prd')
				}
			}
		}
	}
}

def build(){
	echo "Building docker image for Python microservice..."
	sh "docker build -t atiskrievinstdl/python-greetings-app:latest ."

	echo "Pushing the Python microservice image to Docker registry..."
	sh "docker push atiskrievinstdl/python-greetings-app:latest"
}

def deploy(String environment){
	echo "Now deploying Python microservice to ${environment} environment..."
	echo "Pulling the image from DockerHub..."
	sh "docker pull atiskrievinstdl/python-greetings-app:latest"
	echo "Stopping old containers..."
	sh "docker compose down greetings-app-${environment}"
	echo "Starting new containers..."
	sh "docker compose up greetings-app-${environment}"
	echo "Finished deploying to ${environment}!"
}

def test(String environment){
	echo "Testing Python microservice in ${environment} environment..."
	sh "docker run --network=host --rm atiskrievinstdl/api-tests-final:latest run greetings greetings_${environment}"
	echo "Tests for Python microservice are done."
}
