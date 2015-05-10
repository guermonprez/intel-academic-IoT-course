/* Author : Paul Guermonprez 2015
 * paul.guermonprez@intel.com
 * This work is licensed under a
 * Creative Commons Attribution-ShareAlike 3.0 Unported License.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

var LCD  = require('jsupm_i2clcd');
var groveLCD = new LCD.Jhd1313m1(0, 0x3E, 0x62);
// param 1 : bus - i2c bus to use
// param 2 : address - the slave address the lcd is registered on
// param 3 : address - the slave address the rgb backlight is on

groveLCD.clear();
groveLCD.home();
groveLCD.write("Line 1");
groveLCD.setCursor(1,0);
groveLCD.write("Line 2");
