# BinaryDen portage overlay
This portage overlay primarily aims at providing packages for the most current versions of
the [**Cinnamon**](https://github.com/linuxmint) desktop environment as well as version
bumps and patches for several other Gentoo packages.

## Notable additions to ::gentoo
 * [`app-editors/atom-bin`](https://github.com/atom/atom):
   The hackable text editor
 * [`dev-cpp/arrow`](https://github.com/apache/arrow):
   Apache Arrow/Parquet for C++
 * [`dev-cpp/clipp`](https://github.com/muellan/clipp):
   Expressive command line argument parsing for modern C++
 * [`dev-libs/thrift`](https://github.com/apache/thrift)
   Apache Thrift
 * [`sys-apps/piper`](https://github.com/libratbag/piper):
   GTK application to configure gaming mice
 * [`sys-process/nvtop`](https://github.com/syllo/nvtop):
   NVIDIA GPUs htop like monitoring tool
 * [`x11-misc/slick-greeter`](https://github.com/linuxmint/slick-greeter):
   A slick-looking LightDM greeter
 * [`x11-themes/flat-remix`](https://github.com/daniruiz/flat-remix):
   Pretty simple Linux icon theme inspired by material design

## Installation using layman
This overlay can be added to your system via
```sh
layman -Sa binaryden
```
Similarly, you can remove this overlay at any time via
```sh
layman -d binaryden
```
