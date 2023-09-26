#include <X11/Xlib.h>
#include <X11/Xatom.h>
#include <X11/Xresource.h>

double _glfwPlatformGetMonitorDPI(_GLFWmonitor* monitor)
{
    char *resourceString = XResourceManagerString(_glfw.x11.display);
    XrmDatabase db;
    XrmValue value;
    char *type = NULL;
    double dpi = 0.0;

    XrmInitialize(); /* Need to initialize the DB before calling Xrm* functions */

    db = XrmGetStringDatabase(resourceString);

    if (resourceString) {
        printf("Entire DB:\n%s\n", resourceString);
        if (XrmGetResource(db, "Xft.dpi", "String", &type, &value) == True) {
            if (value.addr) {
                dpi = atof(value.addr);
            }
        }
    }

    printf("DPI: %f\n", dpi);
    return dpi;
}
