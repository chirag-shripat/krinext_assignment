pipeline {

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git branch: 'main', credentialsId: 'github-pass', url: 'https://github.com/chirag-shripat/krinext_assignment.git'
                        }
                    }
                }
            }

        stage('Plan') {
            steps {
                sh 'pwd;cd terraform/ ; terraform init'
            }
        }

        stage('Apply') {
            steps {
                sh "pwd;cd terraform/ ; terraform apply --auto-approve"
            }
        }
        
        stage('Execute Ansible') {
            steps {
                ansiblePlaybook credentialsId: 'ansible-cred', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/host.inv', playbook: '/home/ec2-user/workspace/web.yaml'
            }
        }
    }

  }