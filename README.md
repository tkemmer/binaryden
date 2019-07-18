# BinaryDen portage overlay
This portage overlay primarily aims at providing packages for the most current versions of
the [**Cinnamon**](https://github.com/linuxmint) desktop environment as well as version
bumps and patches for several other Gentoo packages.

## Notable additions to ::gentoo
 * `app-editors/atom-bin`
 * `dev-libs/parquet-cpp`
 * `x11-misc/slick-greeter`

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
