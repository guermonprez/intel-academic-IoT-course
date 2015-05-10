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
// do not use the driver 'led',
// it's an advanced control with PWM,
// not a simple on/off switch
    led: { driver: 'direct-pin', pin: 7 },
    sensor: { driver: 'analog-sensor', pin: 0, lowerLimit: 0, upperLimit: 1100 }
  },

  work: function(my) {
    var analogValue = 0;
    every((1).second(), function() {
      analogValue = my.sensor.analogRead();
      console.log('analog read = %d',analogValue);
      if ( analogValue > 600 ) {
	my.led.digitalWrite(0);
        console.log('led is on !');
      } else {
	my.led.digitalWrite(1);
        console.log('led is off !');
      }
    });

  }

}).start();
