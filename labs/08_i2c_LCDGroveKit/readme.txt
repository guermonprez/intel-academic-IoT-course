# scan i2c
i2cdetect -l

# scan specific bus on galileo
i2cdetect -y -r 0
# scan specific bus on edison
i2cdetect -y -r 6
