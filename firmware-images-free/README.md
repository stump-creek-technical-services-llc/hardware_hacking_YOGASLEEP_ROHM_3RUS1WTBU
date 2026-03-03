# firmware-free

This directory is for firmware images confirmed to be FOSS.

## `make firmware`

`make firmware` generates a free firmware,
expected to be compatible with the device.

This firmware contains a single VFAT filesystem.
When the firmware is generated,
it will copy files from the `files` directory into the firmware filesystem.

The files will need to be agreeable to the destination filesystem.
See the [mtools docs](https://www.gnu.org/software/mtools/manual/mtools.html#long-names) for some details.
In general dotfiles (`.*`) don't seem to get copied,
but that's at least partly due to wildcard expansion in the Linux shell.
You might be able to copy them in directly,
in which case your command line might be something like:

```shell
mcopy -i output/firmware-free.bin -pms YOURFILE ::/
```

The flash chip is only 2 MiB, so keep the files small.
It's unknown at this time whether the device can accept a larger flash chip and filesystem.

## Writing to ROM

```shell
flashrom -p serprog:dev=/dev/serial/by-id/usb-Raspberry_Pi_Pico_E660583883926031-if00 -c ZB25VQ16 -w firmware-free.bin
```

## Alternative Audio

* https://www.jimcarreyonline.com/soundclips/dd/annoysnd.wav
* https://elevenlabs.io/sound-effects/screaming-goat
  * https://eleven-public-cdn.elevenlabs.io/payloadcms/0ko1d4q513jc-screaming-goat-sfx-0.mp3
