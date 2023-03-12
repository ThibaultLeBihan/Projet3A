#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/thib/workspaceRos/src/plymouth_internship_2019"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/thib/workspaceRos/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/thib/workspaceRos/install/lib/python2.7/dist-packages:/home/thib/workspaceRos/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/thib/workspaceRos/build" \
    "/usr/bin/python" \
    "/home/thib/workspaceRos/src/plymouth_internship_2019/setup.py" \
     \
    build --build-base "/home/thib/workspaceRos/build/plymouth_internship_2019" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/thib/workspaceRos/install" --install-scripts="/home/thib/workspaceRos/install/bin"
