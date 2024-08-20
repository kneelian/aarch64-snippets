# Mandelbrot renderer

This category contains the source files to two Mandelbrot set renderers. The first one, in `render.s`, is a standalone assembly file generating a textual representation of the Mandelbrot. The second one, in `host.cpp` and `render2.s`, contains an assemlby renderer (slight edit of the first renderer) that writes to a vector provided by the wrapper CPP code.

The script `build.sh` builds the second renderer, runs it to produce a binary PPM file, and displays that file in one command, to aid development speed. Built with GCC 11.3 on Raspi 400.
