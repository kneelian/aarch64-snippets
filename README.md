# aarch64-snippets
Tiny code fragments in Aarch64 assembly

All code should be built with `gcc ./*.s -o a.out` or the equivalent for your device. All code has been tested on a Raspberry Pi 400 running an Arm Cortex-A72 CPU, but will likely work on arbitrary Cortex-A series CPUs with 64-bit support (so, any postdating the A32). Several fragments rely on the C standard library, primarily for input and output (depending on `stdio.h`), and so might not be appropriate for freestanding targets: when porting to a nonstandard platform, it will be necessary to supply library functions such as `printf` and `putchar` independently.
