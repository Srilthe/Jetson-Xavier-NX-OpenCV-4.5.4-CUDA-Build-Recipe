tore.sh` (drop into repo root, make executable)**

This script rebuilds the entire environment from scratch on any Xavier NX running JetPack 4.x.

```bash
#!/bin/bash
set -e

echo "[1/7] Updating apt..."
sudo apt update

echo "[2/7] Installing dependencies..."
sudo apt install -y build-essential cmake git pkg-config \
	    libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev \
	        libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev \
		    libdc1394-22-dev libv4l-dev v4l-utils \
		        libxvidcore-dev libx264-dev \
			    python3.8-dev python3.8-venv python3-numpy \
			        gstreamer1.0-tools gstreamer1.0-plugins-base \
				    gstreamer1.0-plugins-good gstreamer1.0-plugins-bad \
				        gstreamer1.0-plugins-ugly gstreamer1.0-libav

echo "[3/7] Cloning OpenCV 4.5.4..."
cd ~
if [ ! -d "opencv" ]; then
	    git clone https://github.com/opencv/opencv.git -b 4.5.4
fi
if [ ! -d "opencv_contrib" ]; then
	    git clone https://github.com/opencv/opencv_contrib.git -b 4.5.4
fi

echo "[4/7] Configuring OpenCV build..."
cd ~/opencv
rm -rf build
mkdir build && cd build

cmake \
	  -D CMAKE_BUILD_TYPE=Release \
	    -D CMAKE_INSTALL_PREFIX=/usr/local \
	      -D OPENCV_GENERATE_PKGCONFIG=ON \
	        -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
		  -D WITH_CUDA=ON \
		    -D CUDA_ARCH_BIN="7.2" \
		      -D CUDA_ARCH_PTX="" \
		        -D WITH_CUDNN=ON \
			  -D WITH_CUBLAS=ON \
			    -D ENABLE_FAST_MATH=1 \
			      -D CUDA_FAST_MATH=1 \
			        -D WITH_GSTREAMER=ON \
				  -D WITH_V4L=ON \
				    -D BUILD_opencv_python3=ON \
				      -D PYTHON3_EXECUTABLE=/usr/bin/python3.8 \
				        -D PYTHON3_INCLUDE_DIR=/usr/include/python3.8 \
					  -D PYTHON3_LIBRARY=/usr/lib/aarch64-linux-gnu/libpython3.8.so \
					    -D PYTHON3_NUMPY_INCLUDE_DIRS=$(python3.8 -c "import numpy; print(numpy.get_include())") \
					      -D BUILD_TESTS=OFF \
					        -D BUILD_PERF_TESTS=OFF \
						  -D BUILD_EXAMPLES=OFF \
						    ..

echo "[5/7] Building OpenCV..."
make -j$(nproc)

echo "[6/7] Installing OpenCV..."
sudo make install
sudo ldconfig

echo "[7/7] Restoring Python path..."
echo "/usr/local/lib/python3.8/site-packages" | \
	  sudo tee /usr/local/lib/python3.8/dist-packages/opencv_local.pth

echo "Restore complete."
echo "Run the verification block in README.md to confirm CUDA/cuDNN functionality."

