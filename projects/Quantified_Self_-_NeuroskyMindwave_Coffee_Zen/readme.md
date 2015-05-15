# Intel Academic IoT Project - Quantified Self with Neurosky Mindwave

## Video :


## 1. ENABLE BT

```
rfkill unblock bluetooth
```

## 2. SCAN DEVICES

Remember to press the pair button when the scan is on.
The pairing PIN number is not asked for this simple device.
```
bluetoothctl
[bluetooth]# scan on
Discovery started
[CHG] Controller 98:4F:EE:03:12:BE Discovering: yes
[NEW] Device 74:E5:43:D5:77:AA MindWave 
[CHG] Device 74:E5:43:D5:77:AA Name: MindWave Mobile
[CHG] Device 74:E5:43:D5:77:AA Alias: MindWave Mobile
[bluetooth]# scan off
[CHG] Device 74:E5:43:D5:77:AA RSSI is nil
[CHG] Controller 98:4F:EE:03:12:BE Discovering: no
Discovery stopped
```

## 3. PAIRING

```
[bluetooth]# pair 74:E5:43:D5:77:AA
Attempting to pair with 74:E5:43:D5:77:AA
[CHG] Device 74:E5:43:D5:77:AA Connected: yes
[bluetooth]# exit
```

## 4. CREATE SERIAL PORT OVER BLUETOOTH

```
rfcomm bind 0 74:E5:43:D5:77:AA 1
ls /dev/rfcomm0
```
There is now a functionnal `/dev/rfcomm0`

## 5. NodeJS

See the NodeJS-Cylon code. To run the code locally :
```
node coffee_or_zen.js
```

## 6. Install as service

When you are ready to install the demo as a system service :
```
cp project_coffee_zen.service /lib/systemd/system
systemctl start project_coffee_zen
systemctl enable project_coffee_zen
systemctl reboot
```
Note : the path of the js file in hardcoded in the .service file, so change it if you installed your code elsewhere.

Note : the path for node modules is in the config file, for your information.

