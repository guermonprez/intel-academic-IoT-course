# Intel Academic IoT Project - Home Automation with X10, Marmitek CM11, Heyu and Domus

## Video :
<https://www.youtube.com/watch?v=ABq8UwHoHbo&list=PLFBM-eCNdj6A5VSmOEjpn8XoiM88398B7&index=14>

## 1. Software :

download from http://heyu.tanj.com/download/
```
tar -xvzf heyu-2.11-rc1.tar.gz ; cd heyu-2.11-rc1
./configure ; make ; make install
```

## 2. Hardware :

Plug CM11 on Edison USB port
```
lsusb
```
Bus 001 Device 007: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port
```
ls /dev/ttyUSB0
```
we have a serial port

## 3. Config :
```
mkdir -p /usr/local/var/tmp/heyu
mkdir -p /usr/local/var/lock
mkdir ~/.heyu
cp x10.conf ~/.heyu/x10config
```

## 4. Test :
```
heyu on A4
heyu off A4
heyu on light
heyu off light
```

## 5. Install NodeJS Domus module :
```
npm install -g domus_node
```
edit config file /usr/lib/node_modules/domus_node/config.js
and set :
```
exports.config=production_config;
```

copy sample config file :
```
mkdir /etc/heyu
cp x10.conf /etc/heyu/x10.conf
```

## 6. Run the server :
```
node /usr/lib/node_modules/domus_node/index.js
```
