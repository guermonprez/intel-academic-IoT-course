/* Author : Paul Guermonprez 2015
 * paul.guermonprez@intel.com
 * This work is licensed under a
 * Creative Commons Attribution-ShareAlike 3.0 Unported License.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

var Cylon = require('cylon');

Cylon.robot({

  connections: {
    edison: { adaptor: 'intel-iot' }
  },

  devices: {
    led:    { driver: 'led', pin: 4 },
    sensor: { driver: 'analog-sensor', pin: 0, lowerLimit: 0, upperLimit: 1100 },
    touch:  { driver: 'button', pin: 3 }
  },

  work: function(my) {
    var analogValue = 0;
    my.touch.on('push', function() {
      console.log('push');
      my.led.turnOn();

      analogValue = my.sensor.analogRead();
      console.log('analog read = %d',analogValue);
    });

    my.touch.on('release', function() {
      console.log('release');
      my.led.turnOff();

      analogValue = my.sensor.analogRead();
      console.log('analog read = %d',analogValue);
    });
  }

}).start();
