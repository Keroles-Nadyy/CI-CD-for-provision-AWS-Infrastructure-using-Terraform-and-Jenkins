pipeline {
    agent { label 'aws-node-slave' }
    
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'prod'], description: 'Select the environment (dev or prod)')
        choice(name: 'ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Select the action (plan, apply, destroy)')
    }
    
    stages {
        stage('Checkout repo') {
            steps {
                git branch: 'main', url: 'https://github.com/Keroles-Nadyy/CI-CD-for-provision-AWS-Infrastructure-using-Terraform-and-Jenkins'
            }
        }
        
        stage('Navigate to Terraform Code Directory') {
            steps {
                script {
                    dir('Infrastructure-terraform-code') {
                        sh 'pwd'
                        sh 'ls -la'
                        sh 'terraform init'
                    }
                }
            }
        }
        
        stage('Validate workspace existence') {
            steps {
                script {
                    dir('Infrastructure-terraform-code') {
                        def workspaceExistance = sh(script: "terraform workspace list | grep ${params.ENVIRONMENT}", returnStatus: true)

                        if (workspaceExistance != 0) {
                            echo "Workspace '${params.ENVIRONMENT}' does not exist."
                            echo "Creating '${params.ENVIRONMENT}' Workspace..."
                            sh "terraform workspace new ${params.ENVIRONMENT}"
                        }
                    }
                }
            }
        }
        
        stage('Select tfvars file and Apply') {
            steps {
                script {
                    def selectedTFvarsFile
                    switch(params.ENVIRONMENT) {
                        case 'dev':
                            selectedTFvarsFile = 'dev.tfvars'
                            break
                        case 'prod':
                            selectedTFvarsFile = 'prod.tfvars'
                            break
                        default:
                            error "Invalid environment selected"
                    }

                    dir('Infrastructure-terraform-code') {
                        sh "terraform workspace select ${params.ENVIRONMENT}"
                        sh "terraform init"
                        
                        // Perform actions based on selected action
                        switch(params.ACTION) {
                            case 'plan':
                                sh "terraform plan -var-file=${selectedTFvarsFile}"
                                break
                            case 'apply':
                                sh "terraform plan -var-file=${selectedTFvarsFile}"
                                sh "terraform apply -auto-approve -var-file=${selectedTFvarsFile}"
                                break
                            case 'destroy':
                                sh "terraform destroy -var-file=${selectedTFvarsFile}"
                                break
                            default:
                                error "Invalid action selected"
                        }
                    }
                }
            }
        }
    }
    post{
        success {
            slackSend color: "#439FE0", message: "Build success!: ${env.JOB_NAME}"
        }
        failure {
            slackSend color: "#439FE0", message: "Build Failed!: ${env.JOB_NAME}"
        }
    }
}