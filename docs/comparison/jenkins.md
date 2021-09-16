```groovy
pipeline {
  agent any
  stages {
    stage('Single Stage') {
      environment {
        API_KEY = credentials('secret')
      }

      steps {
        withCredentials
        echo 'Some step'
      }
    }

    stage('Parallel Stages') {
      when {
        anyOf {
          branch 'main'
          branch 'another'
        }
      }

      parallel {
        stage('Parallel one') {
          agent {
            label "build"
          }

          steps {
            sh 'some command'
          }
        }

        stage('Parallel two') {
          steps {
            withCredentials([usernamePassword(credentialsId: "foo", usernameVariable: 'USER', passwordVariable: 'PASSWORD')]){
              sh 'another command but using $USER and $PASSWORD'
            }
          }
        }
      }
    }
  }
}
```
