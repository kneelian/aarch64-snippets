g++ host.cpp render2.s -std=c++20 -o host.out -Wno-narrowing && ./host.out > test.ppm && img2sixel test.ppm
