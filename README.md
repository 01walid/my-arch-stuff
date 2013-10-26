My Arch Linux Stuff
===================

Personal repository of dotfiles, configs, scripts and tools I often setup after any (arch) Linux
installation. I decided to gather them in one place, so I can remember exactly what I did, and 
maintain the same personal-experience across machines/servers and improve it over time.


You’re welcome to use them, but you’ll probably want to fork it to remove anything peculiar to me 
or my setup that I’ve left in here. I'll be glad if you suggest me any improvement or better tools.

These are a bit Archlinux-specific stuff, but they can be useful for other distros as well.


# Post-installation tools

Don't expect that I'll list everything here (e.g. install git, libreoffice, firefox...), but I'll 
list what are other uncommon tools that I need them or found them useful to me, but it's usually
hard to remember them (or even their names) at once, so here they are:

### extra packages repositories

I often activate the `multilib` repository in `/etc/pacman.conf` plus these 2 more repos:

```
[archlinuxfr]
# For downloading 'yaourt', a wrapper for pacman which adds seamless access to the Arch User Repository
SigLevel = Never
Server = http://repo.archlinux.fr/$arch

[herecura-stable]
# additional apps not found in community (such as python-enabled Vim, qVim, teamviewer... etc)
Server = http://repo.herecura.be/herecura-stable/$arch
SigLevel = PackageOptional
```

### sorting the best mirrors

I use [Reflector](https://wiki.archlinux.org/index.php/Reflector), a script which can retrieve the 
latest mirror list from the [MirrorStatus](https://www.archlinux.org/mirrors/status/) page, filter 
the most up-to-date mirrors, sort them by speed and overwrite the file `/etc/pacman.d/mirrorlist`.


Here is the command I use:

```shell
reflector --verbose -l 6 --sort rate --save /etc/pacman.d/mirrorlis
```

You can find it in `scripts/bestservers.sh` so you don't have to remember it.

### font configs 

I use the awesome [infinality](http://www.infinality.net/) project to improve the font rendering, to 
an even better-than-windows rendering:

```shell
yaourt freetype2-infinality 
yaourt fontconfig-infinality # this may be a dependency of the first one
```

I then activate the [LCD filter](https://wiki.archlinux.org/index.php/Font_Configuration#LCD_filter),
anyway, everything is very well described in the [Arch Wiki](https://wiki.archlinux.org/index.php/Font_Configuration). 
you can find my fonts.conf file in `confs/.config/fontconfig/fonts.conf` that obviously should reside 
in `~/.config/fontconfig/fonts.conf` of your Home directory.

However, some widely used fonts (especially on the web) should be installed in your system, here are 
some I often install:

```shell
yaourt ttf-arabeyes-fonts # Collection of free Arabic fonts
yaourt ttf-amiri 
yaourt ttf-sil-scheherazade # Unicode Arabic font from SIL 
yaourt ttf-qurancomplex-fonts # Fonts by King Fahd Glorious Quran Printing Complex in al-Madinah al-Munawwarah
pacman -S ttf-ubuntu-font-family
yaourt ttf-tahoma # or yaourt ttf-microsoft-tahoma 
yaourt ttf-win7-fonts 
```

See this [Wiki section](https://wiki.archlinux.org/index.php/Fonts#Font_packages) for more fonts. 
For the terminal (and even for coding) I use Monofur, and as Arabic web content is more and more using
the Android fonts, I also install droid-arabic-naskh and droid-arabic-kufi (they're all available in AUR).

If you installed Infinality as I mentioned, it comes with the `infctl setstyle` command, you can 
select the font style (win7, winxp, osx, linux, ...), for instance: `infctl setstyle win7` to mimic the
font rendering to be the same as Windows7 (or better!).

### Better Gnome/gtk app appearance

I use KDE, and by default, some gtk apps look ugly, to fix that (so they look like native KDE apps), install:

```shell
pacman -S gtk-qt-engin
pacman -S oxygen-gtk3
yaourt oxygen-gtk-icon
```

then go to system settings -> GTK Styles and Fonts, select the oxygen-gtk style, logout/in, done.

For the sake of beauty I use [KFaenza](http://kde-look.org/content/show.php/?content=143890) icons 
(like Faenza but for KDE!) `yaourt kfaenza` with Androbit KDE desktop theme.

### Better windows file systems handling

To be able to format USB sticks and other hard-disk partitions to FAT/NTFS:

```shell
pacman -S dosfstools # gets you mkfs.vfat and mkfs.msdos
pacman -S ntfsprogs  # gets you mkfs.ntf
```

### Better Terminal

I use [zsh](https://wiki.archlinux.org/index.php/Zsh) instead of bash, with the must-have 
[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with git (enabled by default) and 
[syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) plugins. You can find 
my .zshrc file in `dotfiles/.zshrc`.


### Pacman colors
From version >= 4, Pacman support colored outputs, you just need to uncomment the "Color" line in 
`pacman.conf`.


### Git basic config
Important before doing any commit, so you won't loose any credits:

```shell 
git config --global user.name "YOUR FULL NAME HERE"
git config --global user.email "YOUR EMAIL HERE"
git config --global core.editor nano # or vim
git config --global color.ui true
git config format.pretty oneline # optional
```

## Routine stuff

from time to time, I run these commands:

```shell 
$ pacman -Sc # to delete unused packages and free up disk space
$ fc-cache -vf # for refreshing the font cache
$ yaourt -Syua --deve # full system update, however I often just use pacman -Syu
```

# Tools I use

* `pacman -S imagemagic` this includes the `convert` command to convert between image format or resize 
them easily, e.g. `convert input.jpg output.png`, or even to PDF: `convert page*.png output.pdf`. 
Search the web for advanced usage.

* `pacman -S texlive-latexextr` and `pacman -S texlive-scienc` if you use LaTex, these include the 
"polyglossia" package for better Arabic support (see this [paper](http://www.dr-adel.com/pdf/arabic-test-20-4-2011.pd))
and some other useful scientific packages

* `pacman -S youtube-dl` to download online videos from the command line with ease, example usage: 
`youtube-dl -t <video-link-here>`, the `-t` option to set the video title as the name of the downloaded file.

* `pacman -S tree` a directory listing program displaying a depth indented list of files. Example usage:

```shell
$ cd /to/some/directory
$ tree
# the ouput:
|-- net
|   |-- dev_snmp6
|   |-- netfilter
|   |-- rpc
|   |   |-- auth.rpcsec.context
|   |   |-- auth.rpcsec.init
|   |   |-- nfsd.export
|   |   `-- nfsd.fh
|   `-- stat
|-- root -> /
```
you can print that to file: `tree > file.txt`
* `pacman -S cloc` for counting lines of code, see: http://cloc.sourceforge.net, kudos to @sohaibafifi.

* `setfacl` (comes with systemd as a dependency) for more advanced folder and user/groups permissions
* `pacdiff` for managing `.pacnew` files and see the diff, and also use Kompare, and Kdiff3 (GUIs for KDE).

I believe there are other useful tools I use from time to time, I'll write them here whenever I remember them.

# TODO

- [ ] Android devices handling.
- [ ] My nginx configuration files.

# License

Public domain. Do whatever you like with it if any is useful to you.
