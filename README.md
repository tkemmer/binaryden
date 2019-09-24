# BinaryDen portage overlay
This portage overlay primarily aims at providing packages for the most current versions of
the [**Cinnamon**](https://github.com/linuxmint) desktop environment as well as version
bumps and patches for several other Gentoo packages.

## Notable additions to ::gentoo
 * [`app-editors/atom-bin`](https://github.com/atom/atom):
   The hackable text editor
 * [`dev-cpp/clipp`](https://github.com/muellan/clipp):
   Expressive command line argument parsing for modern C++
 * [`dev-libs/parquet-cpp`](https://github.com/apache/parquet-cpp):
   Apache Parquet for C++
 * [`sys-apps/piper`](https://github.com/libratbag/piper):
   GTK application to configure gaming mice
 * [`x11-misc/slick-greeter`](https://github.com/linuxmint/slick-greeter):
   A slick-looking LightDM greeter

## Installation using layman
First, make this overlay available to layman by adding the following line to the `overlays`
setting in your layman configuration file (e.g. `/etc/layman/layman.conf`):
```
https://raw.githubusercontent.com/tkemmer/binaryden/master/repositories.xml
```

Afterwards, you can simply add the overlay via
```sh
layman -S
layman -a binaryden
```
Similarly, you can remove this overlay at any time via
```sh
layman -d binaryden
```
