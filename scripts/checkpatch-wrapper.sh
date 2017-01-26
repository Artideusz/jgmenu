#!/bin/sh

cmd_args="--file --terse --no-tree --max-line-length=120"
cmd_args="${cmd_args} --strict"

if test $# -lt 1
then
	printf "%s\n" "Fatal: no file specified"
	exit 1
fi

for i in "$@"
do
	if test ${i} != "list.h" && test ${i} != "xpm-color-table.h"
	then
		printf "Checking ${i}\n"
		perl scripts/checkpatch.pl ${cmd_args} "${i}" \
			| grep -v -i \
			-e 'extern prototypes should be avoided' \
			-e 'Prefer kernel type' \
			-e '^total' \
			-e 'CamelCase.*AllocNone' \
			-e 'CamelCase.*Atom' \
			-e 'CamelCase.*Bool' \
			-e 'CamelCase.*ButtonPressMask' \
			-e 'CamelCase.*ButtonReleaseMask' \
			-e 'CamelCase.*Button1' \
			-e 'CamelCase.*Button3' \
			-e 'CamelCase.*Button4' \
			-e 'CamelCase.*Button5' \
			-e 'CamelCase.*ConnectionNumber' \
			-e 'CamelCase.*CopyFromParent' \
			-e 'CamelCase.*CurrentTime' \
			-e 'CamelCase.*CWOverrideRedirect' \
			-e 'CamelCase.*CWColormap' \
			-e 'CamelCase.*CWBackPixel' \
			-e 'CamelCase.*CWEventMask' \
			-e 'CamelCase.*CWBorderPixel' \
			-e 'CamelCase.*DefaultRootWindow' \
			-e 'CamelCase.*DefaultScreen' \
			-e 'CamelCase.*Display' \
			-e 'CamelCase.*DisplayHeight' \
			-e 'CamelCase.*DisplayWidth' \
			-e 'CamelCase.*EnterWindowMask' \
			-e 'CamelCase.*ExposureMask' \
			-e 'CamelCase.*False' \
			-e 'CamelCase.*FocusChangeMask' \
			-e 'CamelCase.*GdkPixbuf' \
			-e 'CamelCase.*GError' \
			-e 'CamelCase.*GrabModeAsync' \
			-e 'CamelCase.*GrabSuccess' \
			-e 'CamelCase.*KeyPressMask' \
			-e 'CamelCase.*KeySym' \
			-e 'CamelCase.*LSBFirst' \
			-e 'CamelCase.*LeaveWindowMask' \
			-e 'CamelCase.*MSBFirst' \
			-e 'CamelCase.*None' \
			-e 'CamelCase.*NoSymbol' \
			-e 'CamelCase.*PangoFontDescription' \
			-e 'CamelCase.*PangoLayout' \
			-e 'CamelCase.*PangoLayoutLine' \
			-e 'CamelCase.*PangoRectangle' \
			-e 'CamelCase.*Pixmap' \
			-e 'CamelCase.*PointerMotionMask' \
			-e 'CamelCase.*PointerRoot' \
			-e 'CamelCase.*RootWindow' \
			-e 'CamelCase.*Rsvg' \
			-e 'CamelCase.*Status' \
			-e 'CamelCase.*StructureNotifyMask' \
			-e 'CamelCase.*Success' \
			-e 'CamelCase.*True' \
			-e 'CamelCase.*TrueColor' \
			-e 'CamelCase.*Window' \
			-e 'CamelCase.*VisibilityChangeMask' \
			-e 'CamelCase.*VisibilityUnobscured' \
			-e 'CamelCase.*XBufferOverflow' \
			-e 'CamelCase.*XButtonPressedEvent' \
			-e 'CamelCase.*XCloseDisplay' \
			-e 'CamelCase.*XCopyArea' \
			-e 'CamelCase.*XCreateColormap' \
			-e 'CamelCase.*XCreateFontCursor' \
			-e 'CamelCase.*XCreateGC' \
			-e 'CamelCase.*XCreateIC' \
			-e 'CamelCase.*XCreatePixmap' \
			-e 'CamelCase.*XCreateWindow' \
			-e 'CamelCase.*XDefineCursor' \
			-e 'CamelCase.*XDestroyWindow' \
			-e 'CamelCase.*XErrorEvent' \
			-e 'CamelCase.*XEvent' \
			-e 'CamelCase.*XFree' \
			-e 'CamelCase.*XFreeGC' \
			-e 'CamelCase.*XFreePixmap' \
			-e 'CamelCase.*XGetInputFocus' \
			-e 'CamelCase.*XGetSelectionOwner' \
			-e 'CamelCase.*XGetWindowAttributes' \
			-e 'CamelCase.*XGrabPointer' \
			-e 'CamelCase.*XGrabKeyboard' \
			-e 'CamelCase.*XmbLookupString' \
			-e 'CamelCase.*XIMPreeditNothing' \
			-e 'CamelCase.*XIMStatusNothing' \
			-e 'CamelCase.*XInternAtom' \
			-e 'CamelCase.*XineramaScreenInfo' \
			-e 'CamelCase.*XineramaQueryScreens' \
			-e 'CamelCase.*XKeyEvent' \
			-e 'CamelCase.*XMapRaised' \
			-e 'CamelCase.*XMatchVisualInfo' \
			-e 'CamelCase.*xmlCleanupParser' \
			-e 'CamelCase.*xmlDoc' \
			-e 'CamelCase.*xmlDocGetRootElement' \
			-e 'CamelCase.*xmlFreeDoc' \
			-e 'CamelCase.*xmlNode' \
			-e 'CamelCase.*xmlReadFile' \
			-e 'CamelCase.*XNClientWindow' \
			-e 'CamelCase.*XNextEvent' \
			-e 'CamelCase.*XNFocusWindow' \
			-e 'CamelCase.*XNInputStyle' \
			-e 'CamelCase.*XOpenDisplay' \
			-e 'CamelCase.*XOpenIM' \
			-e 'CamelCase.*XPending' \
			-e 'CamelCase.*XQueryPointer' \
			-e 'CamelCase.*XQueryTree' \
			-e 'CamelCase.*XSetErrorHandler' \
			-e 'CamelCase.*XSetting' \
			-e 'CamelCase.*XSettingsBuffer' \
			-e 'CamelCase.*XSettingsColor' \
			-e 'CamelCase.*XUngrabKeyboard' \
			-e 'CamelCase.*XUngrabPointer' \
			-e 'CamelCase.*XVisualInfo' \
			-e 'CamelCase.*XWindowAttributes'
	fi
done

rm -f .checkpatch-camelcase.git. 2>/dev/null