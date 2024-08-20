
#include <cstdio>
#include <cstdint>
#include <vector>
#include <bit>
#include <cmath>


#define WIDTH (256+256+256)
#define HEIGHT (256+256+128)
#define SIZE WIDTH*HEIGHT

extern "C"
{
	extern void render(float* data, int width, int height);
}
int main()
{

	std::vector<float> pixmap; pixmap.resize(SIZE);

	render(pixmap.data(), WIDTH, HEIGHT);

	struct col_t { uint8_t r, g, b; };

	col_t end = {127, 0, 0}, start = {0, 127, 127};
//	col_t end = {0, 0, 0}, start = {145, 145, 145};
	float diff_r = (float(end.r) - float(start.r));
	float diff_g = (float(end.g) - float(start.g));
	float diff_b = (float(end.b) - float(start.b));

	std::printf("P6\n%d %d\n255\n", WIDTH, HEIGHT);

//	std::printf("%f, %f, %f", diff_r, diff_g, diff_b);

	for(float i : pixmap)
	{
//		std::printf("%f ", i);
		col_t temp =
		{
		  start.r + (diff_r * std::pow(i, 1.0/3)),
		  start.g + (diff_g * std::pow(i, 1.0/3)),
		  start.b + (diff_b * std::pow(i, 1.0/3))
		};
		std::putchar(temp.r);
		std::putchar(temp.g);
		std::putchar(temp.b);
	}
/*
	for(int i = 0; i < WIDTH*HEIGHT; i++)
	{
		float progress = float(i)/(WIDTH*HEIGHT);
		std::putchar(start.r + (diff_r * progress));
		std::putchar(start.g + (diff_g * progress));
		std::putchar(start.b + (diff_b * progress));
	}*/

	return 0;
}
