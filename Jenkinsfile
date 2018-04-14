node {
  def app

  stage('Fetch repository') {
    deleteDir()
    checkout scm
  }

  stage('Create build environment') {
    app = docker.build("superboum/processing-kinect")
  }

  stage('Build libfreenect2 library') {
      withEnv(["HOME=${ pwd() }"]) {
        sh 'cp -r /opt/libfreenect2 ~'
        sh 'cd libfreenect2 && patch -p1 ../patch/libfreenect2/01-add-jni-support.patch'
        sh 'cd libfreenect2 && patch -p1 ../patch/libfreenect2/02-add-opencl-device-choice.patch'
        sh 'mkdir -p ~/build-freenect2'
        sh 'cd ~/build-freenect2 && cmake ~/libfreenect2 && make'
        sh 'cp ~/build-freenect2/lib/libfreenect2.so ~'
        archiveArtifacts artifacts: 'libfreenect2.so'
      }
  }

  stage('Build Java Library') {
    app.inside {
      withEnv(["HOME=${ pwd() }"]) {
        sh 'cp -r /opt/OpenKinect-for-Processing/OpenKinect-Processing ~'
        sh 'cp -r /opt/processing-3.3.7 ~'
        sh 'mkdir -p ~/sketchbook/libraries/'
        sh 'cd ~/OpenKinect-Processing/resources && ant -Dsketchbook.location=../sketchbook -Dclasspath.local.location=../processing-3.3.7/core/library/ -Dis.normal=true'
        sh 'mv ~/OpenKinect-Processing/distribution/openkinect_processing-5/download/openkinect_processing.zip ~'
        archiveArtifacts artifacts: 'openkinect_processing.zip'
      }
    }
  }
}
