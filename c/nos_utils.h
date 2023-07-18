#include <stdlib.h>
#include <sys/ioctl.h> // ioctl, TIOCGWINSZ

struct winsize get_screen_size();
unsigned short get_screen_width();
unsigned short get_screen_height();
void test_screen_size();
