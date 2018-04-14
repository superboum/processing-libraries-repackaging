# Processing libraries re-packaging

[![Build Status](https://ci.deuxfleurs.fr/buildStatus/icon?job=processing-repackaging/master)](https://ci.deuxfleurs.fr/job/processing-repackaging/job/master/)

Currently I only re-packaged OpenKinect for Processing.

## OpenKinect for Processing

[download openkinect_processing.zip](https://ci.deuxfleurs.fr/job/processing-repackaging/job/master/lastSuccessfulBuild/artifact/openkinect_processing.zip) - instructions can be found below.

I was unable to find a compiled version of *OpenKinect for Processsing* that works on Linux, neither in Processing library manager nor in their Github repository releases: this is why I created this repository and a Jenkins job to build it.

Furthermore, the provided version doesn't allow users to choose the OpenCL device used to accelerate computation for Kinect v2 devices.
So we add a new method to select the OpenCL device as sometimes the automatically choosen device doesn't work (in our case a nvidia graphic card on a Dell Inspiron 7537 laptop with optimus).

Instructions are written for Fedora 27. You might need to adapt them to your distribution.

### Install OpenKinect on Fedora 27

First, install required dependencies:

```
wget https://github.com/superboum/packaging/raw/master/vendor/compat-libjpeg8-1.5.3-3.fc29.x86_64.rpm
sudo dnf install libusb libva turbojpeg glfw ocl-icd ./compat-libjpeg8-1.5.3-3.fc29.x86_64.rpm
```

Now, download the processing library:

```
cd ~/sketchbook/libraries
https://ci.deuxfleurs.fr/job/processing-repackaging/job/master/lastSuccessfulBuild/artifact/openkinect_processing.zip
unzip openkinet_processing.zip
```

### Run it

After that, you can use it as follow for Kinect v2:

```java
import org.openkinect.freenect2.*;
Kinect2 kinect2;
int kinectIndex = 0;
int openClIndex = 1;

void setup() {
  size(512,424);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice(kinectIndex, openClIndex);
}

void draw() {
  background(0);
  PImage img = kinect2.getDepthImage();
  image(img,0,0);
}
```

*You might need to run Processing as root to have access to USB devices. If you are on Wayland, you might need to run `xhost +SI:localuser:root` before to allow graphical root programs.*

### Patches

 * Add `Kinect2.initDevice(int index, int cl_index)` method.

### Links

  * [OpenKinect for Processing](https://github.com/shiffman/OpenKinect-for-Processing/)
  * [libfreenect2](https://github.com/OpenKinect/libfreenect2)
