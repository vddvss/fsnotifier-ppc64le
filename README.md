# JetBrains `fsnotifier` for ppc64le

Most JetBrains IDEs will work on ppc64le, as they are Java-based; however,
file update notifications will not, as the rely on a pre-compiled binary
called `fsnotifier`. The source code for this binary is available at:
<https://github.com/JetBrains/intellij-community/blob/master/native/fsNotifier/linux>,
and the `.c` and `.h` files in this repo are taken from there.

This repo provides pre-compiled `fsnotifier` binary for ppc64le, as well as
a `Makefile` to build and install the ppc64le binary.

## Binary download

You can download a pre-compiled binary and then follow the directions in
[Configuring JetBrains applications](#configuring-jetbrains-applications).

| Binary | `sha256sum` |
|--------|-------------|
| [fsnotifier-ppc64le](https://github.com/vddvss/fsnotifier-ppc64le/releases/download/20190907.1708/fsnotifier-ppc64le) | `b890d2852942b1613f714f83eb739b288a2b5c486fbce155986db5782f29ae5b` |

## Building from source

```
$ make
```

Note this will emit a few warnings when compiled with `gcc`, but these are okay.

Optionally, run:

```
$ make check
```

### Installing

You can run:

```
$ sudo make install
```

By default this will install it under `/usr/local/libexec`. To install in
another location, for example under `~/.local/libexec` run:

```
$ make prefix=~/.local install
```

Alternatively, you can leave the binary in this directory and point the
executable path to the `fsnotifier-ppc64le` file.

## Configuring JetBrains applications

After installing, add

```ini
idea.filewatcher.executable.path=/path/to/fsnotifier-ppc64le
```

to the `config/idea.properties` file in the relevant profile directory. You
can quickly access this from the 'Custom VM Options' command under the 'Help'
menu. Or, from the welcome screen, this can be edited in 'Custom VM Options'
command under the 'Configure' drop-down. More details are available
[here](https://www.jetbrains.com/help/idea/tuning-the-ide.html#configure-platform-properties).
