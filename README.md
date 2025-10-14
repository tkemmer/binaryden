# BinaryDen Portage overlay
This Portage overlay primarily aims at providing ebuilds for the most recent versions of
the [**Cinnamon**](https://github.com/linuxmint) desktop environment as well as version
bumps and patches for several other Gentoo packages.

## Notable additions to ::gentoo
 * [`app-misc/bulky`](https://github.com/linuxmint/bulky):
   Bulk renamer
 * [`dev-cpp/clipp`](https://github.com/muellan/clipp):
   Expressive command line argument parsing for modern C++
 * [`media-gfx/xviewer`](https://github.com/linuxmint/xviewer):
   A generic Image viewer
 * [`media-libs/elgato-streamdeck`](https://github.com/abcminiuser/python-elgato-streamdeck):
   Python library to control the Elgato Stream Deck
 * [`sys-apps/hexyl`](https://github.com/sharkdp/hexyl):
   A command-line hex viewer
 * [`x11-misc/slick-greeter`](https://github.com/linuxmint/slick-greeter):
   A slick-looking LightDM greeter
 * [`x11-themes/flat-remix`](https://github.com/daniruiz/flat-remix):
   Pretty simple Linux icon theme inspired by material design

## Setup 

### `app-eselect/eselect-repository`
To enable this repository on your system, install `app-eselect/eselect-repository` and then use the following command:
```sh
eselect repository enable binaryden
```
To disable this overlay and remove its contents from your system, execute
```sh
eselect repository remove binaryden
```
