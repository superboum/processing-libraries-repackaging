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
      dir('/opt/OpenKinect-for-Processing/OpenKinect-Processing/resources') {
        sh 'mkdir -p /opt/sketchbook/library/'
        sh 'ant -Dsketchbook.location=/opt/sketchbook -Dclasspath.local.location=/opt/processing-3.3.7/core/library/ -Dis.normal=true'
      }
      dir('/opt/OpenKinect-for-Processing/OpenKinect-Processing/distribution/openkinect_processing-5/download/') {
        archiveArtifacts artifacts: 'openkinect_processing.zip'
      }
    }
  }
}
