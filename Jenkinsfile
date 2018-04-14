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
    app.inside {
      withEnv(["HOME=${ pwd() }"]) {
        // Copy and patch
        sh 'cp -r /opt/libfreenect2 ~'
        sh 'cd libfreenect2 && patch -p1 < ../patch/libfreenect2/01-add-jni-support.patch'
        sh 'cd libfreenect2 && patch -p1 < ../patch/libfreenect2/02-add-opencl-device-choice.patch'

        // Compile
        sh 'mkdir -p ~/build-freenect2'
        sh 'cd ~/build-freenect2 && cmake ~/libfreenect2 && make'

        // Archive
        sh 'cp ~/build-freenect2/lib/libfreenect2.so ~'
        stash includes: 'libfreenect2.so', name: 'libfreenect2'
        archiveArtifacts artifacts: 'libfreenect2.so'
      }
    }
  }

  stage('Build Java Library') {
    app.inside {
      withEnv(["HOME=${ pwd() }"]) {
        // Copy and patch
        sh 'cp -r /opt/processing-3.3.7 ~'
        sh 'cp -r /opt/OpenKinect-for-Processing/ ~'
        sh 'cd OpenKinect-for-Processing && patch -p1 < ../patch/openkinect-processing/01-add-opencl-choice-jni.patch'

        // Restore libfreenect2.so
        sh 'rm -f ~/OpenKinect-for-Processing/OpenKinect-Processing/lib/v2/linux/libfreenect2*'
        unstash 'libfreenect2'
        sh 'mv libfreenect2.so ~/OpenKinect-for-Processing/OpenKinect-Processing/lib/v2/linux/'

        // Compile
        sh 'mkdir -p ~/sketchbook/libraries/'
        sh 'cd ~/OpenKinect-for-Processing/OpenKinect-Processing/resources && ant -Dsketchbook.location=../../sketchbook -Dclasspath.local.location=../../processing-3.3.7/core/library/ -Dis.normal=true'

        // Archive
        sh 'mv ~/OpenKinect-for-Processing/OpenKinect-Processing/distribution/openkinect_processing-5/download/openkinect_processing.zip ~'
        archiveArtifacts artifacts: 'openkinect_processing.zip'
      }
    }
  }
}
