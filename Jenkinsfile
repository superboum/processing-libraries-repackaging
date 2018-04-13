node {
  def app

  stage('Fetch repository') {
    deleteDir()
    checkout scm
  }

  stage('Create build environment') {
    app = docker.build("superboum/processing-kinect")
  }

  stage('Build project') {
    app.inside {
      sh 'mv /opt/OpenKinect-for-Processing/OpenKinect-Processing .'
      sh 'mv /opt/processing-3.3.7 .'
      dir('./OpenKinect-Processing/resources') {
        sh 'mkdir -p ./sketchbook/library/'
        sh 'ant -Dsketchbook.location=./sketchbook -Dclasspath.local.location=../processing-3.3.7/core/library/ -Dis.normal=true'
      }
      dir('./OpenKinect-Processing/distribution/openkinect_processing-5/download/') {
        archiveArtifacts artifacts: 'openkinect_processing.zip'
      }
    }
  }
}
