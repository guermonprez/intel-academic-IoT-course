#! /bin/sh

export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"

echo -n "g++ compiles set_target.cpp.."
g++ -Wall -g `pkg-config --libs libusb-1.0` ./src/set_target.cpp -o ./bin/set_target
echo "Done!"
echo -n "g++ compiles set_speed.cpp..."
g++ -Wall -g `pkg-config --libs libusb-1.0` ./src/set_speed.cpp -o ./bin/set_speed
echo "Done!"
echo -n "g++ compiles set_accel.cpp..."
g++ -Wall -g `pkg-config --libs libusb-1.0` ./src/set_accel.cpp -o ./bin/set_accel
echo "Done!"
