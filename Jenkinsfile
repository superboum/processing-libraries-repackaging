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
      withEnv(["HOME=${ pwd() }"]) { 
        sh 'mv /opt/OpenKinect-for-Processing/OpenKinect-Processing ~'
        sh 'mv /opt/processing-3.3.7 ~'
        sh 'mkdir -p ~/sketchbook/libraries/'
        sh 'cd ~/OpenKinect-Processing/resources && ant -Dsketchbook.location=../sketchbook -Dclasspath.local.location=../processing-3.3.7/core/library/ -Dis.normal=true'
        sh 'mv ~/OpenKinect-Processing/distribution/openkinect_processing-5/download/openkinect_processing.zip ~'
        archiveArtifacts artifacts: 'openkinect_processing.zip'
      }
    }
  }
}
