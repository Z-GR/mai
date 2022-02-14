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

echo_and_run cd "/home/ma1/catkin_ws/src/image_common/camera_calibration_parsers"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ma1/catkin_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ma1/catkin_ws/install/lib/python3/dist-packages:/home/ma1/catkin_ws/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ma1/catkin_ws/build" \
    "/usr/bin/python3" \
    "/home/ma1/catkin_ws/src/image_common/camera_calibration_parsers/setup.py" \
    egg_info --egg-base /home/ma1/catkin_ws/build/image_common/camera_calibration_parsers \
    build --build-base "/home/ma1/catkin_ws/build/image_common/camera_calibration_parsers" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/ma1/catkin_ws/install" --install-scripts="/home/ma1/catkin_ws/install/bin"