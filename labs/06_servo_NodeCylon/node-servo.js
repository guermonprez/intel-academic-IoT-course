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
    servo: { driver: 'servo', pin: 3 }
  },

  work: function(my) {
    var angle = 0;
    var safe  = 0;
    every((1).second(), function() {
	safe = my.servo.safeAngle(angle);
	my.servo.angle(angle);
	console.log("requested angle : "+angle);
	console.log("safe      angle : "+safe);
	console.log("");
	angle += 10 ;
	if (angle > 180) { angle = 0 ; }
    });

  }

}).start();
