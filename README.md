# Jetson-Xavier-NX-OpenCV-4.5.4-CUDA-Build-Recipe
n Xavier NX — OpenCV 4.5.4 + CUDA/cuDNN System Freeze

This repository contains a complete, reproducible system freeze of a Jetson Xavier NX
running JetPack 4.x with a fully accelerated OpenCV 4.5.4 build (CUDA 11.4, cuDNN 8.6,
GStreamer, FFmpeg, V4L2, contrib modules, Python 3.8 bindings).

The goal of this freeze is to provide a deterministic, minimal, and fully restorable
baseline for computer vision and reinforcement learning workloads on the Xavier NX.

---

## Contents

### **System State Snapshots**
- `dpkg-selections.txt` — full list of installed apt packages  
- `apt-policy.txt` — repository priorities and versions  
- `cuda-packages.txt` — CUDA, cuDNN, TensorRT package versions  
- `pip-freeze.txt` — Python 3.8 environment  
- `environment.txt` — system environment variables  
- `kernel.txt` — kernel and firmware versions  

### **OpenCV Build Artifacts**
- `CMakeCache.txt` — exact CMake configuration used  
- `opencv-install/` — installed OpenCV Python bindings and data files  

---

## OpenCV Build Summary

- **OpenCV:** 4.5.4  
- **CUDA:** 11.4  
- **cuDNN:** 8.6  
- **GPU Arch:** 7.2 (Xavier NX)  
- **GStreamer:** 1.16.3  
- **FFmpeg:** enabled  
- **V4L2:** enabled  
- **Python:** 3.8 bindings installed to `/usr/local/lib/python3.8/site-packages`  

---

## Restore Instructions

To rebuild this environment on a fresh Jetson Xavier NX running JetPack 4.x:

```bash
chmod +x restore.sh
./restore.sh

